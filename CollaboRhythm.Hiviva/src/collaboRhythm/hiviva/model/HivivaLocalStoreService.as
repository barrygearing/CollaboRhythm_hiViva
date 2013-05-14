package collaboRhythm.hiviva.model
{
	import collaboRhythm.hiviva.global.LocalDataStoreEvent;
	import collaboRhythm.hiviva.vo.AppDataVO;

	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.SQLEvent;
	import flash.filesystem.File;

	public class HivivaLocalStoreService extends EventDispatcher
	{
		public static const APP_FIRST_TIME_USE:String					= "appFirstTimeUse";
		public static const USER_APP_TYPE_PATIENT:String = "Patient";
		public static const USER_APP_TYPE_HCP:String = "HCP";

		private var _sqStatement:SQLStatement;
		private var _sqConn:SQLConnection;
		private var _appDataVO:AppDataVO;

		private var _medicationSchedule:Array;

		public function HivivaLocalStoreService()
		{

		}

		public function initDataLoad():void
		{
			var localSettingsFile:File = File.applicationStorageDirectory;
			localSettingsFile = localSettingsFile.resolvePath("settings.sqlite");
			if(localSettingsFile.exists)
			{
				loadAppData();
			} else
			{
				createUserSettingsDatabase();
			}
		}

		private function loadAppData():void
		{
			trace("Load User Data");

			var dbFile:File = File.applicationStorageDirectory;
			dbFile = dbFile.resolvePath("settings.sqlite");

			this._sqConn = new SQLConnection();
			this._sqConn.addEventListener(SQLEvent.OPEN, dataFileOpenHandler);
			this._sqConn.open(dbFile);

		}

		private function dataFileOpenHandler(e:SQLEvent):void
		{
			this._sqStatement = new SQLStatement();
			this._sqStatement.text = "SELECT * FROM app_settings";
			this._sqStatement.sqlConnection = this._sqConn;
			this._sqStatement.execute();

			_appDataVO = new AppDataVO();

			try
			{
				_appDataVO._userAppType = this._sqStatement.getResult().data[0].profile_type;
			}
			catch(e:Error)
			{
				_appDataVO._userAppType = HivivaLocalStoreService.APP_FIRST_TIME_USE;
			}

			// TODO: remove this check when HCP is working; HCP is not supported yet
			if (_appDataVO._userAppType == USER_APP_TYPE_HCP)
				_appDataVO._userAppType = HivivaLocalStoreService.APP_FIRST_TIME_USE;

			var evt:LocalDataStoreEvent = new LocalDataStoreEvent(LocalDataStoreEvent.DATA_LOAD_COMPLETE);
			evt.message = "dataLoaded";
			dispatchEvent(evt);
		}

		private function sqlResultHandler(e:SQLEvent):void
		{
			trace("sqlResultHandler " + e);
		}

		private function createUserSettingsDatabase():void
		{
			trace("create local user settings file");

			var sourceFile:File = File.applicationDirectory;
			sourceFile = sourceFile.resolvePath("resources/settings.sqlite");

			var destination:File = File.applicationStorageDirectory;
			destination = destination.resolvePath("settings.sqlite");

			sourceFile.copyTo(destination);

			_appDataVO = new AppDataVO();
			_appDataVO._userAppType = HivivaLocalStoreService.APP_FIRST_TIME_USE;

			var evt:LocalDataStoreEvent = new LocalDataStoreEvent(LocalDataStoreEvent.DATA_LOAD_COMPLETE);
			evt.message = HivivaLocalStoreService.APP_FIRST_TIME_USE;
			dispatchEvent(evt);
		}

		public function updateAppProfileType(data:String):void
		{
			appDataVO._userAppType = data;

			var dbFile:File = File.applicationStorageDirectory;
			dbFile = dbFile.resolvePath("settings.sqlite");

			this._sqConn = new SQLConnection();
			this._sqConn.open(dbFile);

			this._sqStatement = new SQLStatement();
			this._sqStatement.text = "INSERT INTO app_settings ('profile_type') VALUES ('" + data + "') ";
			this._sqStatement.sqlConnection = this._sqConn;
			this._sqStatement.addEventListener(SQLEvent.RESULT, sqlResultHandler);
			this._sqStatement.execute();

		}

		public function getMedicationList():void
		{
			var dbFile:File = File.applicationStorageDirectory;
			dbFile = dbFile.resolvePath("settings.sqlite");

			this._sqConn = new SQLConnection();
			this._sqConn.open(dbFile);

			this._sqStatement = new SQLStatement();
			this._sqStatement.sqlConnection = this._sqConn;
			this._sqStatement.text = "SELECT * FROM medications";
			this._sqStatement.addEventListener(SQLEvent.RESULT, getMedicationsResultHandler);
			this._sqStatement.execute();
		}

		private function getMedicationsResultHandler(e:SQLEvent):void
		{
			var result:Array = this._sqStatement.getResult().data;
			trace("sqlResultHandler " + e);
			var evt:LocalDataStoreEvent = new LocalDataStoreEvent(LocalDataStoreEvent.MEDICATIONS_LOAD_COMPLETE);
			evt.data.medications = result;
			this.dispatchEvent(evt);
		}

		public function setMedicationList(medicationSchedule:Array , medicationName:String):void
		{
			_medicationSchedule = medicationSchedule;

			var dbFile:File = File.applicationStorageDirectory;
			dbFile = dbFile.resolvePath("settings.sqlite");

			this._sqConn = new SQLConnection();
			this._sqConn.open(dbFile);

			this._sqStatement = new SQLStatement();
			this._sqStatement.sqlConnection = this._sqConn;
			this._sqStatement.text =  "INSERT INTO medications ('medication_name') VALUES ('" + medicationName + "') ";
			this._sqStatement.addEventListener(SQLEvent.RESULT, setMedicationsResultHandler);
			this._sqStatement.execute();

		}

		private function setMedicationsResultHandler(e:SQLEvent):void
		{
			var lastInsertRowID:Number = this._sqStatement.getResult().lastInsertRowID;

			var dbFile:File = File.applicationStorageDirectory;
			dbFile = dbFile.resolvePath("settings.sqlite");

			this._sqConn = new SQLConnection();
			this._sqConn.open(dbFile);

			this._sqStatement = new SQLStatement();
			this._sqStatement.sqlConnection = this._sqConn;
			this._sqStatement.text = "";

			var medicationLoop:uint = _medicationSchedule.length;
			for (var i:uint = 0; i < medicationLoop; i++)
			{
				if (i == 0)
				{
					this._sqStatement.text += "INSERT INTO medication_schedule ('time' , 'tablet_count' , 'medication_id') SELECT '" +
							_medicationSchedule[i].time + "', '" + _medicationSchedule[i].count + "' , " + lastInsertRowID + "";
				}
				else
				{
					this._sqStatement.text += " UNION SELECT '" + _medicationSchedule[i].time + "', '" +
							_medicationSchedule[i].count + "' , "+ lastInsertRowID +"";
				}
			}
			this._sqStatement.addEventListener(SQLEvent.RESULT, setMedicationsScheduleResultHandler);
			this._sqStatement.execute();
		}

		private function setMedicationsScheduleResultHandler(e:SQLEvent):void
		{
			var evt:LocalDataStoreEvent = new LocalDataStoreEvent(LocalDataStoreEvent.MEDICATIONS_SAVE_COMPLETE);
			this.dispatchEvent(evt);
		}

		public function resetApplication():void
		{
			var dbFile:File = File.applicationStorageDirectory;
			dbFile = dbFile.resolvePath("settings.sqlite");

			this._sqConn = new SQLConnection();
			this._sqConn.open(dbFile);

			this._sqStatement = new SQLStatement();
			this._sqStatement.text = "DELETE FROM app_settings";
			this._sqStatement.sqlConnection = this._sqConn;
			this._sqStatement.addEventListener(SQLEvent.RESULT, sqlResultHandler);
			this._sqStatement.execute();

			_appDataVO = null;
			_appDataVO = new AppDataVO();
			_appDataVO._userAppType = HivivaLocalStoreService.APP_FIRST_TIME_USE;
		}


		public function get appDataVO ():AppDataVO
		{
			return _appDataVO;
		}

	}
}

package collaboRhythm.hiviva.view.screens.hcp
{
	import collaboRhythm.hiviva.global.HivivaScreens;
	import collaboRhythm.hiviva.view.*;

	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;


	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.core.PopUpManager;
	import feathers.core.ToggleGroup;
	import feathers.layout.VerticalLayout;

	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLEvent;

	import flash.filesystem.File;

	import flash.text.TextFormat;

	import mx.core.ByteArrayAsset;

	import starling.display.DisplayObject;

	import starling.events.Event;


	public class HivivaHCPConnectToPatientScreen extends Screen
	{
		private var _header:HivivaHeader;
		private var _patientCellContainer:ScrollContainer;
		private var _addConnectionButton:Button;
		private var _patientConnected:Boolean;
		private var _deletePopupContainer:HivivaPopUp;
		private var _backButton:Button;
		private var _patientCellRadioGroup:ToggleGroup;
		private var _appIdLabel:Label;
		private var _searchInput:TextInput;
		private var _searchButton:Button;
		private var _resultInfo:Label;
		private var _patientFilteredList:Array;
		private var _sqConn:SQLConnection;
		private var _sqStatement:SQLStatement;

		private const PADDING:Number = 20;

		public function HivivaHCPConnectToPatientScreen()
		{

		}

		override protected function draw():void
		{
			super.draw();
			this._header.width = this.actualWidth;
			this._header.height = 110 * this.dpiScale;
			// reduce font size for large title
			this._header._titleHolder1.textRendererProperties.textFormat = new TextFormat("ExoBold", Math.round(36 * this.dpiScale), 0x293d54);
			this._header._titleHolder2.textRendererProperties.textFormat = new TextFormat("ExoLight", Math.round(36 * this.dpiScale), 0x293d54);
			this._header.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;
			this._header.validate();

			this._addConnectionButton.validate();
			this._addConnectionButton.x = (this.actualWidth / 2) - (this._addConnectionButton.width / 2);
			this._addConnectionButton.y = this.actualHeight - this._addConnectionButton.height - (PADDING * this.dpiScale);

			drawResults();

			this._deletePopupContainer.width = 500 * dpiScale;
			this._deletePopupContainer.validate();

			this._backButton.validate();
		}

		override protected function initialize():void
		{
			super.initialize();

			this._header = new HivivaHeader();
			this._header.title = "Connected patients";
			addChild(this._header);

			this._patientCellContainer = new ScrollContainer();

			this._addConnectionButton = new Button();
			this._addConnectionButton.label = "Request Connection";
			addChild(this._addConnectionButton);
			this._addConnectionButton.addEventListener(Event.TRIGGERED, onAddConnection);
			this._addConnectionButton.visible = false;

			initResults();

			this._deletePopupContainer = new HivivaPopUp();
			this._deletePopupContainer.scale = this.dpiScale;
			this._deletePopupContainer.confirmLabel = "Delete";
			this._deletePopupContainer.addEventListener(Event.COMPLETE, closePopup);
			this._deletePopupContainer.addEventListener(Event.CLOSE, closePopup);

			this._backButton = new Button();
			this._backButton.name = "back-button";
			this._backButton.label = "Back";
			this._backButton.addEventListener(Event.TRIGGERED, backBtnHandler);

			this._header.leftItems = new <DisplayObject>[_backButton];
		}

		private function backBtnHandler(e:Event = null):void
		{
			if(contains(this._patientCellContainer))
			{
				this._patientCellRadioGroup.removeAllItems();
				this._patientCellContainer.removeChildren();
			}

			this.owner.showScreen(HivivaScreens.HCP_PROFILE_SCREEN);
		}

		private function initResults():void
		{
			var resultsLength:int = this._patientFilteredList.length,
				currItem:XMLList,
				patientCell:PatientResultCell;

			if(resultsLength > 0)
			{
				if(!contains(this._patientCellContainer))
				{
					this._patientCellRadioGroup = new ToggleGroup();
					addChild(this._patientCellContainer);
				}
				else
				{
					this._patientCellRadioGroup.removeAllItems();
					this._patientCellContainer.removeChildren();
				}
				for(var listCount:int = 0; listCount < resultsLength; listCount++)
				{
					currItem = XMLList(this._patientFilteredList[listCount]);

					patientCell = new PatientResultCell();
					patientCell.patientData = currItem;
					patientCell.isResult = false;
					patientCell.scale = this.dpiScale;
					patientCell.addEventListener(Event.CLOSE, deleteHcpRecord);
					patientCell.addEventListener(Event.REMOVED_FROM_STAGE, deleteHcpCell);
					this._patientCellContainer.addChild(patientCell);
					this._patientCellRadioGroup.addItem(patientCell._patientSelect);
				}
			}
		}

		private function drawResults():void
		{
			var scaledPadding:Number = PADDING * this.dpiScale,
				yStartPosition:Number,
				maxHeight:Number,
				patientCell:PatientResultCell;

			yStartPosition = this._resultInfo.y + this._resultInfo.height + scaledPadding;
			maxHeight = this.actualHeight - yStartPosition;

			this._patientCellContainer.width = this.actualWidth;
			this._patientCellContainer.y = yStartPosition;
			this._patientCellContainer.height = maxHeight;

			for (var i:int = 0; i < this._patientCellContainer.numChildren; i++)
			{
				patientCell = this._patientCellContainer.getChildAt(i) as PatientResultCell;
				patientCell.width = this.actualWidth;
			}

			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = scaledPadding;
			this._patientCellContainer.layout = layout;

			this._patientCellContainer.validate();
		}

		private function onAddConnection(e:Event):void
		{
			var selectedHcpInd:int = this._patientCellRadioGroup.selectedIndex,
				patientCell:XMLList = XMLList(this._patientFilteredList[selectedHcpInd]);

			var dbFile:File = File.applicationStorageDirectory;
			dbFile = dbFile.resolvePath("settings.sqlite");

			this._sqConn = new SQLConnection();
			this._sqConn.open(dbFile);

			this._sqStatement = new SQLStatement();

			var name:String = "'" + patientCell.name + "'";
			var email:String = "'" + patientCell.email + "'";
			var appid:String = "'" + patientCell.appid + "'";
			var picture:String = "'" + patientCell.picture + "'";
			if(this._patientConnected)
			{
				this._sqStatement.text = "UPDATE patient_connection SET name=" + name + ", email=" + email + ", appid=" + appid + ", picture=" + picture;
			}
			else
			{
				this._sqStatement.text = "INSERT INTO patient_connection (name, email, appid, picture) VALUES (" + name + ", " + email + ", " + appid + ", " + picture + ")";
			}
			trace(this._sqStatement.text);
			this._sqStatement.sqlConnection = this._sqConn;
			this._sqStatement.addEventListener(SQLEvent.RESULT, sqlResultHandler);
			this._sqStatement.execute();

			this._deletePopupContainer.message = "A request to connect has been sent to " + patientCell.name;
			showRequestPopup();
		}

		private function sqlResultHandler(e:SQLEvent):void
		{
			trace("sqlResultHandler " + e);
		}

		private function populateOldData():void
		{
			var dbFile:File = File.applicationStorageDirectory;
			dbFile = dbFile.resolvePath("settings.sqlite");

			this._sqConn = new SQLConnection();
			this._sqConn.open(dbFile);

			this._sqStatement = new SQLStatement();
			this._sqStatement.text = "SELECT * FROM patient_connection";
			this._sqStatement.sqlConnection = this._sqConn;
			this._sqStatement.execute();

			var data:Array = this._sqStatement.getResult().data,
				dataLength:int;

			this._patientFilteredList = [];
			try
			{
				if(data != null)
				{
					dataLength = data.length;
					for (var i:int = 0; i < dataLength; i++)
					{
						this._patientFilteredList.push(	XML("<patient><name>" + data[i].name +
															"</name><email>" + data[i].email +
															"</email><appid>" + data[i].appid +
															"</appid><picture>" + data[i].picture +
															"</picture></patient>"))
					}

				}
			}
			catch(e:Error)
			{

			}
		}

		private function showRequestPopup():void
		{
			PopUpManager.addPopUp(this._deletePopupContainer,true,true);
			this._deletePopupContainer.validate();
			PopUpManager.centerPopUp(this._deletePopupContainer);
			// draw close button post center so the centering works correctly
			this._deletePopupContainer.drawCloseButton();
		}

		private function closePopup(e:Event):void
		{
			PopUpManager.removePopUp(this._deletePopupContainer);

			var dbFile:File = File.applicationStorageDirectory;
			dbFile = dbFile.resolvePath("settings.sqlite");

			this._sqConn = new SQLConnection();
			this._sqConn.open(dbFile);

			this._sqStatement = new SQLStatement();
			this._sqStatement.text = "DELETE FROM patient_connection WHERE appid=" + patientCell._appid;

			// deletes all records because we only have one connection at a time
			//this._sqStatement.text = "DELETE FROM patient_connection";
			this._sqStatement.sqlConnection = this._sqConn;
			this._sqStatement.execute();
		}

		private function deleteHcpRecord(e:Event):void
		{
			var patientCell:PatientResultCell = e.target as PatientResultCell;

			this._deletePopupContainer.message = "This will delete your connection with " + patientCell.name;
			showRequestPopup();
		}

		private function deleteHcpCell(e:Event):void
		{
			var hcpResultCell:PatientResultCell = e.target as PatientResultCell;
			hcpResultCell.dispose();
		}
	}
}

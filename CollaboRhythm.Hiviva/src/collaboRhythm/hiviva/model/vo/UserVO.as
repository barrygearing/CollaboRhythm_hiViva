package collaboRhythm.hiviva.model.vo
{
	public class UserVO
	{

		private var _appId:String;
		private var _guid:String;
		private var _type:String;
		private var _serverDate:Date;
		private var _badges:XMLList;
		private var _fullName:String;

		public function UserVO()
		{
		}

		public function set appId(value:String):void
		{
			this._appId = value;
		}

		public function get appId():String
		{
			return this._appId;
		}

		public function set guid(value:String):void
		{
			this._guid = value;
		}

		public function get guid():String
		{
			return this._guid;
		}

		public function set type(value:String):void
		{
			this._type = value;
		}

		public function get type():String
		{
			return this._type;
		}

		public function get serverDate():Date
		{
			return _serverDate;
		}

		public function set serverDate(value:Date):void
		{
			_serverDate = value;
//			var timezoneOffset:Number = _serverDate.getTimezoneOffset();
//			_serverDate.minutes -= timezoneOffset;
			trace("current time = " + _serverDate.toTimeString());
			trace("current date = " + _serverDate.toDateString());
		}

		public function get badges():XMLList
		{
			return _badges;
		}

		public function set badges(value:XMLList):void
		{
			_badges = value;
		}

		public function get fullName():String
		{
			return _fullName;
		}

		public function set fullName(value:String):void
		{
			_fullName = value;
		}
	}
}

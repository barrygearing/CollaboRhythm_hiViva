package collaboRhythm.hiviva.view
{

	import collaboRhythm.hiviva.controller.HivivaApplicationController;
	import collaboRhythm.hiviva.global.LocalDataStoreEvent;
	import collaboRhythm.hiviva.view.media.Assets;

	import feathers.controls.Screen;

	import starling.display.Image;

	public class HivivaPatientPillboxScreen extends Screen
	{

		private var _pillBox:Image;
		private var IMAGE_SIZE:Number;

		private var _usableHeight:Number;
		private var _footerHeight:Number;
		private var _headerHeight:Number;
		private var _applicationController:HivivaApplicationController;

		public function HivivaPatientPillboxScreen()
		{

		}

		override protected function draw():void
		{

			IMAGE_SIZE = this.actualWidth * 0.9;

			this._usableHeight = this.actualHeight - footerHeight - headerHeight;
			this._pillBox.width = IMAGE_SIZE;
			this._pillBox.scaleY = this._pillBox.scaleX;

			this._pillBox.x = (this.actualWidth * 0.5) - (this._pillBox.width * 0.5);
			this._pillBox.y = (this._usableHeight * 0.5) + headerHeight - (this._pillBox.height * 0.5);
			initPillboxMedication();
		}

		override protected function initialize():void
		{
			this._pillBox = new Image(Assets.getTexture("PillboxPng"));
			addChild(this._pillBox);
		}

		private function initPillboxMedication():void
		{
			trace("initPillboxMedication pillbox height" + this._pillBox.height);
			applicationController.hivivaLocalStoreController.addEventListener(LocalDataStoreEvent.MEDICATIONS_SCHEDULE_LOAD_COMPLETE , medicationLoadCompleteHandler);
			applicationController.hivivaLocalStoreController.getMedicationsSchedule()

		}

		private function medicationLoadCompleteHandler(e:LocalDataStoreEvent):void
		{
			applicationController.hivivaLocalStoreController.removeEventListener(LocalDataStoreEvent.MEDICATIONS_SCHEDULE_LOAD_COMPLETE , medicationLoadCompleteHandler)
			trace(e.data.medicationSchedule);
		}

		public function get applicationController():HivivaApplicationController
		{
			return _applicationController;
		}

		public function set applicationController(value:HivivaApplicationController):void
		{
			_applicationController = value;
		}



		public function get footerHeight():Number
		{
			return _footerHeight;
		}

		public function set footerHeight(value:Number):void
		{
			_footerHeight = value;
		}

		public function get headerHeight():Number
		{
			return _headerHeight;
		}

		public function set headerHeight(value:Number):void
		{
			_headerHeight = value;
		}
	}
}

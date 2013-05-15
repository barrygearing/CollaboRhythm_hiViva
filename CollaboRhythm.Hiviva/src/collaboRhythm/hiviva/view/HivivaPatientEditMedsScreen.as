package collaboRhythm.hiviva.view
{

	import collaboRhythm.hiviva.controller.HivivaApplicationController;
	import collaboRhythm.hiviva.controller.HivivaLocalStoreController;
	import collaboRhythm.hiviva.global.HivivaScreens;
	import collaboRhythm.hiviva.global.LocalDataStoreEvent;

	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.data.ListCollection;
	import feathers.data.ListCollection;

	import starling.display.DisplayObject;
	import starling.display.Sprite;

	import starling.events.Event;

	public class HivivaPatientEditMedsScreen extends Screen
	{
		private var _header:HivivaHeader;
		private var _applicationController:HivivaApplicationController;
		private var _backButton:Button;
		private var _addMedBtn:Button;
		private var _medications:Array;
		private var _medicationListCollection:ListCollection;


		public function HivivaPatientEditMedsScreen()
		{
		}

		override protected function draw():void
		{
			super.draw();
			this._header.width = this.actualWidth;
			this._header.height = 110 * this.dpiScale;

			checkMedicationsExist();
		}

		override protected function initialize():void
		{

			super.initialize();
			this._header = new HivivaHeader();
			this._header.title = "Enter your Regimen";
			this.addChild(this._header);

			this._backButton = new Button();
			this._backButton.name = "back-button";
			this._backButton.label = "Back";
			this._backButton.addEventListener(starling.events.Event.TRIGGERED, backBtnHandler);

			this._header.leftItems = new <DisplayObject>[_backButton];
		}

		private function backBtnHandler(e:starling.events.Event):void
		{
			this.owner.showScreen(HivivaScreens.PATIENT_PROFILE_SCREEN);
		}

		private function checkMedicationsExist():void
		{
			localStoreController.addEventListener(LocalDataStoreEvent.MEDICATIONS_LOAD_COMPLETE , medicationsLoadCompleteHandler );
			localStoreController.getMedicationList();
		}

		private function medicationsLoadCompleteHandler(e:LocalDataStoreEvent):void
		{
			trace("medicationsLoadCompleteHandler " + e.data.medications);
			this._medications = e.data.medications;
			localStoreController.removeEventListener(LocalDataStoreEvent.MEDICATIONS_LOAD_COMPLETE,	medicationsLoadCompleteHandler);
			if (this._medications != null)
			{
				populateMedications();
			}
			else
			{
				initEditMedications();
			}
		}

		private function populateMedications():void
		{

			var medicationsLoop:uint = this._medications.length;
			var medicationHolder:Sprite = new Sprite();
			medicationHolder.y = this._header.height + 20;
			this.addChild(medicationHolder);

			for (var i:uint = 0; i < medicationsLoop; i++)
			{
				var medicationName:Label = new Label();
				medicationName.text = this._medications[i].medication_name;
				medicationName.x = 10;
				medicationName.y = i * 70;
				medicationName.width = this.actualWidth;
				medicationHolder.addChild(medicationName);
				medicationName.validate();

				var takeMedicationCheck:Check = new Check();

				takeMedicationCheck.y = medicationName.y
				medicationHolder.addChild(takeMedicationCheck);
				takeMedicationCheck.validate();
				takeMedicationCheck.x = this.actualWidth - takeMedicationCheck.width - 20;

			}

			/*
			var medicationList:List = new List();
			medicationList.dataProvider = new ListCollection(this._medications);
			medicationList.itemRendererProperties.labelField = "medication_name";
			medicationList.y = this._header.height + 10;
			medicationList.width = this.actualWidth;

			this.addChild(medicationList);
			medicationList.validate();
			*/

			createAddMedButton(medicationHolder.height + medicationHolder.y + 40);
		}

		private function initEditMedications():void
		{
			createAddMedButton(130);
		}

		private function createAddMedButton(yloc:Number):void
		{
			this._addMedBtn = new Button();
			this._addMedBtn.label = "Add a medicine";
			this._addMedBtn.addEventListener(starling.events.Event.TRIGGERED, addMedBtnHandler);
			this._addMedBtn.y = yloc;
			this._addMedBtn.x = 10;
			this.addChild(this._addMedBtn);
		}

		private function addMedBtnHandler(e:starling.events.Event):void
		{
			this.owner.showScreen(HivivaScreens.PATIENT_ADD_MEDICATION_SCREEN);
		}

		public function get localStoreController():HivivaLocalStoreController
		{
			return applicationController.hivivaLocalStoreController;
		}

		public function get applicationController():HivivaApplicationController
		{
			return _applicationController;
		}

		public function set applicationController(value:HivivaApplicationController):void
		{
			_applicationController = value;
		}



	}
}

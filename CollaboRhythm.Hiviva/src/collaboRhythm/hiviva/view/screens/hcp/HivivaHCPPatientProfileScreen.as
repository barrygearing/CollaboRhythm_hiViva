package collaboRhythm.hiviva.view.screens.hcp
{
	import collaboRhythm.hiviva.controller.HivivaApplicationController;
	import collaboRhythm.hiviva.controller.HivivaLocalStoreController;
	import collaboRhythm.hiviva.global.FeathersScreenEvent;
	import collaboRhythm.hiviva.global.HivivaAssets;
	import collaboRhythm.hiviva.global.HivivaScreens;
	import collaboRhythm.hiviva.global.HivivaThemeConstants;
	import collaboRhythm.hiviva.utils.HivivaModifier;
	import collaboRhythm.hiviva.utils.HivivaModifier;
	import collaboRhythm.hiviva.view.*;
	import collaboRhythm.hiviva.view.components.BoxedButtons;
	import collaboRhythm.hiviva.view.components.MedicationCell;
	import collaboRhythm.hiviva.view.components.PatientAdherenceTable;
	import collaboRhythm.hiviva.view.media.Assets;
	import collaboRhythm.hiviva.view.screens.hcp.messages.HivivaHCPMessageCompose;
	import collaboRhythm.hiviva.view.screens.hcp.messages.HivivaHCPPatientMessageCompose;

	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientReportsScreen;

	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.ScrollContainer;
	import feathers.display.Scale9Image;
	import feathers.layout.TiledColumnsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Matrix;

	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import starling.display.BlendMode;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;

	import starling.textures.Texture;


	public class HivivaHCPPatientProfileScreen extends Screen
	{
		private var _header:HivivaHeader;
		private var _backButton:Button;

		private var _patientImageBg:Quad;
		private var _photoHolder:Image;
		private var _spoofData:Image;
		private var _patientEmail:Label;
		private var _patientData:XML;
		private var _adherenceLabel:Label;
		private var _tolerabilityLabel:Label;
		private var _generateReportBtn:Button;
		private var _sendMessageBtn:Button;
		private var _reportAndMessage:BoxedButtons;


		private const IMAGE_SIZE:Number = 125;
		private const PADDING:Number = 32;

		public function HivivaHCPPatientProfileScreen()
		{

		}

		override protected function draw():void
		{
			super.draw();
			this._header.width = this.actualWidth;
			this._header.initTrueTitle();

			initPatientXMLData();
		}

		override protected function initialize():void
		{
			super.initialize();
			this._header = new HivivaHeader();
			this._header.title = Main.selectedHCPPatientProfile.name;
			this.addChild(this._header);

			this._backButton = new Button();
			this._backButton.name = "back-button";
			this._backButton.label = "Back";
			this._backButton.addEventListener(starling.events.Event.TRIGGERED, backBtnHandler);

			this._header.leftItems = new <DisplayObject>[_backButton];
		}

		private function initPatientXMLData():void
		{
			var patientToLoadURL:String = "/resources/patient_" +  Main.selectedHCPPatientProfile.appID + ".xml";
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(flash.events.Event.COMPLETE , patientXMLFileLoadHandler);
			loader.load(new URLRequest(patientToLoadURL));
		}

		private function patientXMLFileLoadHandler(e:flash.events.Event):void
		{
			_patientData = XML(e.target.data);
			drawPatientProfile();

		}

		private function drawPatientProfile():void
		{
			var scaledPadding:Number = PADDING * this.dpiScale;
			var gap:Number = scaledPadding * 0.5;

			this._patientImageBg = new Quad(IMAGE_SIZE * this.dpiScale, IMAGE_SIZE * this.dpiScale, 0x000000);
			this._patientImageBg.touchable = false;
			this.addChild(this._patientImageBg);

			var innerWidth:Number = this.actualWidth - (scaledPadding * 2);


			this._patientImageBg.x = scaledPadding;
			this._patientImageBg.y = this._header.height + gap;

			this._patientEmail = new Label();
			this._patientEmail.text = _patientData.email;
			this.addChild(this._patientEmail);

			this._patientEmail.width = innerWidth - this._patientEmail.x;
			this._patientEmail.validate();
			this._patientEmail.x = this._patientImageBg.x + this._patientImageBg.width + gap;
			this._patientEmail.y = this._patientImageBg.y;

			var avgAdherence:Number = HivivaModifier.calculateOverallAdherence(_patientData.medicationHistory.history);
			this._adherenceLabel = new Label();
			this._adherenceLabel.name = HivivaThemeConstants.BODY_BOLD_LABEL;
			this._adherenceLabel.text = "Overall adherence:  " + String(avgAdherence) + "%";
			this.addChild(this._adherenceLabel);

			this._adherenceLabel.width = innerWidth - this._adherenceLabel.x;
			this._adherenceLabel.validate();
			this._adherenceLabel.x = this._patientEmail.x;
			this._adherenceLabel.y = this._patientImageBg.y + (this._patientImageBg.height * 0.5) - (this._adherenceLabel.height * 0.5);

			var avgTolerability:Number = HivivaModifier.calculateOverallTolerability(_patientData.medicationHistory.history);
			this._tolerabilityLabel = new Label();
			this._tolerabilityLabel.name = HivivaThemeConstants.BODY_BOLD_LABEL;
			this._tolerabilityLabel.text = "Overall tolerability:  " + String(avgTolerability) + "%";
			this.addChild(this._tolerabilityLabel);

			this._tolerabilityLabel.width = innerWidth - this._tolerabilityLabel.x;
			this._tolerabilityLabel.validate();
			this._tolerabilityLabel.x = this._patientEmail.x;
			this._tolerabilityLabel.y = this._patientImageBg.y + this._patientImageBg.height - this._tolerabilityLabel.height;

			this._reportAndMessage = new BoxedButtons();
			this._reportAndMessage.addEventListener(starling.events.Event.TRIGGERED, reportAndMessageHandler);
			this._reportAndMessage.scale = this.dpiScale;
			this._reportAndMessage.labels = ["Generate report", "Send message"];
			this.addChild(this._reportAndMessage);
			this._reportAndMessage.width = innerWidth;
			this._reportAndMessage.validate();
			this._reportAndMessage.x = scaledPadding;
			this._reportAndMessage.y = this._patientImageBg.y + this._patientImageBg.height + gap;

			drawPatientTable();

			doImageLoad("media/patients/" + _patientData.picture);

		}

		private function drawPatientTable():void
		{
			var patientAdherenceTable:PatientAdherenceTable = new PatientAdherenceTable();
			patientAdherenceTable.scale = this.dpiScale;
			patientAdherenceTable.patientData = _patientData;
			addChild(patientAdherenceTable);
			patientAdherenceTable.y = this._reportAndMessage.y + this._reportAndMessage.height + (this.actualHeight * 0.02);
			patientAdherenceTable.width = this.actualWidth;
			patientAdherenceTable.height = this.actualHeight - patientAdherenceTable.y;
			patientAdherenceTable.validate();
			patientAdherenceTable.drawTable();
		}

		private function backBtnHandler(e:starling.events.Event):void
		{

			if (this.owner.hasScreen(HivivaScreens.HCP_PATIENT_MESSAGE_COMPOSE_SCREEN))
			{
				this.owner.removeScreen(HivivaScreens.HCP_PATIENT_MESSAGE_COMPOSE_SCREEN);
			}

			if (this.owner.hasScreen(HivivaScreens.HCP_PATIENT_PROFILE_REPORT))
			{
				this.owner.removeScreen(HivivaScreens.HCP_PATIENT_PROFILE_REPORT);
			}

			dispatchEvent(new FeathersScreenEvent(FeathersScreenEvent.SHOW_MAIN_NAV,true));
			this.dispatchEventWith("navGoHome");
		}

		private function reportAndMessageHandler(e:starling.events.Event):void
		{
			var button:String = e.data.button;
			var screenParams:Object = {selectedPatient: _patientData};
			var targetScreen:String;
			var screenNavigatorItem:ScreenNavigatorItem;
			switch(button)
			{
				case "Generate report" :
					targetScreen = HivivaScreens.HCP_PATIENT_PROFILE_REPORT;
					screenNavigatorItem = new ScreenNavigatorItem(HivivaHCPPatientReportsScreen, null, screenParams);
					break;
				case "Send message" :
					targetScreen = HivivaScreens.HCP_PATIENT_MESSAGE_COMPOSE_SCREEN;
					screenNavigatorItem = new ScreenNavigatorItem(HivivaHCPPatientMessageCompose , null , screenParams);
					break;
			}

			if (!this.owner.hasScreen(targetScreen))
			{
				this.owner.addScreen(targetScreen, screenNavigatorItem);
			}
			this.owner.showScreen(targetScreen);
		}

		private function doImageLoad(url:String):void
		{
			var imageLoader:Loader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, imageLoaded);
			imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, imageLoadFailed);
			imageLoader.load(new URLRequest(url));
		}

		private function imageLoaded(e:flash.events.Event):void
		{
			trace("Image loaded.");

			var suitableBm:Bitmap = getSuitableBitmap(e.target.content as Bitmap);

			this._photoHolder = new Image(Texture.fromBitmap(suitableBm));
			this._photoHolder.touchable = false;
			constrainToProportion(this._photoHolder, IMAGE_SIZE * this.dpiScale);
			// TODO : Check if if (img.height >= img.width) then position accordingly. right now its only Ypos
			this._photoHolder.x = this._patientImageBg.x;
			this._photoHolder.y = this._patientImageBg.y + (this._patientImageBg.height / 2) -
					(this._photoHolder.height / 2);
			if (!contains(this._photoHolder)) addChild(this._photoHolder);
		}

		private function imageLoadFailed(e:flash.events.Event):void
		{
			trace("Image load failed.");
		}

		private function getSuitableBitmap(sourceBm:Bitmap):Bitmap
		{
			var bm:Bitmap;
			// if source bitmap is larger than starling size limit of 2048x2048 than resize
			if (sourceBm.width >= 2048 || sourceBm.height >= 2048)
			{
				// TODO: may need to remove size adjustment from bm! only adjust the data (needs formula)
				constrainToProportion(sourceBm, 2040);
				// copy source bitmap at adjusted size
				var bmd:BitmapData = new BitmapData(sourceBm.width, sourceBm.height);
				var m:Matrix = new Matrix();
				m.scale(sourceBm.scaleX, sourceBm.scaleY);
				bmd.draw(sourceBm, m, null, null, null, true);
				bm = new Bitmap(bmd, 'auto', true);
			}
			else
			{
				bm = sourceBm;
			}
			return bm;
		}

		private function constrainToProportion(img:Object, size:Number):void
		{
			if (img.height >= img.width)
			{
				img.height = size;
				img.scaleX = img.scaleY;
			}
			else
			{
				img.width = size;
				img.scaleY = img.scaleX;
			}
		}

		public function set patientData(value:XML):void
		{
			this._patientData = value;
		}

		public function get patientData():XML
		{
			return this._patientData;
		}

		override public function dispose():void
		{

			this._patientImageBg.dispose();
			if(this._photoHolder != null)
			{
				this._photoHolder.dispose();
			}


			removeChildren(0, -1, true);
			removeEventListeners();

			this._patientImageBg = null;
			this._photoHolder = null;

			super.dispose();
		}





	}
}

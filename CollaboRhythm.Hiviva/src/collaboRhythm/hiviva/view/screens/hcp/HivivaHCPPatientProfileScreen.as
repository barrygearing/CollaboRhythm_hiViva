package collaboRhythm.hiviva.view.screens.hcp
{

	import collaboRhythm.hiviva.global.Constants;
	import collaboRhythm.hiviva.global.FeathersScreenEvent;
	import collaboRhythm.hiviva.global.HivivaScreens;
	import collaboRhythm.hiviva.global.HivivaThemeConstants;
	import collaboRhythm.hiviva.global.RemoteDataStoreEvent;
	import collaboRhythm.hiviva.utils.HivivaModifier;
	import collaboRhythm.hiviva.view.*;
	import collaboRhythm.hiviva.view.components.BoxedButtons;
	import collaboRhythm.hiviva.view.components.PatientAdherenceChart;
	import collaboRhythm.hiviva.view.components.PatientAdherenceTable;
	import collaboRhythm.hiviva.view.screens.hcp.messages.HivivaHCPPatientMessageCompose;

	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.ScrollContainer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;

	public class HivivaHCPPatientProfileScreen extends Screen
	{
		private var _header:HivivaHeader;
		private var _backButton:Button;

		private var _patientImageBg:Quad;
		private var _photoHolder:Image;
		private var _patientEmail:Label;
		private var _patientProfileData:XML;
		private var _patientHistoryData:XML;
		private var _adherenceLabel:Label;
		private var _tolerabilityLabel:Label;
		private var _reportAndMessage:BoxedButtons;
		private var _weekNavHolder:ScrollContainer;
		private var _weekText:Label;
		private var _currWeekBeginning:Date;
		private var _latestWeekBeginning:Date;
		private var _earliestWeekBeginning:Date;
		private var _dataColumnsWidth:Number;
		private var _patientAdherenceTable:PatientAdherenceTable;
		private var _viewLabel:Label;
		private var _leftArrow:Button;
		private var _rightArrow:Button;
		private var _parentScreen:String;

		private const IMAGE_SIZE:Number = 125;
		private const PADDING:Number = 32;

		public function HivivaHCPPatientProfileScreen()
		{

		}

		override protected function draw():void
		{
			super.draw();

			this._header.width = Constants.STAGE_WIDTH;
			this._header.height = Constants.HEADER_HEIGHT;
			this._header.initTrueTitle();

			this._dataColumnsWidth = (this.actualWidth * 0.65) / 8;

			drawPatientProfile();

			drawTableAndNav();
		}

		override protected function initialize():void
		{
			super.initialize();

			this._patientProfileData = Main.selectedHCPPatientProfile;

			setDates();

			this._header = new HivivaHeader();
			this._header.title = Main.selectedHCPPatientProfile.name;
			this.addChild(this._header);

			this._backButton = new Button();
			this._backButton.name = HivivaThemeConstants.BACK_BUTTON;
			this._backButton.label = "Back";
			this._backButton.addEventListener(starling.events.Event.TRIGGERED, backBtnHandler);

			this._header.leftItems = new <DisplayObject>[_backButton];

			initPatientProfile();

			initTableAndNav();
		}

		private function setDates():void
		{
			var currentDate:Date = HivivaStartup.userVO.serverDate;
			this._currWeekBeginning = new Date(currentDate.getFullYear(),currentDate.getMonth(),currentDate.getDate(),currentDate.getHours(),currentDate.getMinutes(),currentDate.getSeconds(),currentDate.getMilliseconds());
			HivivaModifier.floorToClosestMonday(this._currWeekBeginning);

			this._latestWeekBeginning = new Date(this._currWeekBeginning.getFullYear(),this._currWeekBeginning.getMonth(),this._currWeekBeginning.getDate(),0,0,0,0);
			this._earliestWeekBeginning = new Date(this._currWeekBeginning.getFullYear(),this._currWeekBeginning.getMonth(),this._currWeekBeginning.getDate(),0,0,0,0);

			this._earliestWeekBeginning.date -= (7 * PatientAdherenceChart.TOTAL_WEEKS);
		}

		private function initPatientProfile():void
		{
			this._patientImageBg = new Quad(IMAGE_SIZE * this.dpiScale, IMAGE_SIZE * this.dpiScale, 0x000000);
			this._patientImageBg.alpha = 0;
			this.addChild(this._patientImageBg);

			this._patientEmail = new Label();
			this._patientEmail.text = _patientProfileData.email;
			this.addChild(this._patientEmail);

			this._adherenceLabel = new Label();
			this._adherenceLabel.name = HivivaThemeConstants.BODY_BOLD_WHITE_LABEL;

			this._tolerabilityLabel = new Label();
			this._tolerabilityLabel.name = HivivaThemeConstants.BODY_BOLD_WHITE_LABEL;

			var adherence:Number = Main.selectedHCPPatientProfile.adherence;
			var tolerability:Number = Main.selectedHCPPatientProfile.tolerability;

			// if patient has no medication history
			if (adherence == -1 && tolerability == -1)
			{
				this._adherenceLabel.text = "No data exists";
				this._tolerabilityLabel.text = "for this patient";
			}
			else
			{
				this._adherenceLabel.text = "Overall adherence: ";
				this._tolerabilityLabel.text = "Overall tolerability: ";
			}

			this.addChild(this._adherenceLabel);
			this.addChild(this._tolerabilityLabel);

			this._reportAndMessage = new BoxedButtons();
			this._reportAndMessage.addEventListener(starling.events.Event.TRIGGERED, reportAndMessageHandler);
			this._reportAndMessage.scale = this.dpiScale;
			this._reportAndMessage.labels = ["Generate report", "Send message"];
			this.addChild(this._reportAndMessage);
		}

		private function getSummaryStringFromPatientData(patientData:XML):String
		{
			var summaryStr:String;

			var adherence:String = patientData.adherence;
			var tolerability:String = patientData.tolerability;

			// if patient has no medication history
			if (adherence == "-1" && tolerability == "-1")
			{
				summaryStr = "No data exists \nfor this patient";
			}

			// if patient has missed recording their schedule within the predefined history
			if (adherence > "-1" && tolerability == "-1")
			{
				summaryStr = "Adherence: " + adherence + "%\n" + "Tolerability: None";
			}

			if (adherence > "-1" && tolerability > "-1")
			{
				summaryStr = "Adherence: " + adherence + "%\n" + "Tolerability: " + tolerability + "%";
			}

			return summaryStr;
		}

		private function drawPatientProfile():void
		{
			var scaledPadding:Number = PADDING * this.dpiScale;
			var gap:Number = scaledPadding * 0.5;
			var innerWidth:Number = Constants.STAGE_WIDTH - (scaledPadding * 2);

			this._patientImageBg.x = scaledPadding;
			this._patientImageBg.y = this._header.height + gap;

			this._patientEmail.width = innerWidth - this._patientEmail.x;
			this._patientEmail.validate();
			this._patientEmail.x = this._patientImageBg.x + this._patientImageBg.width + gap;
			this._patientEmail.y = this._patientImageBg.y;

//			this._tolerabilityLabel.width = innerWidth - this._tolerabilityLabel.x;
			this._tolerabilityLabel.validate();
			this._tolerabilityLabel.x = this._patientEmail.x;
			this._tolerabilityLabel.y = this._patientImageBg.y + this._patientImageBg.height - this._tolerabilityLabel.height;

//			this._adherenceLabel.width = innerWidth - this._adherenceLabel.x;
			this._adherenceLabel.validate();
			this._adherenceLabel.x = this._patientEmail.x;
			this._adherenceLabel.y = this._tolerabilityLabel.y - this._adherenceLabel.height;

			var adherence:Number = Main.selectedHCPPatientProfile.adherence;
			var tolerability:Number = Main.selectedHCPPatientProfile.tolerability;

			// if patient has no medication history
			if (adherence > -1)
			{
				var adherenceValueLabel:Label = new Label();
				adherenceValueLabel.name = HivivaThemeConstants.SUBHEADER_LABEL;
				adherenceValueLabel.text = adherence + "%";
				addChild(adherenceValueLabel);
				adherenceValueLabel.validate();
				adherenceValueLabel.x = this._adherenceLabel.x + this._adherenceLabel.width;
				adherenceValueLabel.y = this._tolerabilityLabel.y - adherenceValueLabel.height;
			}

			// if patient has missed recording their schedule within the predefined history
			if (tolerability > -1)
			{
				_tolerabilityLabel.text = "Overall tolerability: " + tolerability + "%";
			}
			else
			{
				_tolerabilityLabel.text = "Overall tolerability: None";
			}

			this._reportAndMessage.width = innerWidth;
			this._reportAndMessage.validate();
			this._reportAndMessage.x = scaledPadding;
			this._reportAndMessage.y = this._patientImageBg.y + this._patientImageBg.height + gap;

			doImageLoad(Main.selectedHCPPatientProfile.picture);
		}

		private function initTableAndNav():void
		{
			this._weekNavHolder = new ScrollContainer();
			addChild(this._weekNavHolder);

			_viewLabel = new Label();
			_viewLabel.name = HivivaThemeConstants.BODY_BOLD_WHITE_CENTERED_LABEL;
			_viewLabel.text = "View:";
			this._weekNavHolder.addChild(_viewLabel);

			_leftArrow = new Button();
			_leftArrow.name = HivivaThemeConstants.LESS_THAN_ARROWS_BUTTON;
			_leftArrow.addEventListener(starling.events.Event.TRIGGERED, leftArrowHandler);
			this._weekNavHolder.addChild(_leftArrow);

			_rightArrow = new Button();
			_rightArrow.name = HivivaThemeConstants.LESS_THAN_ARROWS_BUTTON;
			_rightArrow.addEventListener(starling.events.Event.TRIGGERED, rightArrowHandler);
			this._weekNavHolder.addChild(_rightArrow);
			this._rightArrow.scaleX = -1;

			this._weekText = new Label();
			this._weekText.touchable = false;
			this._weekText.name = HivivaThemeConstants.BODY_CENTERED_LABEL;
			this._weekText.text = " ";
			this._weekNavHolder.addChild(this._weekText);

			layoutWeekNav();
			this._patientAdherenceTable = new PatientAdherenceTable();
			this.addChild(this._patientAdherenceTable);
		}

		private function layoutWeekNav():void
		{
			this._weekNavHolder.layout = new AnchorLayout();

			_viewLabel.validate();
			_leftArrow.validate();
			_rightArrow.validate();
			_weekText.validate();

			var viewLayoutData:AnchorLayoutData = new AnchorLayoutData();
			viewLayoutData.top = (_leftArrow.height * 0.5) - (_viewLabel.height * 0.5);
			_viewLabel.layoutData = viewLayoutData;

			var leftArrowLayoutData:AnchorLayoutData = new AnchorLayoutData();
			leftArrowLayoutData.left = _viewLabel.x + _viewLabel.width + 20;
			_leftArrow.layoutData = leftArrowLayoutData;

			var rightArrowLayoutData:AnchorLayoutData = new AnchorLayoutData();
			rightArrowLayoutData.right = 0;
			_rightArrow.layoutData = rightArrowLayoutData;

			var weekTextLayoutData:AnchorLayoutData = new AnchorLayoutData();
			weekTextLayoutData.top = (_leftArrow.height * 0.5) - (_weekText.height * 0.5);
			weekTextLayoutData.left = _leftArrow.x + _leftArrow.width + 20;
			weekTextLayoutData.right = _rightArrow.x + _rightArrow.width - 20;
			_weekText.layoutData = weekTextLayoutData;
		}

		private function drawTableAndNav():void
		{
			this._weekNavHolder.x = this.actualWidth * 0.35;
			this._weekNavHolder.y = this._reportAndMessage.y + this._reportAndMessage.height + (PADDING * 0.5);
			this._weekNavHolder.width = this.actualWidth - this._weekNavHolder.x;
			this._weekNavHolder.validate();

			_patientAdherenceTable.y = this._weekNavHolder.y + this._weekNavHolder.height + (PADDING * 0.5);
			_patientAdherenceTable.width = Constants.STAGE_WIDTH;
			_patientAdherenceTable.height = this.actualHeight - _patientAdherenceTable.y;
			_patientAdherenceTable.validate();
			getDailyMedicationHistoryRange();
			manageWeekNav();
		}

		private function leftArrowHandler(e:starling.events.Event):void
		{
			this._currWeekBeginning.date -= 7;
			getDailyMedicationHistoryRange();
			manageWeekNav();
		}

		private function rightArrowHandler(e:starling.events.Event):void
		{
			this._currWeekBeginning.date += 7;
			getDailyMedicationHistoryRange();
			manageWeekNav();
		}

		private function manageWeekNav():void
		{
			this._leftArrow.isEnabled = this._currWeekBeginning.getTime() >= this._earliestWeekBeginning.getTime();
			this._leftArrow.alpha = this._leftArrow.isEnabled ? 1 : 0.3;

			this._rightArrow.isEnabled = this._currWeekBeginning.getTime() <= this._latestWeekBeginning.getTime();
			this._rightArrow.alpha = this._rightArrow.isEnabled ? 1 : 0.3;
		}

		private function getDailyMedicationHistoryRange():void
		{
			var startDate:Date = new Date(this._currWeekBeginning.getFullYear(), this._currWeekBeginning.getMonth(), this._currWeekBeginning.getDate(),0,0,0,0);
			var startIsoDate:String = HivivaModifier.getIsoStringFromDate(startDate,false);

			var endDate:Date = new Date(this._currWeekBeginning.getFullYear(), this._currWeekBeginning.getMonth(), this._currWeekBeginning.getDate(),0,0,0,0);
			endDate.date += 7;
			var endIsoDate:String = HivivaModifier.getIsoStringFromDate(endDate,false);

			// disable week navigation until we receive a response from database
			this._weekNavHolder.touchable = false;

			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.addEventListener(RemoteDataStoreEvent.GET_DAILY_MEDICATION_HISTORY_RANGE_COMPLETE,getDailyMedicationHistoryRangeCompleteHandler);
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.getDailyMedicationHistoryRange(this._patientProfileData.guid,startIsoDate,endIsoDate);
		}

		private function getDailyMedicationHistoryRangeCompleteHandler(e:RemoteDataStoreEvent):void
		{
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.removeEventListener(RemoteDataStoreEvent.GET_DAILY_MEDICATION_HISTORY_RANGE_COMPLETE,getDailyMedicationHistoryRangeCompleteHandler);

			this._patientHistoryData = e.data.xmlResponse;

			if (this._patientHistoryData.children().length() > 0)
			{
				if(_patientAdherenceTable.patientData == null)
				{
					_patientAdherenceTable.drawTable();
				}
				_patientAdherenceTable.patientData = this._patientHistoryData;
				_patientAdherenceTable.currWeekBeginning = this._currWeekBeginning;
				_patientAdherenceTable.updateTableData();
				setCurrentWeek();
			}
			else
			{
				// no validation as user cannot see this screen if there is no patient history
				trace("no patient history");
			}

			this._weekNavHolder.touchable = true;
		}

		private function setCurrentWeek():void
		{
			this._weekText.text = "wc: " + HivivaModifier.getCalendarStringFromDate(this._currWeekBeginning);
			this._weekText.validate();
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

			if(_parentScreen != null)
			{
				this.owner.showScreen(_parentScreen);
			}
			else
			{
				dispatchEvent(new FeathersScreenEvent(FeathersScreenEvent.SHOW_MAIN_NAV,true));
				this.dispatchEventWith("navGoHome");
			}
		}

		private function reportAndMessageHandler(e:starling.events.Event):void
		{
			var button:String = e.data.button;
			var screenParams:Object = {selectedPatient: _patientProfileData};
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
			imageLoader.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, imageLoadFailed);
			imageLoader.load(new URLRequest(url));
		}

		private function imageLoaded(e:flash.events.Event):void
		{
			trace("Image loaded.");

			var suitableBm:Bitmap = getSuitableBitmap(e.target.content as Bitmap);

			this._photoHolder = new Image(Texture.fromBitmap(suitableBm));
			this._photoHolder.touchable = false;
			HivivaModifier.clipImage(this._photoHolder);
			this._photoHolder.width = this._photoHolder.height = IMAGE_SIZE;
			this._photoHolder.x = this._patientImageBg.x;
			this._photoHolder.y = this._patientImageBg.y + (this._patientImageBg.height / 2) -
					(this._photoHolder.height / 2);
			if (!contains(this._photoHolder)) addChild(this._photoHolder);
		}

		private function imageLoadFailed(e:flash.events.IOErrorEvent):void
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

			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.removeEventListener(RemoteDataStoreEvent.GET_DAILY_MEDICATION_HISTORY_RANGE_COMPLETE,getDailyMedicationHistoryRangeCompleteHandler);

			super.dispose();
		}

		public function get parentScreen():String
		{
			return _parentScreen;
		}

		public function set parentScreen(value:String):void
		{
			_parentScreen = value;
		}
	}
}

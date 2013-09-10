package collaboRhythm.hiviva.view.screens.shared
{
	import collaboRhythm.hiviva.global.Constants;
	import collaboRhythm.hiviva.global.FeathersScreenEvent;
	import collaboRhythm.hiviva.global.HivivaThemeConstants;
	import collaboRhythm.hiviva.global.RemoteDataStoreEvent;
	import collaboRhythm.hiviva.utils.HivivaModifier;
	import collaboRhythm.hiviva.view.HivivaStartup;
	import collaboRhythm.hiviva.view.components.AdherenceChartReport;
	import collaboRhythm.hiviva.view.components.BoxedButtons;
	import collaboRhythm.hiviva.view.components.AdherenceTableReport;
	import collaboRhythm.hiviva.view.components.TestTableReport;
	import collaboRhythm.hiviva.view.components.TolerabilityChartReport;

	import feathers.controls.Button;
	import feathers.controls.Label;

	import starling.display.DisplayObject;
	import starling.events.Event;

	public class ReportPreview extends BaseScreen
	{
		private var _backButton:Button;
		private var _cancelAndSend:BoxedButtons;
		private var _parentScreen:String;
		private var _adherenceIsChecked:Boolean = false;
		private var _feelingIsChecked:Boolean = false;
		private var _cd4IsChecked:Boolean = false;
		private var _viralLoadIsChecked:Boolean = false;
		private var _startDate:Date;
		private var _endDate:Date;
		private var _patientGuid:String;
		private var _patientAppId:String;
		private var _emailAddress:String;
		private var _medicationHistoryCallMade:Boolean = false;
		private var _testResultsCallMade:Boolean = false;
		private var _filteredMedicationHistory:XMLList;
		private var _filteredTestResults:XMLList;
		private var _adherenceReportChart:AdherenceChartReport;
		private var _adherenceReportTable:AdherenceTableReport;
		private var _tolerabilityReportChart:TolerabilityChartReport;
		private var _reportTable:TestTableReport;
		private var _layoutApplied:Boolean = false;
		private var _bodyLabel:Label;
		private var _noMedicationHistory:Boolean = false;
		private var _noTestResults:Boolean = false;

		public function ReportPreview()
		{
			super();
		}

		override protected function draw():void
		{
			super.draw();

			if(!this._layoutApplied) applyLayout();

			if(!this._medicationHistoryCallMade && (this._adherenceIsChecked || this._feelingIsChecked))
			{
				HivivaStartup.hivivaAppController.hivivaRemoteStoreController.addEventListener(RemoteDataStoreEvent.GET_DAILY_MEDICATION_HISTORY_RANGE_COMPLETE, getDailyMedicationHistoryRangeCompleteHandler);
				HivivaStartup.hivivaAppController.hivivaRemoteStoreController.getDailyMedicationHistoryRange(this._patientGuid, HivivaModifier.getIsoStringFromDate(this._startDate,false), HivivaModifier.getIsoStringFromDate(this._endDate,false));
			}

			if(!this._testResultsCallMade && (this._cd4IsChecked || this._viralLoadIsChecked))
			{
				HivivaStartup.hivivaAppController.hivivaRemoteStoreController.addEventListener(RemoteDataStoreEvent.GET_PATIENT_RESULTS_RANGE_COMPLETE, getPatientTestResultsRangeCompleteHandler);
				HivivaStartup.hivivaAppController.hivivaRemoteStoreController.getPatientTestResultsRange(this._patientGuid, HivivaModifier.getIsoStringFromDate(this._startDate,false), HivivaModifier.getIsoStringFromDate(this._endDate,false));
			}
		}

		override protected function preValidateContent():void
		{
			this._cancelAndSend.x = Constants.PADDING_LEFT;
			this._cancelAndSend.width = Constants.INNER_WIDTH;
			this._cancelAndSend.validate();
			this._cancelAndSend.y = Constants.STAGE_HEIGHT - Constants.PADDING_BOTTOM - this._cancelAndSend.height;
		}

		override protected function initialize():void
		{
			super.initialize();

			this._header.title = "Report preview";

			this._backButton = new Button();
			this._backButton.name = HivivaThemeConstants.BACK_BUTTON;
			this._backButton.label = "Back";
			this._backButton.addEventListener(Event.TRIGGERED, backBtnHandler);

			this._header.leftItems = new <DisplayObject>[_backButton];

			this._cancelAndSend = new BoxedButtons();
			this._cancelAndSend.labels = ["Cancel","Send"];
			this._cancelAndSend.addEventListener(Event.TRIGGERED, cancelAndSendHandler);
			addChild(this._cancelAndSend);

			getSettingsFromVO();

			dispatchEvent(new FeathersScreenEvent(FeathersScreenEvent.HIDE_MAIN_NAV,true));
		}

		private function getSettingsFromVO():void
		{
			trace("ReportPreview getSettingsFromVO ")  ;
			var settings:Object = HivivaStartup.reportVO.settingsData;
			this._adherenceIsChecked = settings.adherenceIsChecked;
			this._feelingIsChecked = settings.feelingIsChecked;
			this._cd4IsChecked = settings.cd4IsChecked;
			this._viralLoadIsChecked = settings.viralLoadIsChecked;
			this._startDate = HivivaModifier.getDateFromCalendarString(settings.startDate);
			this._endDate = HivivaModifier.getDateFromCalendarString(settings.endDate);
			this._emailAddress = settings.emailAddress;
			this._patientGuid = settings.patientGuid;
			this._patientAppId = settings.patientAppId;
		}

		private function backBtnHandler(e:Event = null):void
		{
			dispatchEvent(new FeathersScreenEvent(FeathersScreenEvent.SHOW_MAIN_NAV,true));
			this.owner.showScreen(_parentScreen);
		}

		private function cancelAndSendHandler(e:Event):void
		{
			var btn:String = e.data.button;
			switch(btn)
			{
				case "Cancel" :
					backBtnHandler();
					break;
				case "Send" :
					// send
					break;
			}
		}

		private function applyLayout():void
		{
//			this._contentLayout.gap = 0;
//			this._contentLayout.padding = 0;
			this._content.layout = this._contentLayout;
			this._content.y = Constants.HEADER_HEIGHT + Constants.PADDING_TOP;
			this._content.height = this._cancelAndSend.y - this._content.y - Constants.PADDING_BOTTOM;

			_bodyLabel = new Label();
			this._content.addChild(_bodyLabel);

			this._adherenceReportChart = new AdherenceChartReport();
			this._content.addChild(this._adherenceReportChart);

			this._adherenceReportTable = new AdherenceTableReport();
			this._content.addChild(this._adherenceReportTable);

			this._tolerabilityReportChart = new TolerabilityChartReport();
			this._content.addChild(this._tolerabilityReportChart);

			this._reportTable = new TestTableReport();
			this._content.addChild(this._reportTable);

			this._layoutApplied = true;
		}

		private function getDailyMedicationHistoryRangeCompleteHandler(e:RemoteDataStoreEvent):void
		{
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.removeEventListener(RemoteDataStoreEvent.GET_DAILY_MEDICATION_HISTORY_RANGE_COMPLETE, getDailyMedicationHistoryRangeCompleteHandler);

			this._filteredMedicationHistory = e.data.xmlResponse.DCUserMedication;
			// only if there is Schedule.DCMedicationSchedule in xmlresponse to avoid a blank table
			if(this._filteredMedicationHistory.Schedule.DCMedicationSchedule.length() > 0)
			{
				prepareSelectedMedicalData();
			}
			else
			{
				trace("Medical history data requested but this patient has no medical history");
				_noMedicationHistory = true;
			}

			this._medicationHistoryCallMade = true;
			if(this._medicationHistoryCallMade && this._testResultsCallMade) initBodyLabel();
		}

		private function getPatientTestResultsRangeCompleteHandler(e:RemoteDataStoreEvent):void
		{
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.removeEventListener(RemoteDataStoreEvent.GET_PATIENT_RESULTS_RANGE_COMPLETE, getPatientTestResultsRangeCompleteHandler);

			this._filteredTestResults = e.data.xmlResponse.Results.DCTestResult;
			if(this._filteredTestResults.length() > 0)
			{
				prepareSelectedTestResultData();
			}
			else
			{
				trace("Test result data requested but this patient has no test result history");
				_noTestResults = true;
			}

			this._testResultsCallMade = true;
			if(this._medicationHistoryCallMade && this._testResultsCallMade) initBodyLabel();
		}

		private function prepareSelectedMedicalData():void
		{
			if(this._adherenceIsChecked)
			{
//				this._adherenceReportChart.dataCategory = "adherence";
				this._adherenceReportChart.startDate = this._startDate;
				this._adherenceReportChart.endDate = this._endDate;
				this._adherenceReportChart.medications = this._filteredMedicationHistory;
				this._adherenceReportChart.width = Constants.INNER_WIDTH;
				this._adherenceReportChart.height = this._content.height;
				this._adherenceReportChart.validate();
				this._adherenceReportChart.drawChart();

				this._adherenceReportTable.startDate = this._startDate;
				this._adherenceReportTable.endDate = this._endDate;
				this._adherenceReportTable.medications = this._filteredMedicationHistory;
				this._adherenceReportTable.width = Constants.INNER_WIDTH;
				this._adherenceReportTable.validate();
				this._adherenceReportTable.drawTable();
			}

			if(this._feelingIsChecked)
			{
//				this._tolerabilityReportChart.dataCategory = "tolerability";
				this._tolerabilityReportChart.startDate = this._startDate;
				this._tolerabilityReportChart.endDate = this._endDate;
				this._tolerabilityReportChart.medications = this._filteredMedicationHistory;
				this._tolerabilityReportChart.width = Constants.INNER_WIDTH;
				this._tolerabilityReportChart.height = this._content.height;
				this._tolerabilityReportChart.validate();
				this._tolerabilityReportChart.drawChart();
			}

			this._content.validate();
		}

		private function prepareSelectedTestResultData():void
		{
			var dataCategory:String;
			if(this._cd4IsChecked) dataCategory = TestTableReport.DATA_CD4;
			if(this._viralLoadIsChecked) dataCategory = TestTableReport.DATA_VIRAL_LOAD;
			if(this._cd4IsChecked && this._viralLoadIsChecked) dataCategory = TestTableReport.DATA_ALL;

			this._reportTable.dataCategory = dataCategory;
			this._reportTable.patientData = this._filteredTestResults;
			this._reportTable.width = Constants.INNER_WIDTH;
			this._reportTable.validate();
			this._reportTable.drawTestTable();

			this._content.validate();
		}

		private function initBodyLabel():void
		{
			if(_noMedicationHistory && _noTestResults)
			{
				_bodyLabel.text = "No Data found for this patient within the selected date range";
			}
			else
			{
				_bodyLabel.text = 	"From: " + HivivaStartup.userVO.appId + "\n\n" +
								 	"To: " + this._emailAddress + "\n\n" +
								 	"Date: " + HivivaModifier.getCalendarStringFromDate(HivivaStartup.userVO.serverDate) + "\n\n" +
									"Subject: Patient Report\n\n" +
									"Please find below details of patient (" + this._patientAppId + ") record of their HIV tracking via the HiVIVA application.\n\n" +
									"This covers the time period between: " + HivivaModifier.getCalendarStringFromDate(this._startDate) + " - " + HivivaModifier.getCalendarStringFromDate(this._endDate);
			}

			_bodyLabel.x = Constants.PADDING_LEFT;
			_bodyLabel.width = Constants.INNER_WIDTH;
			this._content.validate();
		}

		private function sendPDFInit():void
		{

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

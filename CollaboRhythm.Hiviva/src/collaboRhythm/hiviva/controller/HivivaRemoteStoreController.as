package collaboRhythm.hiviva.controller
{
	import collaboRhythm.hiviva.global.RemoteDataStoreEvent;
	import collaboRhythm.hiviva.model.HivivaRemoteStoreService;

	import flash.events.EventDispatcher;

	public class HivivaRemoteStoreController extends EventDispatcher
	{
		private var _hivivaRemoteStoreService:HivivaRemoteStoreService;

		public function HivivaRemoteStoreController()
		{
			trace("HivivaRemoteStoreController construct");
		}

		public function initStoreService():void
		{
			_hivivaRemoteStoreService = new HivivaRemoteStoreService();

		}

		public function createUser(appType:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.CREATE_USER_COMPLETE , userCreateCompleteHandler);
			service.createUser(appType);
		}

		private function userCreateCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.CREATE_USER_COMPLETE , userCreateCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.CREATE_USER_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function saveUser(user:XML):void
		{
			service.addEventListener(RemoteDataStoreEvent.SAVE_USER_COMPLETE , saveUserCompleteHandler);
			service.saveUser(user);
		}

		private function saveUserCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.SAVE_USER_COMPLETE , saveUserCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.SAVE_USER_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function saveUserPicture(pictureData:XML):void
		{
			service.addEventListener(RemoteDataStoreEvent.SAVE_USER_PICTURE_COMPLETE , saveUserPictureCompleteHandler);
			service.saveUserPicture(pictureData);
		}

		private function saveUserPictureCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.SAVE_USER_PICTURE_COMPLETE , saveUserPictureCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.SAVE_USER_PICTURE_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getUserPicture(userGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_USER_PICTURE_COMPLETE , getUserPictureCompleteHandler);
			service.getUserPicture(userGuid);
		}

		private function getUserPictureCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_USER_PICTURE_COMPLETE , getUserPictureCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_USER_PICTURE_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function addUserMedication(medicationName:String , medicationSchedule:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.ADD_MEDICATION_COMPLETE , addMedicationCompleteHandler);
			service.addUserMedication(medicationName, medicationSchedule);
		}

		private function addMedicationCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.ADD_MEDICATION_COMPLETE , addMedicationCompleteHandler);
			this.dispatchEvent(new RemoteDataStoreEvent(RemoteDataStoreEvent.ADD_MEDICATION_COMPLETE));
		}

		public function deleteMedication(medicationId:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.DELETE_PATIENT_MEDICATION_COMPLETE , deleteMedicationCompleteHandler);
			service.deleteMedication(medicationId);
		}

		private function deleteMedicationCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.DELETE_PATIENT_MEDICATION_COMPLETE , deleteMedicationCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.DELETE_PATIENT_MEDICATION_COMPLETE);
			this.dispatchEvent(evt);
		}

		public function getServerDate():void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_SERVER_DATE_COMPLETE, getServerDateComplete);
			service.getServerDate();
		}

		private function getServerDateComplete(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_SERVER_DATE_COMPLETE, getServerDateComplete);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_SERVER_DATE_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getPatientMedicationList():void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_PATIENT_MEDICATION_COMPLETE, getPatientMedicationListComplete);
			service.getPatientMedicationList();
		}

		private function getPatientMedicationListComplete(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_PATIENT_MEDICATION_COMPLETE, getPatientMedicationListComplete);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_PATIENT_MEDICATION_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function takeMedication(medicationData:XML):void
		{
			service.addEventListener(RemoteDataStoreEvent.TAKE_PATIENT_MEDICATION_COMPLETE, takePatientMedicationListComplete);
			service.takeMedication(medicationData);
		}

		private function takePatientMedicationListComplete(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.TAKE_PATIENT_MEDICATION_COMPLETE, takePatientMedicationListComplete);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.TAKE_PATIENT_MEDICATION_COMPLETE);
			this.dispatchEvent(evt);
		}

		public function getNumberDaysAdherence():void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_NUMBER_DAYS_ADHERENCE_COMPLETE, getNumberDaysAdherenceComplete);
			service.getNumberDaysAdherence();
		}

		private function getNumberDaysAdherenceComplete(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_NUMBER_DAYS_ADHERENCE_COMPLETE, getNumberDaysAdherenceComplete);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_NUMBER_DAYS_ADHERENCE_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getHCP(appGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_HCP_COMPLETE , getHCPCompleteHandler);
			service.getHCP(appGuid);
		}

		private function getHCPCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_HCP_COMPLETE , getHCPCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_HCP_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getPatient(appGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_PATIENT_COMPLETE , getPatientCompleteHandler);
			service.getPatient(appGuid);
		}

		private function getPatientCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_PATIENT_COMPLETE , getHCPCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_PATIENT_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function establishConnection(fromGuid:String , toGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.ESTABLISH_CONNECTION_COMPLETE , establishConnectionCompleteHandler);
			service.establishConnection(fromGuid , toGuid);
		}

		private function establishConnectionCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.ESTABLISH_CONNECTION_COMPLETE , establishConnectionCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.ESTABLISH_CONNECTION_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function approveConnection(fromGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.CONNECTION_APPROVE_COMPLETE , approveConnectionHandler);
			service.approveConnection(fromGuid);
		}

		private function approveConnectionHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.CONNECTION_APPROVE_COMPLETE , approveConnectionHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.CONNECTION_APPROVE_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function ignoreConnection(fromGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.CONNECTION_IGNORE_COMPLETE , ignoreConnectionHandler);
			service.ignoreConnection(fromGuid);
		}

		private function ignoreConnectionHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.CONNECTION_IGNORE_COMPLETE , ignoreConnectionHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.CONNECTION_IGNORE_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function deleteConnection(fromGuid:String , toGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.CONNECTION_DELETE_COMPLETE , deleteConnectionHandler);
			service.deleteConnection(fromGuid , toGuid);
		}

		private function deleteConnectionHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.CONNECTION_DELETE_COMPLETE , deleteConnectionHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.CONNECTION_DELETE_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getApprovedConnections():void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_APPROVED_CONNECTIONS_COMPLETE , getApprovedConnectionsHandler);
			service.getApprovedConnections();
		}

		private function getApprovedConnectionsHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_APPROVED_CONNECTIONS_COMPLETE , getApprovedConnectionsHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_APPROVED_CONNECTIONS_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getApprovedConnectionsWithSummary():void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_APPROVED_CONNECTIONS_WITH_SUMMARY_COMPLETE , getApprovedConnectionsWithSummaryHandler);
			service.getApprovedConnectionsWithSummary();
		}

		private function getApprovedConnectionsWithSummaryHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_APPROVED_CONNECTIONS_WITH_SUMMARY_COMPLETE , getApprovedConnectionsWithSummaryHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_APPROVED_CONNECTIONS_WITH_SUMMARY_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getPendingConnections():void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_PENDING_CONNECTIONS_COMPLETE , getPendingConnectionsHandler);
			service.getPendingConnections();
		}

		private function getPendingConnectionsHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_PENDING_CONNECTIONS_COMPLETE , getPendingConnectionsHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_PENDING_CONNECTIONS_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getHCPSentMessages():void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_HCP_SENT_MESSAGES_COMPLETE , getHCPSentMessagesHandler);
			service.getHCPSentMessages();
		}

		private function getHCPSentMessagesHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_HCP_SENT_MESSAGES_COMPLETE , getHCPSentMessagesHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_HCP_SENT_MESSAGES_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getUserReceivedMessages():void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_USER_RECEIVED_MESSAGES_COMPLETE , getUserReceivedMessagesHandler);
			service.getUserReceivedMessages();
		}

		private function getUserReceivedMessagesHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_USER_RECEIVED_MESSAGES_COMPLETE , getUserReceivedMessagesHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_USER_RECEIVED_MESSAGES_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getMessages():void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_MESSAGES_COMPLETE , getMessagesHandler);
			service.getMessages();
		}

		private function getMessagesHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_MESSAGES_COMPLETE , getMessagesHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_MESSAGES_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getPatientBadgeAlerts():void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_PATIENT_BADGE_ALERTS_COMPLETE , getPatientBadgeAlertsHandler);
			service.getPatientBadgeAlerts();
		}

		private function getPatientBadgeAlertsHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_PATIENT_BADGE_ALERTS_COMPLETE , getPatientBadgeAlertsHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_PATIENT_BADGE_ALERTS_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getHCPAlerts():void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_HCP_ALERTS_COMPLETE , getHCPAlertsHandler);
			service.getHCPAlerts();
		}

		private function getHCPAlertsHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_HCP_ALERTS_COMPLETE , getHCPAlertsHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_HCP_ALERTS_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function markAlertMessageAsRead(alertMessageGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.MARK_ALERT_MESSAGE_AS_READ_COMPLETE , markAlertMessageAsReadHandler);
			service.markAlertMessageAsRead(alertMessageGuid);
		}

		private function markAlertMessageAsReadHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.MARK_ALERT_MESSAGE_AS_READ_COMPLETE , markAlertMessageAsReadHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.MARK_ALERT_MESSAGE_AS_READ_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function deleteAlertMessage(alertMessageGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.DELETE_ALERT_MESSAGE_COMPLETE , deleteAlertMessageHandler);
			service.deleteAlertMessage(alertMessageGuid);
		}

		private function deleteAlertMessageHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.DELETE_ALERT_MESSAGE_COMPLETE , deleteAlertMessageHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.DELETE_ALERT_MESSAGE_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function sendUserMessage(toGuid:String,messageGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.SEND_USER_MESSAGE_COMPLETE , sendUserMessageHandler);
			service.sendUserMessage(toGuid,messageGuid);
		}

		private function sendUserMessageHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.SEND_USER_MESSAGE_COMPLETE , sendUserMessageHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.SEND_USER_MESSAGE_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function deleteUserMessage(messageGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.DELETE_USER_MESSAGE_COMPLETE , deleteUserMessageHandler);
			service.deleteUserMessage(messageGuid);
		}

		private function deleteUserMessageHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.DELETE_USER_MESSAGE_COMPLETE , deleteUserMessageHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.DELETE_USER_MESSAGE_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function markMessageAsRead(messageGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.MARK_MESSAGE_AS_READ_COMPLETE , markMessageAsReadHandler);
			service.markMessageAsRead(messageGuid);
		}

		private function markMessageAsReadHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.MARK_MESSAGE_AS_READ_COMPLETE , markMessageAsReadHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.MARK_MESSAGE_AS_READ_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function addTestResults(testResultData:XML):void
		{
			service.addEventListener(RemoteDataStoreEvent.ADD_TEST_RESULTS_COMPLETE , addTestResultsCompleteHandler);
			service.addTestResults(testResultData);
		}

		private function addTestResultsCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.ADD_TEST_RESULTS_COMPLETE , addTestResultsCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.ADD_TEST_RESULTS_COMPLETE);
			this.dispatchEvent(evt);
		}

		public function getPatientLastTestResult(testData:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_PATIENT_LATEST_RESULTS_COMPLETE , getPatientLatestTestResultsCompleteHandler);
			service.getPatientLastTestResult(testData);

		}

		private function getPatientLatestTestResultsCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_PATIENT_LATEST_RESULTS_COMPLETE , getPatientLatestTestResultsCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_PATIENT_LATEST_RESULTS_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getPatientTestResultsRange(userGuid:String, startIsoDate:String, endIsoDate:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_PATIENT_RESULTS_RANGE_COMPLETE , getPatientTestResultsRangeHandler);
			service.getPatientTestResultsRange(userGuid, startIsoDate, endIsoDate);

		}

		private function getPatientTestResultsRangeHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_PATIENT_RESULTS_RANGE_COMPLETE , getPatientTestResultsRangeHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_PATIENT_RESULTS_RANGE_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getUserMedicationHistory(userGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_USER_MEDICATION_HISTORY_COMPLETE , getUserMedicationHistoryCompleteHandler);
			service.getUserMedicationHistory(userGuid);
		}

		private function getUserMedicationHistoryCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_USER_MEDICATION_HISTORY_COMPLETE , getUserMedicationHistoryCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_USER_MEDICATION_HISTORY_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getDailyMedicationHistory(userGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_DAILY_MEDICATION_HISTORY_COMPLETE , getDailyMedicationHistoryCompleteHandler);
			service.getDailyMedicationHistory(userGuid);
		}

		private function getDailyMedicationHistoryCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_DAILY_MEDICATION_HISTORY_COMPLETE , getDailyMedicationHistoryCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_DAILY_MEDICATION_HISTORY_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getDailyMedicationHistoryRange(userGuid:String, startIsoDate:String, endIsoDate:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_DAILY_MEDICATION_HISTORY_RANGE_COMPLETE , getDailyMedicationHistoryRangeCompleteHandler);
			service.getDailyMedicationHistoryRange(userGuid, startIsoDate, endIsoDate);
		}

		private function getDailyMedicationHistoryRangeCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_DAILY_MEDICATION_HISTORY_RANGE_COMPLETE , getDailyMedicationHistoryRangeCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_DAILY_MEDICATION_HISTORY_RANGE_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getWeeklyMedicationHistory(userGuid:String):void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_WEEKLY_MEDICATION_HISTORY_COMPLETE , getWeeklyMedicationHistoryCompleteHandler);
			service.getWeeklyMedicationHistory(userGuid);
		}

		private function getWeeklyMedicationHistoryCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_WEEKLY_MEDICATION_HISTORY_COMPLETE , getWeeklyMedicationHistoryCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_WEEKLY_MEDICATION_HISTORY_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getAllWeeklyMedicationHistory(noOfWeeks:int):void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_ALL_WEEKLY_MEDICATION_HISTORY_COMPLETE , getAllWeeklyMedicationHistoryCompleteHandler);
			service.getAllWeeklyMedicationHistory(noOfWeeks);
		}

		private function getAllWeeklyMedicationHistoryCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_ALL_WEEKLY_MEDICATION_HISTORY_COMPLETE , getWeeklyMedicationHistoryCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_ALL_WEEKLY_MEDICATION_HISTORY_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function getUserDisplaySettings():void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_DISPLAY_SETTINGS_COMPLETE , getDisplaySettingsCompleteHandler);
			service.getUserDisplaySettings()
		}

		private function getDisplaySettingsCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_DISPLAY_SETTINGS_COMPLETE , getDisplaySettingsCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_DISPLAY_SETTINGS_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function addUserDisplaySettings(displaySettings:XML):void
		{
			service.addEventListener(RemoteDataStoreEvent.ADD_DISPLAY_SETTINGS_COMPLETE , addDisplaySettingsCompleteHandler);
			service.addUserDisplaySettings(displaySettings);
		}

		private function addDisplaySettingsCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.ADD_DISPLAY_SETTINGS_COMPLETE , addDisplaySettingsCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.ADD_DISPLAY_SETTINGS_COMPLETE);
			this.dispatchEvent(evt);
		}


		public function getUserAlertSettings():void
		{
			service.addEventListener(RemoteDataStoreEvent.GET_ALERT_SETTINGS_COMPLETE , getAlertSettingsCompleteHandler);
			service.getUserAlertSettings()
		}

		private function getAlertSettingsCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.GET_ALERT_SETTINGS_COMPLETE , getAlertSettingsCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.GET_ALERT_SETTINGS_COMPLETE);
			evt.data = e.data;
			this.dispatchEvent(evt);
		}

		public function addUserAlertSettings(alertSettings:XML):void
		{
			service.addEventListener(RemoteDataStoreEvent.ADD_ALERT_SETTINGS_COMPLETE , addAlertSettingsCompleteHandler);
			service.addUserAlertSettings(alertSettings);
		}

		private function addAlertSettingsCompleteHandler(e:RemoteDataStoreEvent):void
		{
			service.removeEventListener(RemoteDataStoreEvent.ADD_ALERT_SETTINGS_COMPLETE , addDisplaySettingsCompleteHandler);
			var evt:RemoteDataStoreEvent = new RemoteDataStoreEvent(RemoteDataStoreEvent.ADD_ALERT_SETTINGS_COMPLETE);
			this.dispatchEvent(evt);
		}

		public function get service():HivivaRemoteStoreService
		{
			return _hivivaRemoteStoreService;
		}
	}
}

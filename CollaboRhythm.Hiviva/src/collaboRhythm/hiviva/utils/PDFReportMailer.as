package collaboRhythm.hiviva.utils
{
	public class PDFReportMailer
	{
		public function PDFReportMailer()
		{
			initPDFCreator();
			//initPDFMailer();
		}

		private function initPDFCreator():void
		{

		}

		/*
		private function initPDFMailer():void
		{
			try
			{

				Message.init(Constants.DISTRIQT_ANE_DEVELOPER_LIC);
				trace("PDFReportMailer Message Supported: " + String(Message.isSupported));
				trace("PDFReportMailer Message Version: " + String(Message.service.version));
				trace("PDFReportMailer Mail Supported: " + String(Message.isMailSupported));

				Message.service.addEventListener(MessageEvent.MESSAGE_MAIL_ATTACHMENT_ERROR , messageErrorHandler);
				Message.service.addEventListener(MessageEvent.MESSAGE_MAIL_COMPOSE , messageComposeHandler);

			}
			catch (e:Error)
			{
				trace("PDFReportMailer " + e.message);
			}

		}

		private function messageComposeHandler(event:MessageEvent):void
		{

		}

		private function messageErrorHandler(event:MessageEvent):void
		{

		}
		*/
	}
}

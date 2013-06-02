package collaboRhythm.hiviva.global
{
	import starling.events.Event;


	public class FeathersScreenEvent extends Event
	{

		public static const NAVIGATE_AWAY:String						= "navigateAway";
		public static const HIDE_MAIN_NAV:String						= "hideMainNav";
		public static const SHOW_MAIN_NAV:String						= "showMainNav";
		public static const PATIENT_PROFILE_SELECTED:String				= "patientProfileSelected";
		public static const HCP_MESSAGE_SELECTED:String					= "hcpMessageSelected";
		//public static const PATIENT_EDIT_MEDICINE_CELL:String			= "patientEditMedicineCell";

		public var message:String;
		public var evtData:Object =  {};


		public function FeathersScreenEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}

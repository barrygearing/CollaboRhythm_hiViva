package collaboRhythm.hiviva.view.screens.patient.HelpScreens
{
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientHelpScreen;

	import feathers.controls.ScreenNavigator;
	import collaboRhythm.hiviva.global.HivivaScreens;
	import feathers.controls.ScreenNavigatorItem;

	public class HelpScreen1 extends HivivaPatientHelpScreen implements IHelpScreen
	{
		private var __screenName : String;
		private var __sNav : ScreenNavigator;
		private var __HivivaPatient_help_help_Screen:Object
		public function HelpScreen1(__sNav: ScreenNavigator   , __HivivaPatient_help_help_Screen:Object =null )
		{
        this.__sNav = __sNav;
	    this.__HivivaPatient_help_help_Screen = __HivivaPatient_help_help_Screen;
		}

		public function set__screenName(scr : String){

			this.__screenName = scr;

		}

		public function get__screenName():String{


           return this.__screenName;
		}


		public function  __addScreen(){

			//temp = String(HivivaScreens.PATIENT_HELP_HELP1_SCREEN);
			var screenNavItem1:ScreenNavigatorItem = new ScreenNavigatorItem(this.__HivivaPatient_help_help_Screen);
			this.__sNav.addScreen(HivivaScreens.PATIENT_HELP_ABOUT_SCREEN, screenNavItem1);



		}

		public function __showScreen(){

			this.__sNav.showScreen(HivivaScreens.PATIENT_HELP_ABOUT_SCREEN);


		}
	}
}

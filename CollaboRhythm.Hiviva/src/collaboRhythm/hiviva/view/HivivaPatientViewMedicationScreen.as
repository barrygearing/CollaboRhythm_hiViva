package collaboRhythm.hiviva.view
{

	import collaboRhythm.hiviva.global.HivivaScreens;

	import feathers.controls.Header;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.ToggleSwitch;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

	import starling.animation.Transitions;

	import starling.events.Event;


	public class HivivaPatientViewMedicationScreen extends Screen
	{
		private const TRANSITION_DURATION:Number						= 0.4;
		
		private var _header:Header;
		private var _clockPillboxToggle:ToggleSwitch;
		private var _clockPillboxNav:ScreenNavigator;
		private var _transitionMgr:ScreenSlidingStackTransitionManager;

		public function HivivaPatientViewMedicationScreen()
		{

		}

		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._clockPillboxToggle.x = (this.actualWidth / 2);
			this._clockPillboxToggle.y = 100;
		}

		override protected function initialize():void
		{

			this._header = new Header();
			this._header.title = "Your Medication";
			addChild(this._header);

			this._clockPillboxToggle = new ToggleSwitch();
			this._clockPillboxToggle.addEventListener( Event.CHANGE, toggleHandler );
			addChild(this._clockPillboxToggle);

			initClockPillboxNav();
		}

		private function initClockPillboxNav():void
		{
			this._clockPillboxNav = new ScreenNavigator();
			this._clockPillboxNav.addScreen(HivivaScreens.PATIENT_CLOCK_SCREEN , new ScreenNavigatorItem(HivivaPatientClockScreen));
			this.addChild(this._clockPillboxNav);

			this._transitionMgr = new ScreenSlidingStackTransitionManager(this._clockPillboxNav);
			this._transitionMgr.ease = Transitions.EASE_OUT;
			this._transitionMgr.duration = TRANSITION_DURATION;

			this._clockPillboxNav.showScreen(HivivaScreens.PATIENT_CLOCK_SCREEN);
		}

		private function toggleHandler(e:Event):void
		{

		}

	}
}

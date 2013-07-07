package collaboRhythm.hiviva.view
{


	import collaboRhythm.hiviva.global.Constants;
	import collaboRhythm.hiviva.global.FeathersScreenEvent;
	import collaboRhythm.hiviva.global.HivivaScreens;
	import collaboRhythm.hiviva.view.components.HCPFooterBtnGroup;
	import collaboRhythm.hiviva.view.components.IFooterBtnGroup;
	import collaboRhythm.hiviva.view.components.PatientFooterBtnGroup;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPAddPatientScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPAlertSettings;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPAllPatientsAdherenceScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPConnectToPatientScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPDisplaySettings;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPEditProfile;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPHomesScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPPatientProfileScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPProfileScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPReportsScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPSettingsScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPSideNavigationScreen;
	import collaboRhythm.hiviva.view.screens.hcp.messages.HivivaHCPMessageCompose;
	import collaboRhythm.hiviva.view.screens.hcp.messages.HivivaHCPMessages;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPHelpScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientAddHCP;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientBagesScreen;
	import collaboRhythm.hiviva.view.galleryscreens.SportsGalleryScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientAddMedsScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientConnectToHcpScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientEditMedsScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientSettingsScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientHelpScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientHomeScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientHomepagePhotoScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientMessagesScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientMyDetailsScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientProfileScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientReportsScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientSideNavScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientTakeMedsScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientTestResultsScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientViewMedicationScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientVirusModelScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientUserSignupScreen;
	import collaboRhythm.hiviva.view.screens.shared.HivivaSplashScreen;
	import collaboRhythm.hiviva.view.screens.shared.MainBackground;

	import feathers.controls.Button;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;

	import flash.filesystem.File;
	import flash.system.System;

	import source.themes.HivivaTheme;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import feathers.core.PopUpManager;

	public class Main extends Sprite
	{
		private var _screenHolder:Sprite;
		private var _screenBackground:MainBackground;
		private var _mainScreenNav:ScreenNavigator;
		private var _settingsNav:ScreenNavigator;
		private var _footerBtnGroup:IFooterBtnGroup;
		private var _settingsBtn:Button;
		private var _settingsOpen:Boolean = false;
		private var _currMainScreenId:String;
		private var _scaleFactor:Number;
		private var _bgTexture:Texture ;
		private var _passwordPopUp:PasswordPopUp;
        private var _preloader:HivivaPreloaderWithBackground;


		private var _patientSideNavScreen:HivivaPatientSideNavScreen;
		private var _hcpSideNavScreen:HivivaHCPSideNavigationScreen;

		private static var _selectedHCPPatientProfile:Object = {};
		private static var _assets:AssetManager;
		private static var _footerBtnGroupHeight:Number;

		public function Main()
		{
		}

		public function initMain(assetManager:AssetManager , bgTexture:Texture):void
		{
			_assets = assetManager;
			this._bgTexture = bgTexture;
			initAssetManagement();
		}

		private function initAssetManagement():void
		{
			var appDir:File = File.applicationDirectory;

			// texture Atlas
			_assets.enqueue(appDir.resolvePath("assets/images/atlas/homePagePhoto.atf"),appDir.resolvePath("assets/images/atlas/homePagePhoto.xml"));
			_assets.enqueue(appDir.resolvePath("assets/images/atlas/hivivaBaseImages.png"),appDir.resolvePath("assets/images/atlas/hivivaBaseImages.xml"));
			// fonts
			_assets.enqueue(appDir.resolvePath("assets/fonts/normal-white-regular.png"),appDir.resolvePath("assets/fonts/normal-white-regular.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/normal-white-bold.png"),appDir.resolvePath("assets/fonts/normal-white-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/engraved-dark-bold.png"),appDir.resolvePath("assets/fonts/engraved-dark-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/engraved-medium-bold.png"),appDir.resolvePath("assets/fonts/engraved-medium-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/engraved-light-bold.png"),appDir.resolvePath("assets/fonts/engraved-light-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/engraved-lighter-bold.png"),appDir.resolvePath("assets/fonts/engraved-lighter-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/engraved-lightest-bold.png"),appDir.resolvePath("assets/fonts/engraved-lightest-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/engraved-lighter-regular.png"),appDir.resolvePath("assets/fonts/engraved-lighter-regular.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/raised-lighter-bold.png"),appDir.resolvePath("assets/fonts/raised-lighter-bold.fnt"));

			this._preloader = new HivivaPreloaderWithBackground(0xF4E32C , 100 , 5 , this._bgTexture) ;
			this._preloader.init();
			this._preloader.y = 0;
			this._preloader.x = 0;
			this._preloader.validate();
			this.addChild(this._preloader);

			_assets.loadQueue(preloaderOnProgress);
		}

		private function preloaderOnProgress(ratio:Number):void
		{
			this._preloader._width = ratio * Constants.STAGE_WIDTH;
			this._preloader._ratio = ratio;
			this._preloader.dispatchEventWith(FeathersScreenEvent.PRELOADER_ONPOGRESS);

			if (ratio == 1)
			{
				this._preloader.dispose();
				removeChild(this._preloader);
				this._preloader = null;
				startup();
			}
		}

		private function startup():void
		{
			initfeathersTheme();
			initAppNavigator();
		}

		private function initfeathersTheme():void
		{
			//var isDesktop:Boolean = true;
			var isDesktop:Boolean = false;
			var _hivivaTheme:HivivaTheme = new HivivaTheme(this.stage, !isDesktop);
			this._scaleFactor = isDesktop ? 1 : _hivivaTheme.scale;
			_footerBtnGroupHeight = Constants.FOOTER_BTNGROUP_HEIGHT * this._scaleFactor;
		}

		private function initAppNavigator():void
		{
			this._screenHolder = new Sprite();
			this._mainScreenNav = new ScreenNavigator();
			this.addChild(this._screenHolder);
			this._screenHolder.addChild(this._mainScreenNav);

			this._mainScreenNav.addScreen(HivivaScreens.SPLASH_SCREEN, new ScreenNavigatorItem(HivivaSplashScreen , {complete:splashComplete}));
			this._mainScreenNav.showScreen(HivivaScreens.SPLASH_SCREEN);

			this._passwordPopUp = new PasswordPopUp();
			PopUpManager.addPopUp(this._passwordPopUp, true, true);
			this._passwordPopUp.validate();
		}

		private function splashComplete(e:Event):void
		{
			trace("splashComplete ");
			this._mainScreenNav.clearScreen();
			this._mainScreenNav.removeScreen(HivivaScreens.SPLASH_SCREEN);

			drawScreenBackground();
			drawSettingsBtn();

			this._settingsNav = new ScreenNavigator();
			this.addChild(this._settingsNav);

			switch(HivivaStartup.userVO.type)
			{
				case Constants.APP_TYPE_HCP :
					initHCPSettingsNavigator();
					initFooterMenu(HCPFooterBtnGroup);
					initHCPNavigator();
					break;

				case Constants.APP_TYPE_PATIENT :
					initPatientSettingsNavigator();
					initFooterMenu(PatientFooterBtnGroup);
					initPatientNavigator();
					break;
			}
		}

		protected function drawScreenBackground():void
		{
			this._screenBackground = new MainBackground();
			this._screenBackground.draw(Constants.STAGE_WIDTH , Constants.STAGE_HEIGHT);
			this._mainScreenNav.addChildAt(this._screenBackground , 0);
		}

		private function drawSettingsBtn():void
		{
			this._settingsBtn = new Button();
			this._settingsBtn.name = HivivaTheme.NONE_THEMED;
			this._settingsBtn.defaultIcon = new Image(_assets.getTexture("top_nav_icon_01"));
			this._settingsBtn.addEventListener(Event.TRIGGERED , settingsBtnHandler);
			this._screenHolder.addChild(this._settingsBtn);
			this._settingsBtn.width = (Constants.STAGE_WIDTH * 0.2);
			this._settingsBtn.scaleY = this._settingsBtn.scaleX;
		}

		private function settingsBtnHandler(e:Event = null):void
		{
			var xLoc:Number = _settingsOpen ? 0 : Constants.SETTING_MENU_WIDTH;

			var settingsTween:Tween = new Tween(this._screenHolder , 0.2 , Transitions.EASE_OUT);
			settingsTween.animate("x" , xLoc);
			settingsTween.onComplete = function():void{_settingsOpen = !_settingsOpen; Starling.juggler.remove(settingsTween);};
			Starling.juggler.add(settingsTween);
		}

		private function initPatientNavigator():void
		{
			this._patientSideNavScreen = new HivivaPatientSideNavScreen(Constants.SETTING_MENU_WIDTH, this._scaleFactor);
			this._patientSideNavScreen.addEventListener(FeathersScreenEvent.NAVIGATE_AWAY , settingsNavHandler);
			this.addChildAt(this._patientSideNavScreen , 0);

			this._mainScreenNav.addScreen(HivivaScreens.PATIENT_HOME_SCREEN, new ScreenNavigatorItem(HivivaPatientHomeScreen, {navGoSettings:navGoSettings}));
			this._mainScreenNav.addScreen(HivivaScreens.PATIENT_VIEW_MEDICATION_SCREEN, new ScreenNavigatorItem(HivivaPatientViewMedicationScreen));
			this._mainScreenNav.addScreen(HivivaScreens.PATIENT_MEDICATION_SCREEN, new ScreenNavigatorItem(HivivaPatientTakeMedsScreen ));
			this._mainScreenNav.addScreen(HivivaScreens.PATIENT_VIRUS_MODEL_SCREEN, new ScreenNavigatorItem(HivivaPatientVirusModelScreen));
			this._mainScreenNav.addScreen(HivivaScreens.PATIENT_REPORTS_SCREEN, new ScreenNavigatorItem(HivivaPatientReportsScreen));

		}

		private function initHCPNavigator():void
		{
			this._hcpSideNavScreen = new HivivaHCPSideNavigationScreen(Constants.SETTING_MENU_WIDTH, this._scaleFactor);
			this._hcpSideNavScreen.addEventListener(FeathersScreenEvent.NAVIGATE_AWAY , settingsNavHandler);
			this.addChildAt(this._hcpSideNavScreen , 0);

			this._mainScreenNav.addScreen(HivivaScreens.HCP_HOME_SCREEN, new ScreenNavigatorItem(HivivaHCPHomesScreen, {mainToSubNav:navigateToDirectProfileMenu}));
			this._mainScreenNav.addScreen(HivivaScreens.HCP_ADHERENCE_SCREEN, new ScreenNavigatorItem(HivivaHCPAllPatientsAdherenceScreen));
			this._mainScreenNav.addScreen(HivivaScreens.HCP_REPORTS_SCREEN, new ScreenNavigatorItem(HivivaHCPReportsScreen));
			this._mainScreenNav.addScreen(HivivaScreens.HCP_MESSAGE_SCREEN, new ScreenNavigatorItem(HivivaHCPMessages ,  {mainToSubNav:navigateToDirectProfileMenu}));

			// add listeners for homepage user signup check, to hide / show the footer and settings button
			addEventListener(FeathersScreenEvent.HIDE_MAIN_NAV, hideMainNav);
			addEventListener(FeathersScreenEvent.SHOW_MAIN_NAV, showMainNav);
		}

		private function initHCPSettingsNavigator():void
		{
			this._settingsNav.addScreen(HivivaScreens.HCP_PROFILE_SCREEN, new ScreenNavigatorItem(HivivaHCPProfileScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.HCP_HELP_SCREEN, new ScreenNavigatorItem(HivivaHCPHelpScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.HCP_EDIT_PROFILE, new ScreenNavigatorItem(HivivaHCPEditProfile));
			this._settingsNav.addScreen(HivivaScreens.HCP_DISPLAY_SETTINGS, new ScreenNavigatorItem(HivivaHCPDisplaySettings));
			this._settingsNav.addScreen(HivivaScreens.HCP_ALERT_SETTINGS, new ScreenNavigatorItem(HivivaHCPAlertSettings));
			this._settingsNav.addScreen(HivivaScreens.HCP_CONNECT_PATIENT, new ScreenNavigatorItem(HivivaHCPConnectToPatientScreen));
			this._settingsNav.addScreen(HivivaScreens.HCP_ADD_PATIENT, new ScreenNavigatorItem(HivivaHCPAddPatientScreen));
			this._settingsNav.addScreen(HivivaScreens.HCP_PATIENT_PROFILE, new ScreenNavigatorItem(HivivaHCPPatientProfileScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.HCP_MESSAGE_COMPOSE_SCREEN, new ScreenNavigatorItem(HivivaHCPMessageCompose, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.HCP_RESET_SETTINGS, new ScreenNavigatorItem(HivivaHCPSettingsScreen, {navGoHome:goBackToMainScreen, navFromReset:resetApplication}));

		}

		private function initPatientSettingsNavigator():void
		{
			this._settingsNav.addScreen(HivivaScreens.PATIENT_PROFILE_SCREEN , new ScreenNavigatorItem(HivivaPatientProfileScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_MY_DETAILS_SCREEN, new ScreenNavigatorItem(HivivaPatientMyDetailsScreen));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HOMEPAGE_PHOTO_SCREEN, new ScreenNavigatorItem(HivivaPatientHomepagePhotoScreen));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_GALLERY_SCREEN, new ScreenNavigatorItem(SportsGalleryScreen));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_TEST_RESULTS_SCREEN, new ScreenNavigatorItem(HivivaPatientTestResultsScreen));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_CONNECT_TO_HCP_SCREEN, new ScreenNavigatorItem(HivivaPatientConnectToHcpScreen));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_ADD_HCP, new ScreenNavigatorItem(HivivaPatientAddHCP));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_EDIT_MEDICATION_SCREEN, new ScreenNavigatorItem(HivivaPatientEditMedsScreen));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_ADD_MEDICATION_SCREEN, new ScreenNavigatorItem(HivivaPatientAddMedsScreen));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_USER_SIGNUP_SCREEN, new ScreenNavigatorItem(HivivaPatientUserSignupScreen));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_SCREEN, new ScreenNavigatorItem(HivivaPatientHelpScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_MESSAGES_SCREEN, new ScreenNavigatorItem(HivivaPatientMessagesScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_BADGES_SCREEN, new ScreenNavigatorItem(HivivaPatientBagesScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_EDIT_SETTINGS_SCREEN, new ScreenNavigatorItem(HivivaPatientSettingsScreen, {navGoHome:goBackToMainScreen , navFromReset:resetApplication}));
		}

		private function navigateToDirectProfileMenu(e:Event):void
		{
			if(e.data.patientName != null)
			{
				_selectedHCPPatientProfile.name = e.data.patientName;
				_selectedHCPPatientProfile.appID = e.data.appID;
			}
			var evt:FeathersScreenEvent = new FeathersScreenEvent(FeathersScreenEvent.NAVIGATE_AWAY);
			evt.message = e.data.profileMenu;

			settingsNavHandler(evt);
		}

		private function navGoSettings(e:Event):void
		{
			var evt:FeathersScreenEvent = new FeathersScreenEvent(FeathersScreenEvent.NAVIGATE_AWAY);
			evt.message = e.data.screen;
			settingsNavHandler(evt);
		}

		private function settingsNavHandler(e:FeathersScreenEvent):void
		{
			if(_settingsOpen) settingsBtnHandler();

			if(!this._settingsNav.contains(this._screenBackground)) this._settingsNav.addChild(this._screenBackground);
			this._settingsNav.showScreen(e.message);
			this._currMainScreenId = HivivaStartup.userVO.type == Constants.APP_TYPE_HCP ? HivivaScreens.HCP_HOME_SCREEN : HivivaScreens.PATIENT_HOME_SCREEN;
			this._mainScreenNav.clearScreen();
		}

		private function initFooterMenu(type:Class):void
		{
			this._footerBtnGroup = new type(this._mainScreenNav , this._scaleFactor);
			this._footerBtnGroup.asButtonGroup().y = Constants.STAGE_HEIGHT - _footerBtnGroupHeight;
			this._footerBtnGroup.asButtonGroup().width = Constants.STAGE_WIDTH;
			this._screenHolder.addChild(this._footerBtnGroup.asButtonGroup());
		}

		private function goBackToMainScreen():void
		{
			this._settingsNav.clearScreen();
			this._mainScreenNav.addChild(this._screenBackground);
			this._mainScreenNav.showScreen(this._currMainScreenId);
			this._footerBtnGroup.resetToHomeState();
		}

		private function resetApplication():void
		{
			this._settingsOpen = false;

			this._passwordPopUp.dispose();
			this._passwordPopUp = null;

			this._mainScreenNav.removeChild(this._screenBackground);
			this._screenBackground.dispose();
			this._screenBackground = null;

			this._mainScreenNav.clearScreen();
			this._screenHolder.removeChild(this._mainScreenNav);
			this._mainScreenNav.dispose();
			this._mainScreenNav = null;

			this._screenHolder.removeChild(this._settingsBtn);
			this._settingsBtn.dispose();
			this._settingsBtn = null;

			this._screenHolder.removeChild(this._footerBtnGroup.asButtonGroup());
			this._footerBtnGroup.asButtonGroup().dispose();
			this._footerBtnGroup = null;

			this._settingsNav.clearScreen();
			this.removeChild(this._settingsNav);
			this._settingsNav.dispose();
			this._settingsNav = null;

			if(this._hcpSideNavScreen != null)
			{
				this.removeChild(this._patientSideNavScreen);
				this._hcpSideNavScreen.dispose();
				this._hcpSideNavScreen = null;
			}
			else
			{
				this.removeChild(this._hcpSideNavScreen);
				this._patientSideNavScreen.dispose();
				this._patientSideNavScreen = null;
			}

			this._screenHolder.removeChildren(0,-1,true);
			this.removeChild(this._screenHolder);
			this._screenHolder.dispose();
			this._screenHolder = null;

			System.gc();

			initAppNavigator();
		}

		private function hideMainNav(e:FeathersScreenEvent):void
		{
			this._settingsBtn.touchable = false;
			this._settingsBtn.visible = false;

			this._footerBtnGroup.asButtonGroup().touchable = false;
			this._footerBtnGroup.asButtonGroup().visible = false;
		}

		private function showMainNav(e:FeathersScreenEvent):void
		{
			this._settingsBtn.touchable = true;
			this._settingsBtn.visible = true;

			this._footerBtnGroup.asButtonGroup().touchable = true;
			this._footerBtnGroup.asButtonGroup().visible = true;
		}

		public static function get selectedHCPPatientProfile():Object
		{
			return _selectedHCPPatientProfile;
		}

		public static function get assets():AssetManager
		{
			return _assets;
		}

		public static function get footerBtnGroupHeight():Number
		{
			return _footerBtnGroupHeight;
		}
	}
}

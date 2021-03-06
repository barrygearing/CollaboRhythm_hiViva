package collaboRhythm.hiviva.view
{

	import collaboRhythm.hiviva.global.Constants;
	import collaboRhythm.hiviva.global.FeathersScreenEvent;
	import collaboRhythm.hiviva.global.HivivaScreens;
	import collaboRhythm.hiviva.global.LocalDataStoreEvent;
	import collaboRhythm.hiviva.global.NotificationsEvent;
	import collaboRhythm.hiviva.view.components.HCPFooterBtnGroup;
	import collaboRhythm.hiviva.view.components.IFooterBtnGroup;
	import collaboRhythm.hiviva.view.components.PatientFooterBtnGroup;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPAddPatientScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPAlertSettings;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPAllPatientsAdherenceScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPConnectToPatientScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPDisplaySettings;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPHelpScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPHomesScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPMyDetailsScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPPatientProfileScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPProfileScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPReportsScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPSettingsScreen;
	import collaboRhythm.hiviva.view.screens.hcp.HivivaHCPSideNavigationScreen;
	import collaboRhythm.hiviva.view.screens.hcp.help.HivivaHCP_help_About_Screen;
	import collaboRhythm.hiviva.view.screens.hcp.help.HivivaHCP_help_Alerts_Screen;
	import collaboRhythm.hiviva.view.screens.hcp.help.HivivaHCP_help_Connect_To_Patient_Screen;
	import collaboRhythm.hiviva.view.screens.hcp.help.HivivaHCP_help_Display_Settings_Screen;
	import collaboRhythm.hiviva.view.screens.hcp.help.HivivaHCP_help_Generate_Reports_Screen;
	import collaboRhythm.hiviva.view.screens.hcp.help.HivivaHCP_help_GettingStarted_Screen;
	import collaboRhythm.hiviva.view.screens.hcp.help.HivivaHCP_help_Patient_Interaction_Screen;
	import collaboRhythm.hiviva.view.screens.hcp.help.HivivaHCP_help_Patient_Summary_Screen;
	import collaboRhythm.hiviva.view.screens.hcp.help.HivivaHCP_help_Privacy_Screen;
	import collaboRhythm.hiviva.view.screens.hcp.help.HivivaHCP_help_Single_Patient_Information_Screen;
	import collaboRhythm.hiviva.view.screens.hcp.help.HivivaHCP_help_Wcidwh_Screen;
	import collaboRhythm.hiviva.view.screens.hcp.messages.HivivaHCPMessageCompose;
	import collaboRhythm.hiviva.view.screens.hcp.messages.HivivaHCPMessages;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientAddHCP;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientAddMedsScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientBagesScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientConnectToHcpScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientEditMedsScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientHelpScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientHomeScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientHomepagePhotoScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientMessagesScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientMyDetailsScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientProfileScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientReportsScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientSettingsScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientSideNavScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientTakeMedsScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientTestResultsScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientViewMedicationScreen;
	import collaboRhythm.hiviva.view.screens.patient.HivivaPatientVirusModelScreen;
	import collaboRhythm.hiviva.view.screens.patient.help.HivivaPatient_help_Connect_To_Care_Provider_Screen;
	import collaboRhythm.hiviva.view.screens.patient.help.HivivaPatient_help_Create_Profile_Screen;
	import collaboRhythm.hiviva.view.screens.patient.help.HivivaPatient_help_DailyMedicines_Screen;
	import collaboRhythm.hiviva.view.screens.patient.help.HivivaPatient_help_GettingStarted_Screen;
	import collaboRhythm.hiviva.view.screens.patient.help.HivivaPatient_help_HomePagePhoto_Screen;
	import collaboRhythm.hiviva.view.screens.patient.help.HivivaPatient_help_Messages_Screen;
	import collaboRhythm.hiviva.view.screens.patient.help.HivivaPatient_help_Produce_A_Report_Screen;
	import collaboRhythm.hiviva.view.screens.patient.help.HivivaPatient_help_Register_Tolerability_Screen;
	import collaboRhythm.hiviva.view.screens.patient.help.HivivaPatient_help_Rewards_Screen;
	import collaboRhythm.hiviva.view.screens.patient.help.HivivaPatient_help_SeeAdherence_Screen;
	import collaboRhythm.hiviva.view.screens.patient.help.HivivaPatient_help_TakeMedicine_Screen;
	import collaboRhythm.hiviva.view.screens.patient.help.HivivaPatient_help_Take_Medication_Screen;
	import collaboRhythm.hiviva.view.screens.patient.help.HivivaPatient_help_TestResults_Screen;
	import collaboRhythm.hiviva.view.screens.patient.help.HivivaPatient_help_Virus_Model_Screen;
	import collaboRhythm.hiviva.view.screens.shared.HivivaResourceScreen;
	import collaboRhythm.hiviva.view.screens.shared.HivivaSplashScreen;
	import collaboRhythm.hiviva.view.screens.shared.InchPasscodeChange;
	import collaboRhythm.hiviva.view.screens.shared.InchPasscodeChangeConfirm;
	import collaboRhythm.hiviva.view.screens.shared.InchPasscodeLock;
	import collaboRhythm.hiviva.view.screens.shared.InchPasscodeRecoverQuestion;
	import collaboRhythm.hiviva.view.screens.shared.InchPasscodeRecoverUpdate;
	import collaboRhythm.hiviva.view.screens.shared.InchPasscodeSetup;
	import collaboRhythm.hiviva.view.screens.shared.MainBackground;

	import feathers.controls.Button;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.core.PopUpManager;

	import flash.display.StageDisplayState;

	import flash.events.MediaEvent;

	import flash.filesystem.File;
	import flash.media.CameraRoll;
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

	public class Main extends Sprite
	{
		private var _screenHolder:Sprite;
		private var _screenBackground:MainBackground;
		private var _mainScreenNav:ScreenNavigator;
		private var _settingsNav:ScreenNavigator;
		private var _footerBtnGroup:IFooterBtnGroup;
		private var _settingsBtn:Button;
		private var _settingBounceCount:int = 0;
		private var _settingsOpen:Boolean = false;
		private var _currMainScreenId:String;
		private var _scaleFactor:Number;
		private var _splashBgTexture:Texture ;
	    private var _preloader:HivivaPreloaderWithBackground;
		private var _patientSideNavScreen:HivivaPatientSideNavScreen;
		private var _hcpSideNavScreen:HivivaHCPSideNavigationScreen;
		private var _splashFirstRun:Boolean = true;
		private var _splashScreenNav:ScreenNavigator;
		private var _splashNavBg:MainBackground;
		private var _popupManagerHolder:Sprite;
		private var _settingsAnimationIsViewed:String;
		private var _showSettingAnimation:Boolean;

		private static var _selectedHCPPatientProfile:XML;
		private static var _assets:AssetManager;
		private static var _footerBtnGroupHeight:Number;
		private static var _parentOfPatientMyDetailsScreen:String;


		public function Main()
		{
		}

		public function initMain(assetManager:AssetManager , bgTexture:Texture):void
		{
			_assets = assetManager;
			this._splashBgTexture = bgTexture;
			initAssetManagement();
		}

		private function initAssetManagement():void
		{
			var appDir:File = File.applicationDirectory;

			// texture Atlas
			_assets.enqueue(appDir.resolvePath("assets/images/atlas/hivivaBaseImages.png"),appDir.resolvePath("assets/images/atlas/hivivaBaseImages.xml"));
			_assets.enqueue(appDir.resolvePath("assets/imagesv2/atlas/v2_hivivaBaseImages.png"),appDir.resolvePath("assets/imagesv2/atlas/v2_hivivaBaseImages.xml"));
			_assets.enqueue(appDir.resolvePath("assets/images/atlas/ApplePreloader.png"),appDir.resolvePath("assets/images/atlas/ApplePreloader.xml"));
			// fonts
			// blue theme
			_assets.enqueue(appDir.resolvePath("assets/fontsv2/v2-raised-white-bold.png"),appDir.resolvePath("assets/fontsv2/v2-raised-white-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fontsv2/v2-raised-white-regular.png"),appDir.resolvePath("assets/fontsv2/v2-raised-white-regular.fnt"));
//			_assets.enqueue(appDir.resolvePath("assets/fontsv2/v2-engraved-lighter-bold.png"),appDir.resolvePath("assets/fontsv2/v2-engraved-lighter-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fontsv2/v2-engraved-medark-bold.png"),appDir.resolvePath("assets/fontsv2/v2-engraved-medark-bold.fnt"));
			// grey theme
			_assets.enqueue(appDir.resolvePath("assets/fonts/normal-white-regular.png"),appDir.resolvePath("assets/fonts/normal-white-regular.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/normal-white-bold.png"),appDir.resolvePath("assets/fonts/normal-white-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/engraved-dark-bold.png"),appDir.resolvePath("assets/fonts/engraved-dark-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/engraved-medium-bold.png"),appDir.resolvePath("assets/fonts/engraved-medium-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/engraved-light-bold.png"),appDir.resolvePath("assets/fonts/engraved-light-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/engraved-lighter-bold.png"),appDir.resolvePath("assets/fonts/engraved-lighter-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/engraved-lightest-bold.png"),appDir.resolvePath("assets/fonts/engraved-lightest-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/engraved-lighter-regular.png"),appDir.resolvePath("assets/fonts/engraved-lighter-regular.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/fonts/raised-lighter-bold.png"),appDir.resolvePath("assets/fonts/raised-lighter-bold.fnt"));
			_assets.enqueue(appDir.resolvePath("assets/imagesv2/main_bg.jpg"));


			this._preloader = new HivivaPreloaderWithBackground(0xFFFFFFF , 100 , 5 , Texture.fromTexture(this._splashBgTexture));
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


				//cameraRollTest();
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
			var _hivivaTheme:HivivaTheme = new HivivaTheme(this.stage, !Constants.IS_DESKTOP);
			this._scaleFactor = Constants.IS_DESKTOP ? 1 : _hivivaTheme.scale;
			_footerBtnGroupHeight = Constants.FOOTER_BTNGROUP_HEIGHT * this._scaleFactor;
		}

		private function initAppNavigator():void
		{
			this._screenHolder = new Sprite();
			this._mainScreenNav = new ScreenNavigator();
			this.addChild(this._screenHolder);
			this._screenHolder.addChild(this._mainScreenNav);

			drawScreenBackground();

			this._settingsNav = new ScreenNavigator();
			this.addChild(this._settingsNav);

			this._popupManagerHolder = new Sprite();
			this.addChild(this._popupManagerHolder);
			PopUpManager.root = this._popupManagerHolder;

			this._splashScreenNav = new ScreenNavigator();
			this.addChild(this._splashScreenNav);

			this._splashNavBg = new MainBackground();
			this._splashNavBg.draw();
			this._splashScreenNav.addChildAt(this._splashNavBg , 0);

			this._splashScreenNav.addScreen(HivivaScreens.SPLASH_SCREEN, new ScreenNavigatorItem(HivivaSplashScreen , {complete:splashComplete} , {backgroundTexture:Texture.fromTexture(this._splashBgTexture)}));
			this._splashScreenNav.addScreen(HivivaScreens.PASSCODE_RECOVER_QUESTION_SCREEN, new ScreenNavigatorItem(InchPasscodeRecoverQuestion));
			this._splashScreenNav.addScreen(HivivaScreens.PASSCODE_RECOVER_UPDATE_SCREEN, new ScreenNavigatorItem(InchPasscodeRecoverUpdate));
			this._splashScreenNav.showScreen(HivivaScreens.SPLASH_SCREEN);

		}

		private function splashComplete(e:Event):void
		{

			this._splashScreenNav.clearScreen();
			this._splashScreenNav.removeChild(this._splashNavBg);
			this._splashNavBg.dispose();

			if(_splashFirstRun)
			{
				addEventListener(FeathersScreenEvent.HIDE_MAIN_NAV, hideMainNav);
				addEventListener(FeathersScreenEvent.SHOW_MAIN_NAV, showMainNav);

				HivivaStartup.hivivaAppController.hivivaNotificationsController.addEventListener(NotificationsEvent.ACTIAVTE_PASSCODE , initPasscodeFromActivate);

				drawSettingsBtn();

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
				_splashFirstRun = false;
			}
		}

		private function initPasscodeFromActivate(event:NotificationsEvent):void
		{

			this._splashNavBg = new MainBackground();
			this._splashNavBg.draw();
			this._splashScreenNav.addChildAt(this._splashNavBg , 0);
			this._splashScreenNav.showScreen(HivivaScreens.SPLASH_SCREEN);
		}

		protected function drawScreenBackground():void

		{
			this._screenBackground = new MainBackground();
			this._screenBackground.draw();
			this._mainScreenNav.addChildAt(this._screenBackground , 0);
		}

		private function drawSettingsBtn():void
		{
			this._settingsBtn = new Button();
			this._settingsBtn.name = HivivaTheme.NONE_THEMED;
//			this._settingsBtn.defaultIcon = new Image(_assets.getTexture("top_nav_icon_01"));
			this._settingsBtn.defaultIcon = new Image(_assets.getTexture("v2_top_nav_icon_01"));
			this._settingsBtn.addEventListener(Event.TRIGGERED , settingsBtnHandler);
			this._screenHolder.addChild(this._settingsBtn);
//			this._settingsBtn.width = (Constants.STAGE_WIDTH * 0.2);
//			this._settingsBtn.scaleY = this._settingsBtn.scaleX;

			// event received from homescreens at custom points
			addEventListener(FeathersScreenEvent.SHOW_SETTINGS_ANIMATION, userNeedsToViewSettingsAnimation);

			HivivaStartup.hivivaAppController.hivivaLocalStoreController.addEventListener(LocalDataStoreEvent.VIEWED_SETTINGS_ANIMATION_LOAD_COMPLETE, getViewedSettingsAnimationHandler);
			HivivaStartup.hivivaAppController.hivivaLocalStoreController.getViewedSettingsAnimation();
		}

		private function userNeedsToViewSettingsAnimation(e:FeathersScreenEvent):void
		{
			removeEventListener(FeathersScreenEvent.SHOW_SETTINGS_ANIMATION, userNeedsToViewSettingsAnimation);
			_showSettingAnimation = true;
			startSettingsBtnAnimation();
		}

		private function getViewedSettingsAnimationHandler(e:LocalDataStoreEvent):void
		{
			HivivaStartup.hivivaAppController.hivivaLocalStoreController.removeEventListener(LocalDataStoreEvent.VIEWED_SETTINGS_ANIMATION_LOAD_COMPLETE, getViewedSettingsAnimationHandler);
			_settingsAnimationIsViewed = String(e.data.settingsAnimationIsViewed);
			startSettingsBtnAnimation();
		}

		private function startSettingsBtnAnimation():void
		{
			if(_showSettingAnimation && _settingsAnimationIsViewed == "false")
			{
				HivivaStartup.hivivaAppController.hivivaLocalStoreController.addEventListener(LocalDataStoreEvent.VIEWED_SETTINGS_ANIMATION_SAVE_COMPLETE, setViewedSettingsAnimationHandler);
				HivivaStartup.hivivaAppController.hivivaLocalStoreController.setViewedSettingsAnimation();
				startSettingsBtnBounce();
			}
		}

		private function startSettingsBtnBounce():void
		{
			if (this._settingBounceCount < 3)
			{
				Starling.juggler.tween(this._settingsBtn, 0.3, {
					transition: Transitions.EASE_OUT,
					x: Constants.STAGE_WIDTH * 0.05,
					onComplete: endSettingBtnBounce
				});
			}
		}

		private function endSettingBtnBounce():void
		{
			this._settingBounceCount++;
			Starling.juggler.tween(this._settingsBtn, 0.6, {
				transition : Transitions.EASE_OUT_BOUNCE,
				x : 0,
				onComplete : startSettingsBtnBounce
			});
		}

		private function setViewedSettingsAnimationHandler(e:LocalDataStoreEvent):void
		{
			HivivaStartup.hivivaAppController.hivivaLocalStoreController.removeEventListener(LocalDataStoreEvent.VIEWED_SETTINGS_ANIMATION_SAVE_COMPLETE, setViewedSettingsAnimationHandler);
			trace("settings button will not animate again");
		}

		private function settingsBtnHandler(e:Event = null):void
		{
			var xLoc:Number = _settingsOpen ? 0 : Constants.SETTING_MENU_WIDTH;

			var settingsTween:Tween = new Tween(this._screenHolder , 0.2 , Transitions.EASE_OUT);
			settingsTween.animate("x" , xLoc);
			settingsTween.onComplete = function():void{_settingsOpen = !_settingsOpen; Starling.juggler.remove(settingsTween);};
			Starling.juggler.add(settingsTween);

			// to stop settings nav being clickable when the settings are closed
			switch(HivivaStartup.userVO.type)
			{
				case Constants.APP_TYPE_PATIENT :
					this._patientSideNavScreen.touchable = !_settingsOpen;
					break;
				case Constants.APP_TYPE_HCP :
					this._hcpSideNavScreen.touchable = !_settingsOpen;
					break;
			}
		}

		private function initPatientNavigator():void
		{
			this._patientSideNavScreen = new HivivaPatientSideNavScreen(Constants.SETTING_MENU_WIDTH, this._scaleFactor);
			this._patientSideNavScreen.addEventListener(FeathersScreenEvent.NAVIGATE_AWAY , settingsNavHandler);
			this.addChildAt(this._patientSideNavScreen , 0);
			this._patientSideNavScreen.touchable = false;

			this._mainScreenNav.addScreen(HivivaScreens.PATIENT_HOME_SCREEN, new ScreenNavigatorItem(HivivaPatientHomeScreen , {navGoSettings:navGoSettings}));
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
			this._hcpSideNavScreen.touchable = false;

			this._mainScreenNav.addScreen(HivivaScreens.HCP_HOME_SCREEN, new ScreenNavigatorItem(HivivaHCPHomesScreen, {mainToSubNav:navigateToDirectProfileMenu ,navGoToMessages:navGoToMessages }));
			this._mainScreenNav.addScreen(HivivaScreens.HCP_ADHERENCE_SCREEN, new ScreenNavigatorItem(HivivaHCPAllPatientsAdherenceScreen));
			this._mainScreenNav.addScreen(HivivaScreens.HCP_REPORTS_SCREEN, new ScreenNavigatorItem(HivivaHCPReportsScreen));
			this._mainScreenNav.addScreen(HivivaScreens.HCP_MESSAGE_SCREEN, new ScreenNavigatorItem(HivivaHCPMessages ,  {mainToSubNav:navigateToDirectProfileMenu}));
		}

		private function initHCPSettingsNavigator():void
		{
			this._settingsNav.addScreen(HivivaScreens.HCP_PROFILE_SCREEN, new ScreenNavigatorItem(HivivaHCPProfileScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.HCP_HELP_SCREEN, new ScreenNavigatorItem(HivivaHCPHelpScreen, {navGoHome:goBackToMainScreen}));
//			this._settingsNav.addScreen(HivivaScreens.HCP_EDIT_PROFILE, new ScreenNavigatorItem(HivivaHCPEditProfile));
			this._settingsNav.addScreen(HivivaScreens.HCP_MY_DETAILS_SCREEN, new ScreenNavigatorItem(HivivaHCPMyDetailsScreen));
			this._settingsNav.addScreen(HivivaScreens.HCP_DISPLAY_SETTINGS, new ScreenNavigatorItem(HivivaHCPDisplaySettings));
			this._settingsNav.addScreen(HivivaScreens.HCP_ALERT_SETTINGS, new ScreenNavigatorItem(HivivaHCPAlertSettings));
			this._settingsNav.addScreen(HivivaScreens.HCP_CONNECT_PATIENT, new ScreenNavigatorItem(HivivaHCPConnectToPatientScreen));
			this._settingsNav.addScreen(HivivaScreens.HCP_ADD_PATIENT, new ScreenNavigatorItem(HivivaHCPAddPatientScreen));
			this._settingsNav.addScreen(HivivaScreens.HCP_PATIENT_PROFILE, new ScreenNavigatorItem(HivivaHCPPatientProfileScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.HCP_MESSAGE_COMPOSE_SCREEN, new ScreenNavigatorItem(HivivaHCPMessageCompose, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.HCP_RESET_SETTINGS, new ScreenNavigatorItem(HivivaHCPSettingsScreen, {navGoHome:goBackToMainScreen, navFromReset:resetApplication}));
			this._settingsNav.addScreen(HivivaScreens.HCP_HELP_ABOUT_SCREEN, new ScreenNavigatorItem(HivivaHCP_help_About_Screen, {navGoHome:goBackToMainScreen }));
			this._settingsNav.addScreen(HivivaScreens.HCP_HELP_GETTINGSTARTED_SCREEN, new ScreenNavigatorItem(HivivaHCP_help_GettingStarted_Screen, {navGoHome:goBackToMainScreen }));
			this._settingsNav.addScreen(HivivaScreens.HCP_HELP_WCIDWH_SCREEN, new ScreenNavigatorItem(HivivaHCP_help_Wcidwh_Screen, {navGoHome:goBackToMainScreen }));
       		this._settingsNav.addScreen(HivivaScreens.HCP_HELP_DISPLAY_SETTINGS , new ScreenNavigatorItem(HivivaHCP_help_Display_Settings_Screen, {navGoHome:goBackToMainScreen }));
			this._settingsNav.addScreen(HivivaScreens.HCP_HELP_PRIVACY_SCREEN, new ScreenNavigatorItem(HivivaHCP_help_Privacy_Screen , {navGoHome:goBackToMainScreen }));
			this._settingsNav.addScreen(HivivaScreens.HCP_HELP_CONNECT_TO_PATIENT_SCREEN, new ScreenNavigatorItem(HivivaHCP_help_Connect_To_Patient_Screen , {navGoHome:goBackToMainScreen }));
			this._settingsNav.addScreen(HivivaScreens.HCP_HELP_PATIENT_SUMMARY_SCREEN, new ScreenNavigatorItem(HivivaHCP_help_Patient_Summary_Screen , {navGoHome:goBackToMainScreen }));
			this._settingsNav.addScreen(HivivaScreens.HCP_HELP_SINGLE_PATIENT_INFORMATION_SCREEN, new ScreenNavigatorItem(HivivaHCP_help_Single_Patient_Information_Screen , {navGoHome:goBackToMainScreen }));
			this._settingsNav.addScreen(HivivaScreens.HCP_HELP_PATIENT_INTERACTION_SCREEN, new ScreenNavigatorItem(HivivaHCP_help_Patient_Interaction_Screen , {navGoHome:goBackToMainScreen }));
			this._settingsNav.addScreen(HivivaScreens.HCP_HELP_GENERATE_REPORTS_SCREEN, new ScreenNavigatorItem(HivivaHCP_help_Generate_Reports_Screen , {navGoHome:goBackToMainScreen }));
			this._settingsNav.addScreen(HivivaScreens.HCP_HELP_ALERTS_SCREEN, new ScreenNavigatorItem(HivivaHCP_help_Alerts_Screen , {navGoHome:goBackToMainScreen }));
			this._settingsNav.addScreen(HivivaScreens.RESOURCES_SCREEN, new ScreenNavigatorItem(HivivaResourceScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PASSCODE_LOCK_SCREEN, new ScreenNavigatorItem(InchPasscodeLock));
			this._settingsNav.addScreen(HivivaScreens.PASSCODE_SETUP_SCREEN, new ScreenNavigatorItem(InchPasscodeSetup));
			this._settingsNav.addScreen(HivivaScreens.PASSCODE_CHANGE_CONFIRM_SCREEN, new ScreenNavigatorItem(InchPasscodeChangeConfirm));
			this._settingsNav.addScreen(HivivaScreens.PASSCODE_CHANGE_SCREEN, new ScreenNavigatorItem(InchPasscodeChange));
  		}

		private function initPatientSettingsNavigator():void
		{
			this._settingsNav.addScreen(HivivaScreens.PATIENT_PROFILE_SCREEN , new ScreenNavigatorItem(HivivaPatientProfileScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_MY_DETAILS_SCREEN, new ScreenNavigatorItem(HivivaPatientMyDetailsScreen));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HOMEPAGE_PHOTO_SCREEN, new ScreenNavigatorItem(HivivaPatientHomepagePhotoScreen));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_TEST_RESULTS_SCREEN, new ScreenNavigatorItem(HivivaPatientTestResultsScreen));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_CONNECT_TO_HCP_SCREEN, new ScreenNavigatorItem(HivivaPatientConnectToHcpScreen));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_ADD_HCP, new ScreenNavigatorItem(HivivaPatientAddHCP));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_EDIT_MEDICATION_SCREEN, new ScreenNavigatorItem(HivivaPatientEditMedsScreen));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_ADD_MEDICATION_SCREEN, new ScreenNavigatorItem(HivivaPatientAddMedsScreen));
			//this._settingsNav.addScreen(HivivaScreens.PATIENT_USER_SIGNUP_SCREEN, new ScreenNavigatorItem(HivivaPatientUserSignupScreen));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_SCREEN, new ScreenNavigatorItem(HivivaPatientHelpScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_GETTINGSTARTED_SCREEN, new ScreenNavigatorItem(HivivaPatient_help_GettingStarted_Screen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_DAILY_MEDICINES_SCREEN, new ScreenNavigatorItem(HivivaPatient_help_DailyMedicines_Screen, {navGoHome:goBackToMainScreen}));
		    this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_HOMEPAGE_PHOTO_SCREEN, new ScreenNavigatorItem(HivivaPatient_help_HomePagePhoto_Screen, {navGoHome:goBackToMainScreen}));
		    this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_TAKE_MEDICATION_SCREEN, new ScreenNavigatorItem(HivivaPatient_help_Take_Medication_Screen, {navGoHome:goBackToMainScreen}));
		    this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_CREATE_PROFILE_SCREEN, new ScreenNavigatorItem(HivivaPatient_help_Create_Profile_Screen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_CONNECT_TO_CARE_PROVIDER_SCREEN, new ScreenNavigatorItem(HivivaPatient_help_Connect_To_Care_Provider_Screen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_TEST_RESULTS_SCREEN, new ScreenNavigatorItem(HivivaPatient_help_TestResults_Screen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_TAKE_MEDICINE_SCREEN, new ScreenNavigatorItem(HivivaPatient_help_TakeMedicine_Screen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_SEE_ADHERENCE_SCREEN, new ScreenNavigatorItem(HivivaPatient_help_SeeAdherence_Screen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_REWARDS_SCREEN, new ScreenNavigatorItem(HivivaPatient_help_Rewards_Screen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_MESSAGES_SCREEN, new ScreenNavigatorItem(HivivaPatient_help_Messages_Screen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_REGISTER_TOLERABILITY_SCREEN, new ScreenNavigatorItem(HivivaPatient_help_Register_Tolerability_Screen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_VIRUS_MODEL_SCREEN, new ScreenNavigatorItem(HivivaPatient_help_Virus_Model_Screen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_HELP_PULL_REPORTS_SCREEN, new ScreenNavigatorItem(HivivaPatient_help_Produce_A_Report_Screen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_MESSAGES_SCREEN, new ScreenNavigatorItem(HivivaPatientMessagesScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_BADGES_SCREEN, new ScreenNavigatorItem(HivivaPatientBagesScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PATIENT_EDIT_SETTINGS_SCREEN, new ScreenNavigatorItem(HivivaPatientSettingsScreen, {navGoHome:goBackToMainScreen , navFromReset:resetApplication}));
			this._settingsNav.addScreen(HivivaScreens.RESOURCES_SCREEN, new ScreenNavigatorItem(HivivaResourceScreen, {navGoHome:goBackToMainScreen}));
			this._settingsNav.addScreen(HivivaScreens.PASSCODE_LOCK_SCREEN, new ScreenNavigatorItem(InchPasscodeLock));
			this._settingsNav.addScreen(HivivaScreens.PASSCODE_SETUP_SCREEN, new ScreenNavigatorItem(InchPasscodeSetup));
			this._settingsNav.addScreen(HivivaScreens.PASSCODE_CHANGE_CONFIRM_SCREEN, new ScreenNavigatorItem(InchPasscodeChangeConfirm));
			this._settingsNav.addScreen(HivivaScreens.PASSCODE_CHANGE_SCREEN, new ScreenNavigatorItem(InchPasscodeChange));
		}

		private function navGoToMessages():void
		{
			this._footerBtnGroup.navigateToMessages();
		}

		private function navigateToDirectProfileMenu(e:Event):void
		{
//			if(e.data.patientProfile != null) _selectedHCPPatientProfile = e.data.patientProfile as XML;
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
			/*if(_settingsOpen)
			{
				settingsBtnHandler();
			}*/

			Starling.juggler.removeTweens(this._screenHolder);
			this._screenHolder.x = 0;
			this._settingsOpen = false;

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

			ImageUploader.removeUploadedImageFile(Constants.USER_PROFILE_IMAGE);
			ImageUploader.removeUploadedImageFile(Constants.CUSTOM_HOME_IMAGE);

			HivivaStartup.patientAdherenceVO.percentage = 0;
			HivivaStartup.connectionsVO.users = [];
			HivivaStartup.reportVO.settingsData = null;

			System.gc();

			initAppNavigator();
		}

		private function hideMainNav(e:FeathersScreenEvent):void
		{
			this._settingsOpen = true;
			settingsBtnHandler();

			this._settingsBtn.touchable = false;
			this._settingsBtn.visible = false;

			this._footerBtnGroup.asButtonGroup().touchable = false;
			this._footerBtnGroup.asButtonGroup().visible = false;
		}

		private function showMainNav(e:FeathersScreenEvent):void
		{
			this._settingsOpen = true;
			settingsBtnHandler();

			this._settingsBtn.touchable = true;
			this._settingsBtn.visible = true;

			this._footerBtnGroup.asButtonGroup().touchable = true;
			this._footerBtnGroup.asButtonGroup().visible = true;
		}

		public static function set selectedHCPPatientProfile(value:XML):void
		{
			_selectedHCPPatientProfile = value;
		}

		public static function get selectedHCPPatientProfile():XML
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

		public function get popupManagerHolder():Sprite
		{
			return _popupManagerHolder;
		}

		public function set popupManagerHolder(value:Sprite):void
		{
			_popupManagerHolder = value;
		}

		public static function get parentOfPatientMyDetailsScreen():String
		{
			return _parentOfPatientMyDetailsScreen;
		}

		public static function set parentOfPatientMyDetailsScreen(value:String):void
		{
			_parentOfPatientMyDetailsScreen = value;
		}
	}
}

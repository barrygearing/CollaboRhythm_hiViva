package collaboRhythm.hiviva.view.screens.patient
{
	import collaboRhythm.hiviva.global.FeathersScreenEvent;
	import collaboRhythm.hiviva.global.HivivaScreens;
	import collaboRhythm.hiviva.view.Main;

	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;

	import starling.display.Image;
	import starling.events.Event;

	public class HivivaPatientSideNavScreen extends Screen
	{

		private var WIDTH:Number;
		private var SCALE:Number;
		private var _sideBtnGroup:ButtonGroup;

		public function HivivaPatientSideNavScreen(gWidth:Number, scale:Number)
		{
			WIDTH = gWidth;
			SCALE = scale;
		}

		override protected function draw():void
		{
			this._sideBtnGroup.width = WIDTH;
		}

		override protected function initialize():void
		{
			// needs own class
			var btnHeight:Number = 131 * SCALE;
			var btnWidth:Number = 177 * SCALE;

			this._sideBtnGroup = new ButtonGroup();
			this._sideBtnGroup.customButtonName = "side-nav-buttons";
			this._sideBtnGroup.customFirstButtonName = "side-nav-buttons";
			this._sideBtnGroup.customLastButtonName = "side-nav-buttons";

			this._sideBtnGroup.dataProvider = new ListCollection(
				[
					{ width: btnWidth, height: btnHeight, name: "profile", label: "PROFILE" },
					{ width: btnWidth, height: btnHeight, name: "help", label: "HELP"},
					{ width: btnWidth, height: btnHeight, name: "messages", label: "MESSAGES"},
					{ width: btnWidth, height: btnHeight, name: "kudos", label: "KUDOS"},
					{ width: btnWidth, height: btnHeight, name: "resources", label: "RESOURCES"}
				]
			);
			this._sideBtnGroup.buttonInitializer = function(button:Button, item:Object):void
			{
				var img:Image;

				button.name = item.name;
				button.label = item.label;
				button.addEventListener(Event.TRIGGERED, sideNavBtnHandler);

				switch(item.name)
				{
					case "profile" :
//						img = new Image(Main.assets.getTexture("side_nav_icon_01"));
						img = new Image(Main.assets.getTexture("v2_side_nav_icon_01"));
						break;
					case "help" :
//						img = new Image(Main.assets.getTexture("side_nav_icon_02"));
						img = new Image(Main.assets.getTexture("v2_side_nav_icon_02"));
						break;
					case "messages" :
//						img = new Image(Main.assets.getTexture("side_nav_icon_03"));
						img = new Image(Main.assets.getTexture("v2_side_nav_icon_03"));
						break;
					case "kudos" :
//						img = new Image(Main.assets.getTexture("side_nav_icon_04"));
						img = new Image(Main.assets.getTexture("v2_side_nav_icon_04"));
						break;
					case "resources" :
						img = new Image(Main.assets.getTexture("v2_side_nav_icon_05"));
						break;
				}

				img.width = item.width;
				img.height = item.height;
				button.addChild(img);
			};

			this.addChild(this._sideBtnGroup);
			this._sideBtnGroup.width = this.stage.width;
			this._sideBtnGroup.direction = ButtonGroup.DIRECTION_VERTICAL;
		}

		private function sideNavBtnHandler(e:Event):void
		{
			var navAwayEvent:FeathersScreenEvent = new FeathersScreenEvent(FeathersScreenEvent.NAVIGATE_AWAY);
			var btn:Button = e.target as Button;
			// when refactoring to own class we can use a local instance instead of storing the identifier in btn.name
			switch(btn.name.substring(0 ,btn.name.indexOf(" side-nav-buttons")))
			{
				case "profile" :
					navAwayEvent.message = HivivaScreens.PATIENT_PROFILE_SCREEN;
					break;
				case "help" :
					navAwayEvent.message = HivivaScreens.PATIENT_HELP_SCREEN;
					break;
				case "messages" :
					navAwayEvent.message = HivivaScreens.PATIENT_MESSAGES_SCREEN;
					break;
				case "kudos" :
					navAwayEvent.message = HivivaScreens.PATIENT_BADGES_SCREEN;
					break;
				case "resources" :
					navAwayEvent.message = HivivaScreens.RESOURCES_SCREEN;
					break;
			}

			this.dispatchEvent(navAwayEvent);
		}

		override public function dispose():void
		{
			super.dispose();
			this.removeChild(this._sideBtnGroup);
			this._sideBtnGroup.dispose();
			this._sideBtnGroup = null;
			trace("Dispose called from HivivaPatientSideNavScreen");
		}

	}
}

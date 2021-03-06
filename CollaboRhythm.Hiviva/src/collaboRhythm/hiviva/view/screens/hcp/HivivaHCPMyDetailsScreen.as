package collaboRhythm.hiviva.view.screens.hcp
{
	import collaboRhythm.hiviva.global.Constants;
	import collaboRhythm.hiviva.global.FeathersScreenEvent;
	import collaboRhythm.hiviva.global.HivivaScreens;
	import collaboRhythm.hiviva.global.HivivaThemeConstants;
	import collaboRhythm.hiviva.global.LocalDataStoreEvent;
	import collaboRhythm.hiviva.global.RemoteDataStoreEvent;
	import collaboRhythm.hiviva.utils.HivivaModifier;
	import collaboRhythm.hiviva.view.*;
	import collaboRhythm.hiviva.view.components.BoxedButtons;
	import collaboRhythm.hiviva.view.screens.shared.ValidationScreen;

	import feathers.controls.Button;
	import feathers.controls.Label;

	import flash.text.AutoCapitalize;
	import flash.utils.ByteArray;

	import mx.utils.Base64Encoder;

	import starling.display.DisplayObject;
	import starling.events.Event;

	public class HivivaHCPMyDetailsScreen extends ValidationScreen
	{
		private var _instructionsText:Label;
		private var _firstNameInput:LabelAndInput;
		private var _lastNameInput:LabelAndInput;
		private var _photoTitle:Label;
		private var _photoContainer:ImageUploader;
		private var _cancelAndSave:BoxedButtons;
		private var _backButton:Button;
		private var _isThisFromHome:Boolean;
		private var _saveUserDataXml:XML;
		private var _userPicSaved:Boolean = false;

		public function HivivaHCPMyDetailsScreen()
		{

		}

		override protected function draw():void
		{
			this._componentGap *= 0.5;
			super.draw();
		}

		override protected function preValidateContent():void
		{
			super.preValidateContent();
			this._instructionsText.width = this._innerWidth;

			this._firstNameInput._labelLeft.text = "First name";
			this._firstNameInput.width = this._innerWidth;
			this._firstNameInput._input.width = this._innerWidth * 0.7;

			this._lastNameInput._labelLeft.text = "Last name";
			this._lastNameInput.width = this._innerWidth;
			this._lastNameInput._input.width = this._innerWidth * 0.7;

			this._photoTitle.width = this._innerWidth;

			this._photoContainer.width = this._innerWidth;

			this._cancelAndSave.width = this._innerWidth;
		}

		/*override protected function postValidateContent():void
		{
			super.postValidateContent();
		}*/

		override protected function initialize():void
		{
			super.initialize();

			this._isThisFromHome = this.owner.hasScreen(HivivaScreens.HCP_HOME_SCREEN);

			this._header.title = this._isThisFromHome ? "Create Profile" : "Edit profile";

			this._instructionsText = new Label();
//			this._instructionsText.text = "Profile required in order to connect to a care provider";
			this._instructionsText.text = "This will be your display name";
			this._content.addChild(this._instructionsText);

			this._firstNameInput = new LabelAndInput();
//			this._firstNameInput.scale = this.dpiScale;
			this._firstNameInput.labelStructure = "left";
			this._content.addChild(this._firstNameInput);
			this._firstNameInput._input.textEditorProperties.autoCapitalize = AutoCapitalize.WORD;

			this._lastNameInput = new LabelAndInput();
//			this._lastNameInput.scale = this.dpiScale;
			this._lastNameInput.labelStructure = "left";
			this._content.addChild(this._lastNameInput);
			this._lastNameInput._input.textEditorProperties.autoCapitalize = AutoCapitalize.WORD;

			this._photoTitle = new Label();
			this._photoTitle.name = HivivaThemeConstants.SUBHEADER_LABEL;
			this._photoTitle.text = "Photo";
			this._content.addChild(this._photoTitle);

			this._photoContainer = new ImageUploader();
			this._photoContainer.defaultImage = "v2_profile_img";
//			this._photoContainer.scale = this.dpiScale;
//			this._photoContainer.fileName = Constants.USER_PROFILE_IMAGE;
			this._photoContainer.fileName = HivivaStartup.userVO.guid + ".jpg";
			this._content.addChild(this._photoContainer);
			this._photoContainer.getMainImage();

			this._cancelAndSave = new BoxedButtons();
			this._cancelAndSave.addEventListener(Event.TRIGGERED, cancelAndSaveHandler);
//			this._cancelAndSave.scale = this.dpiScale;
			this._cancelAndSave.labels = ["Cancel", "Save"];
			this._content.addChild(this._cancelAndSave);

			this._backButton = new Button();
			this._backButton.name = HivivaThemeConstants.BACK_BUTTON;
			this._backButton.label = "Back";
			this._backButton.addEventListener(Event.TRIGGERED, backBtnHandler);

			this._header.leftItems = new <DisplayObject>[_backButton];

			populateOldData();

			if(this._isThisFromHome) dispatchEvent(new FeathersScreenEvent(FeathersScreenEvent.HIDE_MAIN_NAV, true));
		}

		private function cancelAndSaveHandler(e:Event):void
		{
			var button:String = e.data.button;
			switch(button)
			{
				case "Cancel" :
					backBtnHandler();
					break;
				case "Save" :
					var formValidation:String = HCPMyDetailsCheck();
					if(formValidation.length == 0)
					{
						saveUser();
						this._photoContainer.saveTempImageAsMain();
					}
					else
					{
						showFormValidation(formValidation);
					}
					break;
			}
		}

		private function backBtnHandler(e:Event = null):void
		{
			if(this._isThisFromHome)
			{
				dispatchEvent(new FeathersScreenEvent(FeathersScreenEvent.SHOW_MAIN_NAV, true));
				this.owner.showScreen(HivivaScreens.HCP_HOME_SCREEN);
			}
			else
			{
				this.owner.showScreen(HivivaScreens.HCP_PROFILE_SCREEN);
			}
			hideFormValidation();
		}

		private function HCPMyDetailsCheck():String
		{
			var validationArray:Array = [];

			if(this._firstNameInput._input.text.length == 0) validationArray.push("Please enter a first name");
			if(this._lastNameInput._input.text.length == 0) validationArray.push("Please enter a last name");

			return validationArray.join(",\n");
		}

		private function saveUser():void
		{
			var base64Encoder:Base64Encoder;
			var pictureByteString:String = "";
			var pictureData:XML;
			var guid:String = HivivaStartup.userVO.guid;
			var pictureByteArray:ByteArray = this._photoContainer.savableImageBytes;

			_saveUserDataXml =
					<DCHealthUser>
						<UserGuid>{guid}</UserGuid>
						<FirstName>{this._firstNameInput._input.text}</FirstName>
						<LastName>{this._lastNameInput._input.text}</LastName>
					</DCHealthUser>;



			// ******** SEND IMAGE TO SERVICE CODE ********** //

			if(pictureByteArray != null)
			{
				base64Encoder = new Base64Encoder();
				base64Encoder.encodeBytes(pictureByteArray);
				pictureByteString = base64Encoder.toString();
			}

			pictureData =
					<DCPictureFile>
						<PictureName>{guid + ".jpg"}</PictureName>
						<PictureStream>{pictureByteString}</PictureStream>
					</DCPictureFile>;

			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.addEventListener(RemoteDataStoreEvent.SAVE_USER_PICTURE_COMPLETE, saveUserPictureCompleteHandler);
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.saveUserPicture(pictureData);

			// ******** TEST CODE BELOW CREATES IMAGE FROM BYTEARRAY AND PLACES IT ON THE STAGE ********** //

			/*var base64Deccoder:Base64Decoder = new Base64Decoder();
			base64Deccoder.decode(pictureByteString);

			var test:ByteArray = base64Deccoder.toByteArray();

			var ploader:flash.display.Loader = new flash.display.Loader();

			ploader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, function (e:flash.events.Event) : void {
				var resultBmd:Bitmap = ploader.content as Bitmap;
				var img:Image = new Image(Texture.fromBitmap(resultBmd));
				addChild(img);
		    });
			ploader.loadBytes(test);*/
		}

		private function saveUserPictureCompleteHandler(e:RemoteDataStoreEvent):void
		{
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.removeEventListener(RemoteDataStoreEvent.SAVE_USER_PICTURE_COMPLETE, saveUserCompleteHandler);
			this._userPicSaved = e.data.xmlResponse == "success";
			if(this._userPicSaved) this._photoContainer.saveTempImageAsMain();
			saveUserData();
		}

		private function saveUserData():void
		{
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.addEventListener(RemoteDataStoreEvent.SAVE_USER_COMPLETE, saveUserCompleteHandler);
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.saveUser(_saveUserDataXml);

			HivivaStartup.hivivaAppController.hivivaLocalStoreController.addEventListener(LocalDataStoreEvent.APP_FULLNAME_SAVE_COMPLETE, saveUserFullnameHandler);
			HivivaStartup.hivivaAppController.hivivaLocalStoreController.saveUserFullname(_saveUserDataXml.FirstName + " " + _saveUserDataXml.LastName);
		}

		private function saveUserCompleteHandler(e:RemoteDataStoreEvent):void
		{
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.removeEventListener(RemoteDataStoreEvent.SAVE_USER_COMPLETE, saveUserCompleteHandler);
			showFormValidation("User profile" + (this._userPicSaved ? " and photo " :  " ") + "saved");

			if(this._isThisFromHome)
			{
				dispatchEvent(new FeathersScreenEvent(FeathersScreenEvent.SHOW_MAIN_NAV, true));
				this.owner.showScreen(HivivaScreens.HCP_HOME_SCREEN);
			}
		}

		private function saveUserFullnameHandler(e:LocalDataStoreEvent):void
		{
			HivivaStartup.hivivaAppController.hivivaLocalStoreController.removeEventListener(LocalDataStoreEvent.APP_FULLNAME_SAVE_COMPLETE, saveUserFullnameHandler);
			trace("HivivaStartup.userVO.fullName = " + HivivaStartup.userVO.fullName);
		}

		private function populateOldData():void
		{
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.addEventListener(RemoteDataStoreEvent.GET_HCP_COMPLETE , getHCPCompleteHandler);
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.getHCP(HivivaStartup.userVO.appId);

			// ******** GET IMAGE FROM SERVICE CODE ********** //
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.addEventListener(RemoteDataStoreEvent.GET_USER_PICTURE_COMPLETE, getUserPictureCompleteHandler);
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.getUserPicture(HivivaStartup.userVO.guid);
		}

		private function getUserPictureCompleteHandler(e:RemoteDataStoreEvent):void
		{
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.removeEventListener(RemoteDataStoreEvent.GET_USER_PICTURE_COMPLETE, getUserPictureCompleteHandler);

			var pictureStream:String;
			var _getUserDataXml:XML = e.data.xmlResponse as XML;
			if(_getUserDataXml.children().length() > 0)
			{
				pictureStream = _getUserDataXml.PictureStream;
				if(pictureStream.length > 0)
				{
					HivivaModifier.saveUserPictureToAppStorage(_getUserDataXml.PictureName,pictureStream);
					this._photoContainer.getMainImage();
				}
			}
		}

		private function getHCPCompleteHandler(e:RemoteDataStoreEvent):void
		{
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.removeEventListener(RemoteDataStoreEvent.GET_HCP_COMPLETE , getHCPCompleteHandler);

			this._firstNameInput._input.text = e.data.xmlResponse.FirstName;
			this._lastNameInput._input.text = e.data.xmlResponse.LastName;
		}

		public override function dispose():void
		{
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.removeEventListener(RemoteDataStoreEvent.SAVE_USER_COMPLETE, saveUserCompleteHandler);
			HivivaStartup.hivivaAppController.hivivaLocalStoreController.removeEventListener(LocalDataStoreEvent.APP_FULLNAME_SAVE_COMPLETE, saveUserFullnameHandler);
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.removeEventListener(RemoteDataStoreEvent.GET_HCP_COMPLETE , getHCPCompleteHandler);
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.removeEventListener(RemoteDataStoreEvent.SAVE_USER_PICTURE_COMPLETE, saveUserCompleteHandler);
			HivivaStartup.hivivaAppController.hivivaRemoteStoreController.removeEventListener(RemoteDataStoreEvent.GET_USER_PICTURE_COMPLETE, getUserPictureCompleteHandler);
			super.dispose();
		}
	}
}

package collaboRhythm.hiviva.view
{
	import collaboRhythm.hiviva.global.HivivaScreens;
	import collaboRhythm.hiviva.utils.MedicationNameModifier;
	import collaboRhythm.hiviva.view.galleryscreens.Gallery;

	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.layout.HorizontalLayout;

	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.text.TextFormatAlign;

	import starling.display.DisplayObject;
	import starling.events.Event;

	public class HivivaPatientHomepagePhotoScreen extends Screen
	{
		private var _header:HivivaHeader;
		private var _loadText:Label;
		private var _galleriesContainer:ScrollContainer;
		private var _photoContainer:ImageUploader;
		private var _cancelButton:Button;
		private var _submitButton:Button;
		private var _backButton:Button;
		private var _galleries:Vector.<Gallery>;
		private var _galleryCount:int;
		private var _galleryLength:int;
		private var _galleryPadding:Number;
		private var _sqConn:SQLConnection;
		private var _sqStatement:SQLStatement;
		private var _resultData:Array;
		private var _dataPreExists:Boolean;
		private var _sqDataToWrite:String;
		private var _selectedItemsCount:int;

		private const GALLERY_CATEGORIES:Array = ["sport","music","cinema","history","traveling","art"];
		private const PADDING:Number = 32

		public function HivivaPatientHomepagePhotoScreen()
		{

		}

		override protected function draw():void
		{
			var scaledPadding:Number = PADDING * this.dpiScale;

			super.draw();
			this._header.width = this.actualWidth;
			this._header.height = 110 * this.dpiScale;

			this._cancelButton.validate();
			this._cancelButton.y = this.actualHeight - this._cancelButton.height - scaledPadding;
			this._cancelButton.x = scaledPadding;

			this._submitButton.validate();
			this._submitButton.y = this._cancelButton.y;
			this._submitButton.x = this._cancelButton.x + this._cancelButton.width + (20 * this.dpiScale);

			this._photoContainer.width = this.actualWidth;
			this._photoContainer.validate();
			this._photoContainer.y = this._cancelButton.y - scaledPadding - this._photoContainer.height;

			this._loadText.width = this.actualWidth;
			this._loadText.validate();
			this._loadText.x = (this.actualWidth * 0.5) - (this._loadText.width * 0.5);
			this._loadText.y = (this._photoContainer.y * 0.5) - (this._loadText.height * 0.5);

			if (this._galleries.length == 0) initGallery();

			oldDataCheck();
		}

		override protected function initialize():void
		{
			this._galleries = new <Gallery>[];

			super.initialize();

			this._header = new HivivaHeader();
			this._header.title = "Homepage Photo";
			addChild(this._header);

			this._loadText = new Label();
			this._loadText.name = "centered-label";
			this._loadText.text = "Loading images...";
			addChild(this._loadText);

			this._photoContainer = new ImageUploader();
			this._photoContainer.scale = this.dpiScale;
			this._photoContainer.fileName = "homepageimage.jpg";
			addChild(this._photoContainer);

			this._cancelButton = new Button();
			this._cancelButton.label = "Cancel";
			this._cancelButton.addEventListener(Event.TRIGGERED, cancelButtonClick);
			addChild(this._cancelButton);

			this._submitButton = new Button();
			this._submitButton.label = "Save";
			this._submitButton.addEventListener(Event.TRIGGERED, submitButtonClick);
			addChild(this._submitButton);

			this._backButton = new Button();
			this._backButton.name = "back-button";
			this._backButton.label = "Back";
			this._backButton.addEventListener(Event.TRIGGERED, backBtnHandler);

			this._header.leftItems = new <DisplayObject>[_backButton];
		}

		private function cancelButtonClick(e:Event):void
		{
			this.owner.showScreen(HivivaScreens.PATIENT_PROFILE_SCREEN);
		}

		private function backBtnHandler(e:Event):void
		{
			this.owner.showScreen(HivivaScreens.PATIENT_PROFILE_SCREEN);
		}

		private function submitButtonClick(e:Event):void
		{
			getSqDataFromGalleries();
			getSqDataFromCustomImage();

			if(this._sqDataToWrite.length > 0)
			{
				if(this._dataPreExists)
				{
					this._sqStatement = new SQLStatement();
					this._sqStatement.text = "DELETE FROM homepage_photos";
					this._sqStatement.sqlConnection = this._sqConn;
					this._sqStatement.addEventListener(SQLEvent.RESULT, tableDataDeleted);
					this._sqStatement.execute();
				}
				else
				{
					writeImageData();
				}
			}
			else
			{
				trace("nothing selected");
			}
		}

		private function getSqDataFromGalleries():void
		{
			var currGallery:Gallery,
				currGallerySelectedItems:Array,
				selectedItem:String,
				isFirstItem:Boolean = true;

			this._selectedItemsCount = 0;
			this._sqDataToWrite = "";

			//shuffleList(this._galleries);

			for (var i:int = 0; i < this._galleryLength; i++)
			{
				currGallery = this._galleries[i];
				currGallerySelectedItems = currGallery.selectedItems;
				//shuffleList(currGallerySelectedItems);

				if (currGallerySelectedItems.length > 0)
				{
					for (var j:int = 0; j < currGallerySelectedItems.length; j++)
					{
						this._selectedItemsCount++;
						selectedItem = currGallerySelectedItems[j];
						if (isFirstItem)
						{
							this._sqDataToWrite += "SELECT " + this._selectedItemsCount + " AS 'photoid', '" + selectedItem + "' AS 'url' ";
							isFirstItem = false;
						}
						else
						{
							this._sqDataToWrite += "UNION SELECT " + this._selectedItemsCount + ", '" + selectedItem + "' ";
						}
					}
				}
			}
		}

		private function shuffleList(list:Object):void
		{
			var listLength:int = list.length;
			if (listLength > 1)
			{
				var i:int = listLength - 1;
				while (i > 0)
				{
					var s:Number = Math.floor(Math.random()*(listLength));
					var temp:* = list[s];
					list[s] = list[i];
					list[i] = temp;
					i--;
				}
			}
		}

		private function getSqDataFromCustomImage():void
		{
			this._photoContainer.saveTempImageAsMain();
			var main:File = File.applicationStorageDirectory.resolvePath(this._photoContainer.fileName);

			if (main.exists)
			{
				if (this._sqDataToWrite.length > 0)
				{
					this._sqDataToWrite += "UNION SELECT " + (this._selectedItemsCount + 1) + ", '" + main.url + "'";
				}
				else
				{
					this._sqDataToWrite += "SELECT " + (this._selectedItemsCount + 1) + " AS 'photoid', '" + main.url +	"' AS 'url' ";
				}
			}
		}

		private function tableDataDeleted(e:SQLEvent):void
		{
			this._sqStatement.removeEventListener(SQLEvent.RESULT, tableDataDeleted);
			trace("image data deleted");
			writeImageData();
		}

		private function writeImageData():void
		{
			this._sqStatement = new SQLStatement();
			this._sqStatement.text = "INSERT INTO homepage_photos " + this._sqDataToWrite;
			trace(this._sqStatement.text);
			this._sqStatement.sqlConnection = this._sqConn;
			this._sqStatement.addEventListener(SQLEvent.RESULT, tableDataWritten);
			this._sqStatement.execute();
		}

		private function tableDataWritten(e:SQLEvent):void
		{
			this._sqStatement.removeEventListener(SQLEvent.RESULT, tableDataWritten);

			writeDateStamp();
		}

		private function writeDateStamp():void
		{
			var today:Date = new Date();
			var sqDate:String = MedicationNameModifier.getSQLStringFromDate(today);

			this._sqStatement = new SQLStatement();
			this._sqStatement.text = "UPDATE app_settings SET gallery_submission_timestamp='" + sqDate + "'";
			trace(this._sqStatement.text);
			this._sqStatement.sqlConnection = this._sqConn;
			this._sqStatement.addEventListener(SQLEvent.RESULT, sqlResultHandler);
			this._sqStatement.execute();
		}

		private function sqlResultHandler(e:SQLEvent):void
		{
			trace("sqlResultHandler " + e);
		}

		private function oldDataCheck():void
		{
			var dbFile:File = File.applicationStorageDirectory;
			dbFile = dbFile.resolvePath("settings.sqlite");

			this._sqConn = new SQLConnection();
			this._sqConn.open(dbFile);

			this._sqStatement = new SQLStatement();
			this._sqStatement.addEventListener(SQLEvent.RESULT, getDate);
			this._sqStatement.text = "SELECT gallery_submission_timestamp FROM app_settings";
			this._sqStatement.sqlConnection = this._sqConn;
			this._sqStatement.execute();
		}

		private function getDate(e:SQLEvent):void
		{
			this._sqStatement.removeEventListener(SQLEvent.RESULT, getDate);
			this._resultData = this._sqStatement.getResult().data;

			try
			{
				this._dataPreExists = this._resultData[0].gallery_submission_timestamp != null;
				trace("gallery_submission_timestamp = " + this._resultData[0].gallery_submission_timestamp);
			}
			catch(e:Error)
			{
				trace("date stamp not there");
				this._dataPreExists = false;
			}

			if(this._dataPreExists)
			{
				populateOldData();
			}
			else
			{

			}
		}

		private function populateOldData():void
		{
			// TODO: populate pre-existing data
		}

		private function initGallery():void
		{
			var currGalleryContainer:Gallery;

			this._galleryPadding = 15 * this.dpiScale;

			const horizontalLayout:HorizontalLayout = new HorizontalLayout();
			horizontalLayout.gap = this._galleryPadding;
			horizontalLayout.padding = 0;
			horizontalLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_LEFT;
			horizontalLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;

			this._galleryCount = 0;
			this._galleryLength = GALLERY_CATEGORIES.length;
			for (var i:int = 0; i < this._galleryLength; i++)
			{
				currGalleryContainer = new Gallery();
				currGalleryContainer.category = GALLERY_CATEGORIES[i];
				currGalleryContainer.layout = horizontalLayout;
				currGalleryContainer.addEventListener(Event.COMPLETE, galleryReady);
				currGalleryContainer.getImageList();
				this._galleries.push(currGalleryContainer);
			}
		}

		private function galleryReady(e:Event):void
		{
			var currGalleryContainer:Gallery = e.target as Gallery;
			currGalleryContainer.removeEventListener(Event.COMPLETE, galleryReady);

			this._galleryCount++;

			if(this._galleryCount == this._galleryLength)
			{
				removeChild(this._loadText,true);

				initGalleriesContainer();
				this._galleries.forEach(drawGalleries);
			}
		}

		private function initGalleriesContainer():void
		{
			var scaledPadding:Number = PADDING * this.dpiScale;
			var startYPosition:Number = this._header.y + this._header.height;

			this._galleriesContainer = new ScrollContainer();
			addChild(this._galleriesContainer);

			this._galleriesContainer.x = scaledPadding;
			this._galleriesContainer.y = startYPosition;
			this._galleriesContainer.width = this.actualWidth - (scaledPadding * 2);
			this._galleriesContainer.height = this._photoContainer.y - startYPosition - scaledPadding;
		}

		private function drawGalleries(item:Gallery, index:int, vector:Vector.<Gallery>):void
		{
			var galleryHeight:Number = 125 * this.dpiScale;

			this._galleriesContainer.addChild(item);
			item.height = galleryHeight;
			item.width = this._galleriesContainer.width;
			item.y = (galleryHeight + this._galleryPadding) * index;
			item.drawGallery();
		}
/*
		private function onOpenGallery(e:Event):void
		{
			const button:Button = Button(e.currentTarget);
			var category:String;
			//trace(button.label + " triggered.");
			switch(button.label)
			{
				case "Sport" :
					//var sportsScreen:SportsGalleryScreen = new SportsGalleryScreen();
					//addChild(sportsScreen);
					category = "sport";
					break;
				case "Music" :
					break;
				case "Cinema" :
					break;
				case "History" :
					break;
				case "Traveling" :
					break;
				case "Art" :
					break;
			}
			if(this.owner.hasScreen("gallery")) this.owner.removeScreen("gallery");
			this.owner.addScreen("gallery", new ScreenNavigatorItem(SportsGalleryScreen, null, {category:category}));
			this.owner.showScreen("gallery");
		}*/
	}
}

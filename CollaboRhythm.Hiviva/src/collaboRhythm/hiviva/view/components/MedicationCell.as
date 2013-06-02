package collaboRhythm.hiviva.view.components
{
	import collaboRhythm.hiviva.global.HivivaAssets;
	import collaboRhythm.hiviva.view.media.Assets;

	import feathers.controls.Label;

	import feathers.core.FeathersControl;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;

	import flash.geom.Rectangle;

	import starling.display.Image;

	import starling.display.Quad;

	public class MedicationCell extends FeathersControl
	{
		private const IMAGE_SIZE:Number = 100;

		protected var _gap:Number;

		protected var _bg:Scale9Image;
		protected var _seperator:Image;
		protected var _scale:Number;
		protected var _pillImageBg:Quad;

		protected var _brandNameLabel:Label;
		protected var _brandName:String;

		protected var _genericNameLabel:Label;
		protected var _genericName:String;


		public function MedicationCell()
		{
			super();
		}

		override protected function draw():void
		{
			this._gap = 15 * this._scale;

			super.draw();

			this._seperator.width = this.actualWidth;

			this._brandNameLabel.validate();
			this._genericNameLabel.validate();
			//trace("this._genericNameLabel " + this._genericNameLabel.height);

			this._pillImageBg.x = this._gap;
			this._pillImageBg.y = this._gap;

			this._brandNameLabel.x = this._pillImageBg.x + this._pillImageBg.width + this._gap;
			this._brandNameLabel.y = this._pillImageBg.y;
			this._brandNameLabel.width = this.actualWidth - this._pillImageBg.x;

			this._genericNameLabel.x = this._pillImageBg.x + this._pillImageBg.width + this._gap;
			this._genericNameLabel.y = this._brandNameLabel.y + this._brandNameLabel.height;
			this._genericNameLabel.width = this.actualWidth - this._pillImageBg.x;


			setSizeInternal(this.actualWidth, this._pillImageBg.height + (this._gap * 2), true);
		}

		override protected function initialize():void
		{
			this._seperator = new Image(Assets.getTexture(HivivaAssets.HEADER_LINE));
			addChild(this._seperator);

			this._pillImageBg = new Quad(IMAGE_SIZE * this._scale, IMAGE_SIZE * this._scale, 0x000000);
			addChild(this._pillImageBg);

			this._brandNameLabel = new Label();
			this._brandNameLabel.text = "<font face='ExoBold'>" + this._brandName + "</font>";
			this.addChild(this._brandNameLabel);

			this._genericNameLabel = new Label();
			this._genericNameLabel.text = this.genericName;
			this.addChild(this._genericNameLabel);

		}

		public function set brandName(value:String):void
		{
			this._brandName = value;
		}

		public function get brandName():String
		{
			return this._brandName;
		}

		public function set genericName(value:String):void
		{
			this._genericName = value;
		}

		public function get genericName():String
		{
			return this._genericName;
		}


		public function set scale(value:Number):void
		{
			this._scale = value;
		}

		public function get scale():Number
		{
			return this._scale;
		}
	}
}

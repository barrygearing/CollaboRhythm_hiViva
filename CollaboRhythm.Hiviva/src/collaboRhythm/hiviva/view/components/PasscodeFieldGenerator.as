package collaboRhythm.hiviva.view.components
{
	import collaboRhythm.hiviva.global.Constants;

	import feathers.controls.TextInput;
	import feathers.core.FeathersControl;

	public class PasscodeFieldGenerator extends FeathersControl
	{

		private var _passcodeInput1:TextInput;
		private var _passcodeInput2:TextInput;
		private var _passcodeInput3:TextInput;
		private var _passcodeInput4:TextInput;

		public function PasscodeFieldGenerator()
		{

		}

		override protected function initialize():void
		{
			super.initialize();
		}

		override protected function draw():void
		{
			super.draw();
			initInputFields();
		}

		private function initInputFields():void
		{
			this._passcodeInput1 = new TextInput();
			this.addChild(this._passcodeInput1);
			this._passcodeInput1.validate();
			this._passcodeInput1.width = Constants.PASSCODE_INPUT;
			this._passcodeInput1.x = 78;

			this._passcodeInput2 = new TextInput();
			this.addChild(this._passcodeInput2);
			this._passcodeInput2.validate();
			this._passcodeInput2.width = Constants.PASSCODE_INPUT;
			this._passcodeInput2.x = 206;

			this._passcodeInput3 = new TextInput();
			this.addChild(this._passcodeInput3);
			this._passcodeInput3.validate();
			this._passcodeInput3.width = Constants.PASSCODE_INPUT;
			this._passcodeInput3.x = 334;

			this._passcodeInput4 = new TextInput();
			this.addChild(this._passcodeInput4);
			this._passcodeInput4.validate();
			this._passcodeInput4.width = Constants.PASSCODE_INPUT;
			this._passcodeInput4.x = 462;
		}
	}
}

package gui
{

	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;

import gui.ButtonDisplayState;

public class CustomSimpleButton extends SimpleButton {
		private var upColor:uint   = 0xFF4500;
		private var overColor:uint = 0xFFA500;
		private var downColor:uint = 0xFF0000;
		private var size:uint      = 20;

		public function CustomSimpleButton(){
			downState      = new ButtonDisplayState(downColor, size);
			overState      = new ButtonDisplayState(overColor, size);
			upState        = new ButtonDisplayState(upColor, size);
			hitTestState   = new ButtonDisplayState(upColor, size * 2);
			hitTestState.x = -(size / 4);
			hitTestState.y = hitTestState.x;
			useHandCursor  = true;
		}
	}

}
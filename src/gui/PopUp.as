package gui
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Plazer
	 */
	public class PopUp extends MovieClip 
	{
		
		public function PopUp() {
            Listing.getInstance().listTrace("PopUp| PopUp");

			textField_create();
			btnClose_create();
			this.x = STAGE_WIDTH / 2 - this.width / 2;
			this.y = STAGE_HEIGHT / 2 - this.height / 2;
			//_textField.appendText("Application initialized\n");
		}

		private function textField_create():void {
			_textField = new TextField();
			_textField.x = _txtX;
			_textField.y = _txtY;
			_textField.width = _txtWidth;
			_textField.height = _txtHeight;
			_textField.border = true;
			_textField.borderColor = _txtBorderColor;
			_textField.background = true;
			_textField.backgroundColor = _txtBackgroundColor;
			_textField.embedFonts = false;
			
			var format:TextFormat = new TextFormat();
			format.font = "Tahoma";
			format.color = 0x000000;
			format.size = 12;
			
			_textField.defaultTextFormat = format;
			addChild(_textField);
		}

		private function btnClose_create():void {
			
			_btnClose = new CustomSimpleButton();

            _btnClose.x = this.width - _btnClose.width;
            _btnClose.y = 0;
			
            addChild(_btnClose);
            _btnClose.addEventListener(MouseEvent.CLICK, close);
		}
		
		private function close(e:Event):void 
		{
			//this.enabled = false;
			//this.visible = false;
			this.parent.removeChild(this);
		}
		
		public function writeText(data:String):void {
			_textField.appendText(data);	
		}
		
		private var _textField:TextField;
		private var _btnClose:CustomSimpleButton;
		
		private var _txtWidth:int = STAGE_WIDTH*0.9;
		private var _txtHeight:int = STAGE_HEIGHT*0.5;
		private var _txtX:int = 0;
		private var _txtY:int = 0;
		
		private const STAGE_WIDTH:int = 700;
		private const STAGE_HEIGHT:int = 600;
		
		private var _txtBorderColor:int = 0xDAE2E8;
		private var _txtBackgroundColor:int = 0xF1F1F1;
	
	}
}
package userList
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.display.Graphics;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Plazer
	 */
	public class Slot extends Sprite 
	{
		public function Slot(name:String = "Name", imgPath:String = "http://vk.com/images/camera_c.gif", number:String = "9", userType:uint = 0 ) {

			bg_create(userType);
			
			txtNumber_create();
			_txtNumber.appendText(number);

			txtName_create();
			_txtName.appendText(name);
			
			loadImg(imgPath);
		}
		
		private function txtName_create():void {
			_txtName = new TextField();
			_txtName.x = 0;
			_txtName.y = 80;
			_txtName.width = SLOT_WIDTH;
			_txtName.height = 20;
			_txtName.autoSize=TextFieldAutoSize.CENTER;

			_txtName.background = false;
			
			var format:TextFormat = new TextFormat();
			format.font = "Tahoma";
			format.color = 0x000000;
			format.size = 12;
			
			_txtName.defaultTextFormat = format;
			addChild(_txtName);
		}
		
		private function txtNumber_create():void {
			_txtNumber = new TextField();
			_txtNumber.x = 0;
			_txtNumber.y = 0;
			_txtNumber.width = SLOT_WIDTH;
			_txtNumber.height = 20;

			_txtNumber.background = false;
			_txtNumber.autoSize=TextFieldAutoSize.CENTER;
			
			var format:TextFormat = new TextFormat();
			format.font = "Tahoma";
			format.color = 0x000000;
			
			format.size = 12;
			
			_txtNumber.defaultTextFormat = format;
			addChild(_txtNumber);
		}
		private function bg_create(userType:uint):void {
			_bg = new Sprite  ;
			
			switch (userType) { 
			case 1 : 
				_bg.graphics.beginFill(_bgColorPlayer, 1);
				break;
			case 2 : 
				_bg.graphics.beginFill(_bgColorIngame, 1);
				break;
			case 3 : 
				_bg.graphics.beginFill(_bgColorForeigner, 1);
				break; 
			}
			
			_bg.graphics.lineStyle();
			_bg.graphics.drawRect(0, 0, SLOT_WIDTH, SLOT_HEIGHT);
			_bg.x=0;
			_bg.y=0;
			//_bg.alpha=0;
			addChild(_bg);
		}
		
		private function avatar_create(img:Bitmap):void {
			_avatar = img;
			this.addChild(_avatar);
			_avatar.y = 20;
			_avatar.x = 30 - _avatar.width / 2;
		}
		
		private function loadImg(image_path:String):void {
            var context:LoaderContext = new LoaderContext();
            context.checkPolicyFile = true;

			var image_loader:Loader=new Loader  ;
			image_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,image_loader_Complete);

			image_loader.load(new URLRequest(image_path), context);
		}
		
		private function image_loader_Complete(e:Event):void 
		{
			avatar_create(Bitmap(e.target.content));
		}
		
		private var _txtNumber:TextField;
		private var _avatar:Bitmap;
		private var _txtName:TextField;
		private var _bg:Sprite;

		private var _bgColorPlayer:int = 0xFFD700;
		private var _bgColorIngame:int = 0x9ACD32;
		private var _bgColorForeigner:int = 0xFAFAD2;
		
		public const SLOT_WIDTH:int = 60;
		public const SLOT_HEIGHT:int = 100;
		
	}
}
package 
{
import flash.display.Bitmap;
import flash.display.DisplayObject;
	import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.getDefinitionByName;

import gui.Listing;

/**
	 * ...
	 * @author Plazer
	 */
	public class Preloader extends MovieClip 
	{

    [Embed(source = "../lib/preloader_bg.jpg")]
    private var bgImgClass:Class;
    private var bgImg:Bitmap = new bgImgClass();

		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO show loader
            _container = new Sprite();
            addChild(_container);

            Listing.getInstance().listTrace("Show loader...");
            bgImg.width = STAGE_WIDTH;
            bgImg.height = STAGE_HEIGHT;
            _container.addChild(bgImg);

            textField_create();
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
            Listing.getInstance().listTrace(e.text);
		}
		
		private function progress(theProgress:ProgressEvent):void
		{
			// TODO update loader
            Listing.getInstance().listTrace("Progress...");
            var percent:Number = Math.round((theProgress.bytesLoaded / theProgress.bytesTotal )*100 );
//            bgImg.width = STAGE_WIDTH*percent/100;
            Listing.getInstance().listTrace(percent+"% ready");
            _textField.text = String(percent)+"%";
//            var percent:Number = Math.round((theProgress.bytesLoaded / theProgress.bytesTotal )*100 );
//            trace(percent + " %");
//            this.graphics.clear()
//            this.graphics.lineStyle(1, 0x000000, 1)
//            this.graphics.beginFill(0x000000)
//            this.graphics.drawRect(100,100,percent,10)
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);

			// TODO hide loader
            Listing.getInstance().listTrace("Hide loader...");
            this.removeChild(_container);

            Listing.getInstance().listTrace("Start Main ");
            startup();
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}

        private function textField_create():void {
            _textField = new TextField();
            _textField.x = _txtX;
            _textField.y = _txtY;
            _textField.width = _txtWidth;
            _textField.height = _txtHeight;
            _textField.border = true;
            _textField.borderColor = _txtBorderColor;
            _textField.embedFonts = false;

            var format:TextFormat = new TextFormat();
            format.font = "Tahoma";
            format.color = 0x8B0000;
            format.size = 18;
            format.align = "center";

            _textField.defaultTextFormat = format;
            _container.addChild(_textField);

        }

    private var _textField:TextField;
    private var _container:Sprite;

    private var _txtWidth:int = 60;
    private var _txtHeight:int = 24;
    private var _txtX:int = STAGE_WIDTH*0.5;
    private var _txtY:int = STAGE_HEIGHT*0.5;

    private const STAGE_WIDTH:int = 700;
    private const STAGE_HEIGHT:int = 600;
    private var _txtBorderColor:int = 0xDAE2E8;
    private var _txtBackgroundColor:int = 0xF1F1F1;

	}
	
}
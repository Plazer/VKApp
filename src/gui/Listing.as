
package gui {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;

/**
 * ...
 * @author Plazer
 */
public class Listing extends MovieClip {
    public function Listing() {

        if (!_allowInstantiation) {
            throw new Error("Error: Instantiation failed: Use Listing.getInstance() instead of new.");
        }

    }

    public static function getInstance():Listing {
        if (_instance == null) {
            _allowInstantiation = true;
            _instance = new Listing();

            trace("Listing start...");
            _instance.prepare_bg();
            _instance.textField_create();
            _instance.hide();

            _allowInstantiation = false;
        }
        return _instance;
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
        format.color = 0xADFF2F;
        format.size = 12;

        _textField.defaultTextFormat = format;
        addChild(_textField);

    }

    private function prepare_bg():void{
        _bg = new Sprite();
        _bg.alpha = 0.9;
        _bg.graphics.beginFill(0x272727);
        _bg.graphics.drawRect(0, 0, STAGE_WIDTH, STAGE_HEIGHT);
        _bg.graphics.endFill();

        this.addChild(_bg);
     }

    public function show():void{
        this.parent.setChildIndex(this, parent.numChildren-1);

        _switcher_on = true;
        this.enabled = true;
        this.visible = true;
    }

    public function hide():void{
        _switcher_on = false;
        this.enabled = false;
        this.visible = false;
    }

    public function switchListing():void{

        if(_switcher_on){
            hide();
        }else{
            show();
        }
    }

    public function listTrace(data:String):void {
        trace(data);
        _textField.appendText(data + "\n");
    }

    private static var _instance:Listing;
    private static var _allowInstantiation:Boolean;

    private var _bg:Sprite;

    private var _textField:TextField;

    private var _txtWidth:int = STAGE_WIDTH*0.8;
    private var _txtHeight:int = STAGE_HEIGHT*0.8;
    private var _txtX:int = STAGE_WIDTH*0.1;
    private var _txtY:int = STAGE_HEIGHT*0.1;

    private const STAGE_WIDTH:int = 700;
    private const STAGE_HEIGHT:int = 600;

    private var _txtBorderColor:int = 0xDAE2E8;
    private var _txtBackgroundColor:int = 0xF1F1F1;

    private var _switcher_on:Boolean = false;

}
}

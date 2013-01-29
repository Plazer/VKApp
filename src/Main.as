package{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.media.Sound;

    import gui.Listing;

    import gui.PopUp;
    import userList.Slot;
    import userList.UsersList;
    import utils.ParserXML;
    import utils.VKUtil;
    import vk.ui.VKButton;


	/**
	 * ...
	 * @author Plazer
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
        [Embed(source = "../sounds/vivaldi.mp3")]
        private var MySound : Class;
        private var sound : Sound;

        public function Main():void
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
            startListing();
            trace("Here first entering.");
//            sound = (new MySound) as Sound;
//            sound.play();
            var flashVars:Object = stage.loaderInfo.parameters as Object;
            _vkControl = new VKControl(flashVars);
            this.addChild(_vkControl);
		}

        private function  startListing():void{
            _listing = Listing.getInstance();
            this.addChild(_listing);
            stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
         }

        private function onKeyUp(e:KeyboardEvent):void {
//            var keyCode:Number=e.charCode;
            switch (e.charCode) {
                case (96) : // `
                    _listing.switchListing();

                    break;

                default :
                    trace(e.charCode);
            }
        }

        private var _listing:Listing;
        private var _vkControl:VKControl;

    }
}
package 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import vk.APIConnection;


	/**
	 * ...
	 * @author Plazer
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			trace("Here first entering.");
			prepeareVKUtils();
			
			_vkUtil.getUserInfo(_flashVars['viewer_id'], userInfo);
		}
		
		private function prepeareVKUtils():void {
			_vkUtil = new VKUtil;
			_flashVars = stage.loaderInfo.parameters as Object;
			
			if (_flashVars.api_id) {
				trace("Run from VK, Ok");
			}else {
				trace("Possible local testing, or some problems");
			// -- For local testing:

			// -- //
			}

			//vkUtil.getUserInfo(flashVars['viewer_id'], userInfo, flashVars);
			//vkUtil.VK = new APIConnection(flashVars);
			_vkUtil.setApiConnection(_flashVars);
		}
		
		private function userInfo(data: Object):void {
			trace("Here result" + data + "\n");
			for (var key: String in data[0]) {
				trace(key + "=" + data[0][key] + "\n");
			}
		}
		
		private function loadImg(imgUrl:String):void {
			
			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;
			
			var urlRequest:URLRequest=new URLRequest(imgUrl);
			_loader=new Loader;
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadingCompleteListener);
			_loader.load(urlRequest, context);
		
		}
	
		private function loadingCompleteListener(e:Event):void 
		{
			try {
				trace("User's photo: e.currentTarget.content = "+e.currentTarget.content+"\n");
			}
			catch(error:Error){
				trace("User's photo: Error: "+error.message+"\n");//TODO fix noImg avatar
			}
			var loadedImg:Bitmap =  Bitmap(e.currentTarget.content);
	/*		loadedImg.x = this.width - loadedImg.width;
			loadedImg.y = curPhotoY;
			curPhotoY += loadedImg.height + 2;
			addChild(loadedImg);*/
			
		}
		
		private var _vkUtil:VKUtil;
		//private var VK: APIConnection;
		private var _loader:Loader;
		private var _flashVars: Object;
	}

}
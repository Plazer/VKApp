package utils
{
	import flash.display.Sprite;
	import flash.events.Event;

    import gui.Listing;

    import vk.APIConnection;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	//import vk.events.*;
	
	/**
	 * ...
	 * @author Plazer
	 */
	public class VKUtil extends Sprite
	{
		
		public function VKUtil():void {
		
		}
		
		public function getUser(id:uint, resultHandler:Function):void {
			_VK.api('users.get', { uids: id, fields: "photo"}, resultHandler, onRequestFail);
		}
		
		public function getUserFriends(id:uint, resultHandler:Function):void {
			_VK.api('friends.get', { uids: id, fields: "photo"}, resultHandler, onRequestFail);
			//_VK.api('friends.get', { uids: id, fields: "photo,education"}, resultHandler, onRequestFail);
		}
		
		private function onRequestFail(data: Object): void {
            Listing.getInstance().listTrace("Request Failed");
            Listing.getInstance().listTrace("data - "+data);
		}
		
		public function clean_DB():void {
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest("http://truelancer.com/vkontakte/index.php/main/delete");
			request.method = URLRequestMethod.POST;
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, clean_DBHandler);
		}
		
		public function getUserParam(uid:uint, param:String, resultHandler:Function):void {
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest("http://truelancer.com/vkontakte/index.php/main/get_user_param");

			request.method = URLRequestMethod.POST;
			var variable:URLVariables = new URLVariables();
		 
			variable['uid'] = uid;
			variable['param'] = param;
			 
			request.data = variable;
			
			request.method = URLRequestMethod.POST;
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, resultHandler);
		}
	
		public function getUser_DB(resultHandler:Function):void {
            Listing.getInstance().listTrace("VKUtil | getUser_DB()");

//            try
//            {
                var loader:URLLoader = new URLLoader();
                var request:URLRequest = new URLRequest("http://truelancer.com/vkontakte/index.php/main/get_users");
                request.method = URLRequestMethod.POST;
                loader.load(request);
                loader.addEventListener(Event.COMPLETE, resultHandler);
//            }
//            catch (err:Error)
//            {
//                Listing.getInstance().listTrace("VKUtil | getUser_DB() err="+err.message);
//            }

		}
		
		public function getUserByUid_DB(id:uint, resultHandler:Function):void {
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest("http://truelancer.com/vkontakte/index.php/main/get_user_by_uid");
			request.method = URLRequestMethod.POST;
			var variable:URLVariables = new URLVariables();
		 
			variable['uid'] = id;
			 
			request.data = variable;
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, resultHandler);
		}
		
		public function saveUserToDb(params:Object, resultHandler:Function):void {
            Listing.getInstance().listTrace("Save to bd");
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest("http://truelancer.com/vkontakte/index.php/main/add_user");
			//http://truelancer.com/vkontakte/index.php/main/add_user/fff/sss
			request.method = URLRequestMethod.POST;
			var variable:URLVariables = new URLVariables();
		 
			variable['uid'] = params["uid"];
			variable['first_name'] = params["first_name"];
			variable['last_name'] = params["last_name"];
			variable['photo'] = params["photo"];
			 
			request.data = variable;
			 
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, resultHandler);
		}
		private function clean_DBHandler(e:Event):void 
		{
			Listing.getInstance().listTrace("dropDB ");
            Listing.getInstance().listTrace("fromDB: " + e.target.data);
		}
	
		private function fromDB(e:Event):void 
		{
            Listing.getInstance().listTrace("fromDB");
            Listing.getInstance().listTrace("fromDB: " + e.target.data);
		}

        public function showOrderBox(item:String = ""):void {
            _VK.callMethod("showOrderBox", {
                type: 'item',
                item: item
            });
        }

		public function setApiConnection(flashVars:Object):void 
		{
			_VK = new APIConnection(flashVars);
		}
		
		public function set VK(value:APIConnection):void 
		{
			_VK = value;
		}
		
		private var _outerHandler:Function;
		private var _VK: APIConnection;

	}
}
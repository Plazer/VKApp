package 
{
	import vk.APIConnection;
	//import vk.events.*;
	
	/**
	 * ...
	 * @author Plazer
	 */
	public class VKUtil 
	{
		
		public function VKUtil():void {
		
		}
		
		//public function getUserInfo(id:uint, resultHandler:Function, flashVars: Object):void {
		public function getUserInfo(id:uint, resultHandler:Function):void {
			_outerHandler = resultHandler;
			//VK = new APIConnection(flashVars);
			_VK.api('users.get', { uids: id, fields: "photo"}, userInfoHandler, onRequestFail);
		}
		
		private function userInfoHandler(data: Object): void {
			trace("___apiUsersHandler___");
			trace("data = "+data);
			_outerHandler(data);//return result
		}
	
		private function onRequestFail(data: Object): void {
			// Example of fetching fail from API request
			trace("Request Failed");
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
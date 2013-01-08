package 
{
	
	/**
	 * ...
	 * @author Plazer
	 */
	public class User 
	{
		public function User(uid:uint, first_name:String="", last_name:String="", photo:String="", userType:uint = 0, rnd:int = 1) {
			_uid = uid;
			_first_name = first_name;
			_last_name = last_name;
			_photo = photo;
			_userType = userType;
			_rnd = rnd;
		}
		
		public function get uid():uint 
		{
			return _uid;
		}
		
		public function set uid(value:uint):void 
		{
			_uid = value;
		}
		
		public function get first_name():String 
		{
			return _first_name;
		}
		
		public function set first_name(value:String):void 
		{
			_first_name = value;
		}
		
		public function get last_name():String 
		{
			return _last_name;
		}
		
		public function set last_name(value:String):void 
		{
			_last_name = value;
		}
		
		public function get photo():String 
		{
			return _photo;
		}
		
		public function set photo(value:String):void 
		{
			_photo = value;
		}
		
		public function get userType():uint 
		{
			return _userType;
		}
		
		public function set userType(value:uint):void 
		{
			_userType = value;
		}
		
		public function get rnd():int 
		{
			return _rnd;
		}
		
		public function set rnd(value:int):void 
		{
			_rnd = value;
		}
		
		private var _uid:uint;
		private var _first_name:String;
		private var _last_name:String;
		private var _photo:String;
		private var _userType:uint;
		private var _rnd:int;
		
		public const USER_PLAYER:uint = 1;
		public const USER_INGAME:uint = 2;		//installed app
		public const USER_FOREIGNER:uint = 3;	//not installed app
		
		
		
	
	}
	
}
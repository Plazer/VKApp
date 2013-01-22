package utils
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;

import gui.Listing;

/**
	 * ...
	 * @author Plazer
	 */
	public class ParserXML 
	{
	
		public function ParserXML() {
			
		}
		public function parse_users_get(xml:XML):Object {

			var result:Object = new Object; 
			//if (xml.error==null){
				result.uid = uint(xml.user.uid);
				result.first_name = String(xml.user.first_name);
				result.last_name = String(xml.user.last_name);			
			//}else {
			if(xml.error!="")
                Listing.getInstance().listTrace("parse_users_get   xml.error = " + xml.error);
			//}
			return result;
		}
		
		public function parse_user_get(xml:XML):Object {

			var result:Object = new Object;
			
				result.uid = uint(xml.user.uid);
				result.first_name = String(xml.user.first_name);
				result.last_name = String(xml.user.last_name);
				result.photo = String(xml.user.photo);
				result.rnd = uint(xml.user.rnd);

			if(xml.error!="")
                Listing.getInstance().listTrace("parse_user_get   xml.error = " + xml.error);
			
			return result;
		}

        public function parse_saveUserToDb_resp(xml:XML):Object {

            var result:Object = new Object;

            result.uid = uint(xml.user.uid);

            if(xml.error!="")
                Listing.getInstance().listTrace("parse_user_get   xml.error = " + xml.error);

            return result;
        }

		public function parse_user_param(xml:XML):Object {
			//trace ("parse_user_param -  "+xml);
			var result:Object = new Object; 
			//if (xml.error==null){
				result.uid = uint(xml.user.uid);
				result.param = String(xml.user.param);
				result.value = String(xml.user.value);			
			//}else {
			if(xml.error!="")//not 
                Listing.getInstance().listTrace("parse_user_param   xml.error = " + xml.error);
			//}
			return result;	
		}
		
		public function parse_friends_get(xml:XML):Object {
			
			var users:Object = new Object;
			var index:uint = 0;
			
			//if (xml.error==null){
				for each(var property:XML in xml.user) {
					var result:Object = new Object;
					result.uid = uint(property.uid);
					result.first_name = String(property.first_name);
					result.last_name = String(property.last_name);
					users[index] = result;
					index++;
				}		
			//}else {
			if(xml.error!="")
                Listing.getInstance().listTrace("parse_friends_get  xml.error = " + xml.error);
			//}
			return users;
		}
	}
}
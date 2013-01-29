package{
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

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
    public class VKControl extends Sprite{

        public function VKControl(flashVars:Object) {
            prepareVKUtils(flashVars);
            prepareParser();
            prepareLists();

            createButtons();
//			_vkUtil.clean_DB(); //be careful
            checkPlayerInDb();

        }

    ////// prerare block //////
    private function prepareVKUtils(flashVars:Object):void {
        _vkUtil = new VKUtil;
        this.addChild(_vkUtil);
//        _flashVars = stage.loaderInfo.parameters as Object;
        _flashVars = flashVars;

        if (_flashVars.api_id) {
            Listing.getInstance().listTrace("Run from VK, Ok");
            Listing.getInstance().listTrace("api_id = "+_flashVars.api_id);
            Listing.getInstance().listTrace("viewer_id = "+_flashVars.viewer_id);
            Listing.getInstance().listTrace("sid = "+_flashVars.sid);
            Listing.getInstance().listTrace("secret = "+_flashVars.secret);
        }else{
            Listing.getInstance().listTrace("Possible local testing, or some problems");
            try
            {
                // -- For local testing:
                var localFV:LocalFlashVars = new LocalFlashVars;
                _flashVars['api_id'] = localFV.api_id ;
                _flashVars['viewer_id'] = localFV.viewer_id;
                _flashVars['sid'] = localFV.sid;
                _flashVars['secret'] = localFV.secret;
                // -- //
            }
            catch (err:Error)
            {
                Listing.getInstance().listTrace("No local testing))");
            }
        }

        _vkUtil.setApiConnection(_flashVars);
    }

    private function prepareParser():void
    {
        _parser = new ParserXML;
    }

    private function prepareLists():void
    {
        _userList = new Vector.<User>;
        _slotList = new Vector.<Slot>;

        //addPlayerToUserList();
    }
    ////// prerare block END //////

    private function createButtons():void {
        var btnGetUserInfo: VKButton = new VKButton('Get user info');
        btnGetUserInfo.x = 2;
        btnGetUserInfo.y = 2;
        addChild(btnGetUserInfo);

        btnGetUserInfo.addEventListener(MouseEvent.CLICK, getUser);  // getUser -> getUserHandler

        var btnSaveUserInfo: VKButton = new VKButton('Save user to db');
        btnSaveUserInfo.x = btnGetUserInfo.x + btnGetUserInfo.width+2;
        btnSaveUserInfo.y = 2;
        addChild(btnSaveUserInfo);

        btnSaveUserInfo.addEventListener(MouseEvent.CLICK, saveUser);  //saveUser -> saveUserHandler -> saveUserToDbHandler

/*        var btnGetUserInfoDb: VKButton = new VKButton('Get user info db');
        btnGetUserInfoDb.x = btnSaveUserInfo.x + btnSaveUserInfo.width+2;
        btnGetUserInfoDb.y = 2;
        addChild(btnGetUserInfoDb);

        btnGetUserInfoDb.addEventListener(MouseEvent.CLICK, getUserDb); // getUserDb -> getUsersDBHandler -> viewResult*/

        var btnGetUserParamDb: VKButton = new VKButton('Get user param db');
//        btnGetUserParamDb.x = btnGetUserInfoDb.x + btnGetUserInfoDb.width+2;
        btnGetUserParamDb.x = btnSaveUserInfo.x + btnSaveUserInfo.width+2;

        btnGetUserParamDb.y = 2;
        addChild(btnGetUserParamDb);

        btnGetUserParamDb.addEventListener(MouseEvent.CLICK, getUserParam); //getUserParam -> getUserParamHandler -> viewResult

        var btnGetUserFriends: VKButton = new VKButton('Get user friends');
        btnGetUserFriends.x = btnGetUserParamDb.x + btnGetUserParamDb.width+2;
        btnGetUserFriends.y = 2;
        addChild(btnGetUserFriends);

        btnGetUserFriends.addEventListener(MouseEvent.CLICK, getUserFriends); //dobisa

        var btnBuyTime: VKButton = new VKButton('Buy Time!');
        btnBuyTime.x = 2;
        btnBuyTime.y = 4+btnGetUserFriends.height;
        addChild(btnBuyTime);

        btnBuyTime.addEventListener(MouseEvent.CLICK, buyTime);
    }

    ////// getUser block //////
    private function getUser(e:MouseEvent):void
    {
        _vkUtil.getUser(_flashVars['viewer_id'], getUserHandler);
    }

    private function getUserHandler(data: Object):void {
        Listing.getInstance().listTrace("Here userInfo: " + data + "\n");

        var _userInfoPopUp:PopUp = new PopUp;
        this.addChild(_userInfoPopUp);
        for (var key: String in data[0]) {
            _userInfoPopUp.writeText(key + "=" + data[0][key] + "\n");
        }
    }
    ////// getUser block END //////

    ////// saveUser block //////
    private function saveUser(e:MouseEvent):void
    {
        _vkUtil.getUser(_flashVars['viewer_id'], saveUserHandler);
    }

    private function saveUserHandler(data: Object):void {
        Listing.getInstance().listTrace("Save user info \n");
        _vkUtil.saveUserToDb(Object(data[0]), saveUserToDbHandler);
    }

    private function saveUserToDbHandler(e:Event):void
    {
        var _resultPopUp:PopUp = new PopUp;
        this.addChild(_resultPopUp);
        _resultPopUp.writeText(e.target.data);
    }
    ////// saveUser block END //////

    ////// getUserDb block //////
    private function getUserDb(e:MouseEvent):void
    {
        Listing.getInstance().listTrace("Main | getUserDb");
        _vkUtil.getUser_DB(getUsersDBHandler);
    }

    private function getUsersDBHandler(e:Event):void
    {
        Listing.getInstance().listTrace("Main | getUsersDBHandler ");
        Listing.getInstance().listTrace("fromDB: " + e.target.data);

        _parser.parse_users_get(XML(e.target.data));
        viewResult(_parser.parse_users_get(XML(e.target.data)));
    }
    ////// getUserDb block END //////

    ////// getUserParam block //////
    private function getUserParam(e:MouseEvent):void
    {
        _vkUtil.getUserParam(_flashVars['viewer_id'], "first_name", getUserParamHandler);
    }

    private function getUserParamHandler(e:Event):void
    {
        Listing.getInstance().listTrace("getUserParam response: " + e.target.data);
        //TODO check: e.target.data is valid?
        viewResult(_parser.parse_user_param(XML(e.target.data)))
        //parser.parse_user_param(XML(e.target.data));

    }
    ////// getUserParam block END //////

    private function viewResult(data:Object):void {
        var _userDbInfoPopUp:PopUp = new PopUp;
        this.addChild(_userDbInfoPopUp);
        for (var key: String in data) {
            _userDbInfoPopUp.writeText(key + "=" + data[key] + "\n");
        }
    }

    ////// getUserFriends block //////
    private function getUserFriends(e:MouseEvent):void
    {
        if (_slotList.length < 1) {
            _vkUtil.getUserFriends(_flashVars['viewer_id'], getUserFriendsHandler);
        }else {
            _slotList = new Vector.<Slot>;
            formSlots();
            formViewList();
        }
    }

    private function getUserFriendsHandler(data: Object):void {
        var user_photo:String = "http://truelancer.com/vkontakte/images/camera_c.gif";

        Listing.getInstance().listTrace("getUserFriendsHandler");
        Listing.getInstance().listTrace("data = "+data);
        for (var user:String in data) {
            if(data[user]["photo"] != "http://vk.com/images/camera_c.gif"){
                user_photo = data[user]["photo"];
            }else{
                user_photo = "http://truelancer.com/vkontakte/images/camera_c.gif";
            }
            var userC:User = new User(data[user]["uid"], data[user]["first_name"], data[user]["last_name"], user_photo, 3, 100);
            suppUser(userC);
            _userList.push(userC);
        }
    }

    private function suppUser(user:User):void {
        //Listing.getInstance().listTrace("suppUser "+user.uid+";");
        _vkUtil.getUserParam(user.uid, "rnd", setUserTypeByDbHandler);
        _uncheckedUserCounter++;
    }

    private function setUserTypeByDbHandler(e:Event):void
    {
        //Listing.getInstance().listTrace("setUserTypeByDb  DB response: " + e.target.data);
        //TODO check: e.target.data is valid?
        //viewResult(_parser.parse_user_param(XML(e.target.data)));
        var parsedUser:Object = _parser.parse_user_param(XML(e.target.data));

        Listing.getInstance().listTrace ("uid = " + parsedUser.uid);
        if (parsedUser.value){
            Listing.getInstance().listTrace(" - not null");
            findAndSetTypeForUserByUid(uint(parsedUser.uid), int(parsedUser.value));
        }
        _uncheckedUserCounter--;
        if (_uncheckedUserCounter == 0) {
            formSlots();
            formViewList();
        }
    }

    private function findAndSetTypeForUserByUid(id:uint, rnd:int):void {
        Listing.getInstance().listTrace("findAndSetTypeForUserByUid " + id);
        for each(var key:User in _userList) {
            if (key.uid == id) {
                key.userType = 2;//app installed
                key.rnd = rnd;
            }
        }
    }

    private function formSlots():void {
        Listing.getInstance().listTrace("formSlots()");
        var playerSlot:Slot ;
        for (var i:uint = 1; i < _userList.length; i++ ) {
            var slot:Slot = new Slot(_userList[i].first_name, _userList[i].photo, String(_userList[i].rnd), _userList[i].userType);
            if (_userList[i].uid == _flashVars['viewer_id']) {
                playerSlot = slot;
            }else if(_userList[i].userType == 2) {//app installed
                _slotList.unshift(slot);
            }else {
                _slotList.push(slot);
            }
        }
        if (!playerSlot) {

            Listing.getInstance().listTrace ("_userList[0].first_name = "+_userList[0].first_name);
            Listing.getInstance().listTrace ("_userList[0].photo = "+_userList[0].photo);
            Listing.getInstance().listTrace ("_userList[0].rnd = "+_userList[0].rnd);
            Listing.getInstance().listTrace ("_userList[0].userType = " + _userList[0].userType);

            playerSlot = new Slot(_userList[0].first_name, _userList[0].photo, String(_userList[0].rnd), _userList[0].userType);
            _slotList.unshift(playerSlot);
        }
    }

    private function formViewList():void {
        Listing.getInstance().listTrace("formViewList()");

        _userFriendsListViewer = new UsersList(_slotList, 8);
        _userFriendsListViewer.y = 200;
        _userFriendsListViewer.x = 0;
        this.addChild(_userFriendsListViewer);
    }
    ////// getUserFriends block END //////

    private function buyTime(event:MouseEvent):void {
        _vkUtil.showOrderBox("time");
    }

    ////// checkPlayerInDb block //////
    private function checkPlayerInDb():void
    {
        Listing.getInstance().listTrace("_flashVars['viewer_id'] = " + _flashVars['viewer_id']);
        _vkUtil.getUserParam(_flashVars['viewer_id'], "uid", checkPlayerInDbHandler);

    }

    public function checkPlayerInDbHandler(e:Event):void
    {
        var parsedUid:Object = _parser.parse_user_param(XML(e.target.data));

        Listing.getInstance().listTrace("uid = " + parsedUid.uid);
        //_vkUtil.getUser(_flashVars['viewer_id'], savePlayerHandler); //test - must be removed!
        //savePlayerHandler(parsedUser);

        if (parsedUid.value){
            Listing.getInstance().listTrace("Player in db");//start "player in bd" link
            _vkUtil.getUserByUid_DB(_flashVars['viewer_id'], getUserByUidHandler);
        }else {
            Listing.getInstance().listTrace("Player not in Db");//start "player not in bd" link
            _vkUtil.getUser(_flashVars['viewer_id'], savePlayerHandler);
//				addPlayerToUserList();
        }
    }

    private function getUserByUidHandler(e:Event):void
    {
        var userFromDb:Object;
        var user_type:uint = 2;
        var user_photo:String = "http://truelancer.com/vkontakte/images/camera_c.gif";
        Listing.getInstance().listTrace("getUserByUidHandler ");
        Listing.getInstance().listTrace("fromDB: " + e.target.data);
        userFromDb = _parser.parse_user_get(XML(e.target.data));

        if (userFromDb.uid == _flashVars['viewer_id']) {
            Listing.getInstance().listTrace("User is player ")
            user_type = 1;//user from db is Player
            //return;
        }

        if (userFromDb.photo != "http://vk.com/images/camera_c.gif"){
            user_photo = userFromDb.photo;
        }

        var player:User = new User(userFromDb.uid, userFromDb.first_name, userFromDb.last_name, user_photo, user_type, userFromDb.rnd);
        _userList.unshift(player);//end "player in bd" link
        //viewResult(_parser.parse_user_get(XML(e.target.data)));
    }

    private function savePlayerHandler(data: Object):void {
        Listing.getInstance().listTrace("savePlayerHandler");
        _vkUtil.saveUserToDb(Object(data[0]), savePlayerToDbHandler);

        var user_photo:String = "http://truelancer.com/vkontakte/images/camera_c.gif";

        Listing.getInstance().listTrace("savePlayerHandler");
        Listing.getInstance().listTrace("data = "+data);

        if(data[0]["photo"] != "http://vk.com/images/camera_c.gif"){
            user_photo = data[0]["photo"];
        }
        var player:User = new User(data[0]["uid"], data[0]["first_name"], data[0]["last_name"], user_photo, 1, 200);
        _userList.push(player);//end "player not in bd" link
    }

    private function savePlayerToDbHandler(e:Event):void
    {
        Listing.getInstance().listTrace("Player saved to db");
        _vkUtil.getUserParam((_parser.parse_saveUserToDb_resp(XML(e.target.data))).uid, "rnd", rndHandler);
//            _userList[0].rnd = (e.target.data)
//			_vkUtil.getUserByUid_DB(_flashVars['viewer_id'], getUserByUidHandler);
        //checkPlayerInDb();
    }

    private function rndHandler(e:Event):void {
        Listing.getInstance().listTrace("rndHandler \n");
        _userList[0].rnd = _parser.parse_user_param(XML(e.target.data)).value;
    }
    ////// checkPlayerInDb block END //////


    private var _vkUtil:VKUtil;
        private var _flashVars: Object;
        private var _parser:ParserXML;
        private var _userFriendsListViewer:UsersList;
        private var _listing:Listing;

        private var _uncheckedUserCounter:uint = 0;

        private var _userList:Vector.<User>;
        private var _slotList:Vector.<Slot>;
    }
}

package userList
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Plazer
	 */
	public class UsersList extends Sprite
	{
		public function UsersList(slots:Vector.<Slot>, count:uint = 5) {
			_slotsCount = count;
			_slotsList = slots;
			createList();
			bg_create();
		}

		private function createList():void {
			var count:uint = _slotsCount;
			container = new Sprite;
			container.x = 0;
			container.y = 4;
			
			if (count > _slotsList.length) {
				count = _slotsList.length;
			}
			for (var i:uint = 0; i < count; i++) {
				var slot:Slot = _slotsList[i];
				slot.x = ((i * slot_width) + slot_interval*(i+1));
				container.addChild(slot);
			}
			this.addChild(container);
		}

		private function bg_create():void {
			_bg=new Sprite  ;
			_bg.graphics.beginFill(_bgColor,1);
			_bg.graphics.lineStyle();
			var max_X:int = container.width+2*slot_interval;
			_bg.graphics.drawRect(0,0,max_X,slot_height+8);
			_bg.x=0;
			_bg.y=0;
			addChildAt(_bg,0);
		}
		
		private function close():void 
		{
			this.parent.removeChild(this);
		}
		
		private var _bg:Sprite;
		private var _bgColor:int = 0x778899;
		
		private var container:Sprite;
		private var _slotsList:Vector.<Slot>;
		
		private var _slotsCount:uint;
		
		private var slot_width:uint = 60;
		private var slot_height:uint = 100;
		private var slot_interval:uint = 8;
		
	}
}
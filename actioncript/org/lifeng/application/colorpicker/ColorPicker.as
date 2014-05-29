package org.lifeng.application.colorpicker
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * 颜色拾取器
	 * @author Jaja as-max.cn
	 */
	public class ColorPicker extends Sprite
	{
		private var clicker:Clicker = new Clicker;
		private var colorArea:ColorFormArea = new ColorFormArea(colorChangeHandler);
		
		/**
		 * 最近的一次颜色值
		 */
		private var lastestColor:String = "0x000000";
		
		public function ColorPicker() :void
		{
			//add clicker
			super.addChild(clicker);
			
			colorArea.visible = false;
			super.addChild(colorArea);
			
			this.addEventListener(Event.ADDED_TO_STAGE, addThis);
		}
		
		/**
		 * 获得颜色值
		 */
		public function get color():uint {
			return uint(lastestColor);
		}
		
		/**
		 * 获得颜色字符串
		 */
		public function get colorString():String {
			return lastestColor;
		}
		
		private function colorChangeHandler(color:String):void {
			clicker.color = color;
		}
		
		/**
		 * 控制是否显示颜色区域
		 * @param    event
		 */
		private function clickThis(event:MouseEvent = null):void {
			if (colorArea.visible) {
				if (this.mouseY >= colorArea.y + 30) {
					colorArea.visible = false;
					sendSelectEvent();
				}
			}else {
				colorArea.visible = true;
				
				if (this.stage.mouseX > stage.stageWidth - colorArea.width) {
					colorArea.x = - colorArea.width - 5;
				}else {
					colorArea.x = clicker.x + clicker.width + 5;
				}
				if (this.stage.mouseY > stage.stageHeight - colorArea.height) {
					colorArea.y = -colorArea.height + 20;
				}else {
					colorArea.y = clicker.y + 5;
				}
			}
		}
		
		private function keyDown(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case 27://Esc Key
					showLatestColor();
					break;
				case 13://Enter Key
					colorArea.visible = false;
					sendSelectEvent();
					break;
			}
		}
		
		private function lostFocus(event:MouseEvent):void {
			if (this.mouseX < colorArea.x ||
				this.mouseX > colorArea.width + colorArea.x ||
				this.mouseY < colorArea.y ||
				this.mouseY > colorArea.height + colorArea.y) 
			{
				showLatestColor();
			}
		}
		
		private function lostSystemFocus(event:Event):void {
			showLatestColor();
		}
		
		/**
		 * 显示最近的一次颜色
		 */
		private function showLatestColor():void {
			colorArea.visible = false;
			clicker.color = lastestColor;
		}
		
		private function addThis(event:Event):void {
			if(!hasEventListener(MouseEvent.CLICK))
				this.addEventListener(MouseEvent.CLICK, clickThis);
			if(!hasEventListener(Event.REMOVED_FROM_STAGE))
				this.addEventListener(Event.REMOVED_FROM_STAGE, removeThis);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, lostFocus);
			if(!hasEventListener(Event.DEACTIVATE))
				this.addEventListener(Event.DEACTIVATE, lostSystemFocus);
		}
		
		private function removeThis(event:Event):void {
			this.removeEventListener(MouseEvent.CLICK, clickThis);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removeThis);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, lostFocus);
			this.removeEventListener(Event.DEACTIVATE, lostSystemFocus);
		}
		
		/**
		 * @eventType flash.events.Event.SELECT
		 */
		[Event(name = "select", type = "flash.events.Event")]
		private function sendSelectEvent():void {
			lastestColor = clicker.color;
			dispatchEvent(new Event(Event.SELECT));
		}
		
		//disable functions
		public override function addChild(child:DisplayObject):DisplayObject 
		{
			throw new Error("此方法不可用");
		}
		public override function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			throw new Error("此方法不可用");
		}
		public override function contains(child:DisplayObject):Boolean 
		{
			throw new Error("此方法不可用");
		}
		public override function removeChild(child:DisplayObject):DisplayObject 
		{
			throw new Error("此方法不可用");
		}
		public override function removeChildAt(index:int):DisplayObject 
		{
			throw new Error("此方法不可用");
		}
		public override function setChildIndex(child:DisplayObject, index:int):void 
		{
			throw new Error("此方法不可用");
		}
		public override function swapChildren(child1:DisplayObject, child2:DisplayObject):void 
		{
			throw new Error("此方法不可用");
		}
		public override function swapChildrenAt(index1:int, index2:int):void 
		{
			throw new Error("此方法不可用");
		}
		public override function set width(value:Number):void 
		{
			throw new Error("尝试对只读属性进行赋值");
		}
		public override function set height(value:Number):void 
		{
			throw new Error("尝试对只读属性进行赋值");
		}
		
	}
	
}

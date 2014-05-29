package org.lifeng.application.colorpicker
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	class ColorForm extends Sprite {
		
		private var theHandler:Function;
		
		/**
		 * 颜色块的颜色
		 */
		private var theColor:String = "";
		
		private var sharp:Shape = new Shape;
		
		/**
		 * 颜色块
		 * @param    color
		 * @param    mouseOverHandler
		 */
		public function ColorForm(color:String, mouseOverHandler:Function = null):void {
			theColor = color;
			theHandler = mouseOverHandler;
			
			//绘制中部
			graphics.beginFill(uint(color));
			graphics.drawRect(0, 0, 15, 15);
			graphics.endFill();
			//绘制外圈
			sharp.graphics.lineStyle(1, 0xFFFFFF);
			sharp.graphics.drawRect(0, 0, 15, 15);
			addChild(sharp);
			sharp.visible = false;
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, removeThis);
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverThis);
		}
		
		private function mouseOverThis(event:MouseEvent):void {
			if (Boolean(theHandler)) {
				theHandler(theColor);
			}
		}
		
		private function mouseOutThis(event:MouseEvent):void {
			select = false;
		}
		
		private function removeThis(event:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removeThis);
			this.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverThis);
		}
		
		/**
		 * 获得或设置选中状态
		 */
		public function set select(value:Boolean):void {
			sharp.visible = value;
		}
		public function get select():Boolean {
			return sharp.visible;
		}
		
		/**
		 * 获得本色块的颜色
		 */
		public function get color():String {
			return theColor;
		}
	}
}
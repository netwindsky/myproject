package org.lifeng.application.colorpicker
{
	import flash.display.Sprite;
	
	class ClickColorArea extends Sprite {
		
		/**
		 * 拾色器头显示当前颜色的部分
		 * @param    color 默认为黑色
		 */
		public function ClickColorArea(color:uint = 0x000000):void {
			changeColor(color);
		}
		
		/**
		 * 改变此显示区域的颜色
		 * @param    color
		 */
		public function changeColor(color:uint):void {
			graphics.clear();
			graphics.beginFill(color);
			graphics.drawRect(0, 0, 20, 20);
			graphics.endFill();
		}
	}
}
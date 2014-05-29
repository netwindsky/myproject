
package org.lifeng.application.colorpicker {
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	class Clicker extends Sprite {
		
		/**
		 * 拾色器的头
		 */
		private var myColorArea:ClickColorArea = new ClickColorArea;
		
		/**
		 * 包含的颜色的字符串表示形式
		 */
		private var theColor:String = "0x000000";
		public function Clicker():void {
			with(graphics){
				lineStyle(1, 0xFFFFFF, 1, true, "normal", CapsStyle.SQUARE, JointStyle.MITER);
				moveTo(0, 25);
				lineTo(0, 0);
				lineTo(25, 0);
				lineStyle(1, 0xAAAAAA, 1, true, "normal", CapsStyle.SQUARE, JointStyle.MITER);
				lineTo(25, 25);
				lineTo(0, 25);
				lineStyle(1, 0xEEEEEE, 1, true, "normal", CapsStyle.SQUARE, JointStyle.MITER);
				moveTo(1, 24);
				lineTo(1, 1);
				lineTo(24, 1);
				lineTo(24, 24);
				lineTo(1, 24);
				lineStyle(1, 0xCCCCCC, 1, true, "normal", CapsStyle.SQUARE, JointStyle.MITER);
				moveTo(2, 23);
				lineTo(2, 2);
				lineTo(23, 2);
				lineStyle(1, 0xFFFFFF, 1, true, "normal", CapsStyle.SQUARE, JointStyle.MITER);
				lineTo(23, 23);
				lineTo(2, 23);
			}
			
			myColorArea.x = 2.5;
			myColorArea.y = 2.5;
			addChild(myColorArea);
			
			var blackArr:Shape = new Shape;
			blackArr.graphics.beginFill(0xEEEEEE);
			blackArr.graphics.drawRect(0, 0, 8, 6);
			blackArr.graphics.endFill();
			blackArr.graphics.beginFill(0);
			blackArr.graphics.lineStyle(.01, 0xCCCCCC, 1, true, "normal", CapsStyle.SQUARE, JointStyle.MITER);
			blackArr.graphics.moveTo(1, 1);
			blackArr.graphics.lineTo(7, 1);
			blackArr.graphics.lineTo(4, 5);
			blackArr.graphics.lineTo(1, 1);
			blackArr.graphics.endFill();
			blackArr.x = this.width - blackArr.width - 2;
			blackArr.y = this.height - blackArr.height - 2;
			addChild(blackArr);
		}
		
		/**
		 * 改变选中的颜色
		 * @param    color
		 */
		public function changeColor(color:uint):void {
			myColorArea.changeColor(color);
		}
		
		/**
		 * 设置颜色
		 */
		public function set color(color:String):void {
			theColor = color;
			myColorArea.changeColor(uint(color));
		}
		/**
		 * 获得颜色
		 */
		public function get color():String {
			return theColor;
		}
	}
}
package org.lifeng.tool {
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.display.Graphics;

	/**
	 * 提示文本
	 * @author Flying http://www.riafan.com
	 */
	public class ToolTip{
		private static var toolTip : TextField;
		private static var format : TextFormat;
		private static var owner :DisplayObjectContainer;
		private static var sprite:Sprite;
		//tooltip对象是否可用
		public static var enabled : Boolean = true;
		//目标对象数组
		private static var owners : Array = new  Array();
		//文本对象数组
		private static var texts : Array = new Array();
		
		public function ToolTip() {
			
		}
		
		/**
		 * 获取/设置提示文本的顶级显示对象
		 */
		public static function get root() :DisplayObjectContainer{
			return owner;
		}

		public static function set root(value :DisplayObjectContainer) : void {
			if (owner == null){
				owner = value;
			}
		}
		
		/**
		 * 新建一个提示文本
		 *
		 * @param   owner  要设置提示文本的目标对象
		 * @param   text  提示文本的内容
		 */
		 
		public static function create(target:InteractiveObject, text: String) : void {
		 	owners.push(target);
			texts.push(text);
		 	target.addEventListener(MouseEvent.MOUSE_OVER, ToolTip.showToolTip);
			target.addEventListener(MouseEvent.MOUSE_OUT, ToolTip.hideToolTip);
			
		}
		/**
		 * 显示提示文本
		 */
		 
		private static function showToolTip(e : MouseEvent) : void {
			var target:InteractiveObject = e.target as InteractiveObject;
			
			//初始化动态文本
			toolTip = new TextField();
			toolTip.visible = true;
			toolTip.text = findText(InteractiveObject(e.currentTarget));
			toolTip.background = true;
			toolTip.backgroundColor= 0xffffff;
			toolTip.multiline = false;
			toolTip.wordWrap = false;
			toolTip.autoSize = TextFieldAutoSize.LEFT;
			toolTip.x = 3;	
			toolTip.y = 3;
			
			//设置动态文本样式
			format = new TextFormat();
			format.font = "微软雅黑";
			format.bold = true;
			format.color = 0x666666;
			format.leftMargin = 4;
			format.rightMargin = 4;
			format.size = 11;
			toolTip.setTextFormat(format);
			
			//设置提示的背景样式 
			sprite = new Sprite;
			var g:Graphics = sprite.graphics;
			g.beginFill(0xB8B7D7,0.8);
			g.drawRoundRect(0,0,toolTip.width + 6,toolTip.height + 6,4,4);
			
			g.endFill();
			
			sprite.addChild(toolTip);
			sprite.x = target.x + target.width - 20;	
			sprite.y = target.y + target.height + 5;
			
			owner.addChild(sprite);
			
		}
		
		/**
		 * 隐藏提示文本
		 */

		private static function hideToolTip(e : MouseEvent) : void {
			//toolTip.visible = false;  
			sprite.visible = false;
			owner.removeEventListener(MouseEvent.MOUSE_OVER, showToolTip);
			owner.removeEventListener(MouseEvent.MOUSE_OUT, hideToolTip);  
		}
		
		/**
		 * 返回特定文本
		 * 
		 * @param   target  目标对象
		*/
		
		private static function findText(owner:InteractiveObject) : String {
			var index : int = owners.indexOf(owner);
			return texts[index];
		}
	}
}
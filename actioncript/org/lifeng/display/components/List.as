package org.lifeng.display.components
{
	import flash.display.Sprite;
	
	public class List extends Sprite
	{
		
		private var _items:Array;
		private var _width:int;
		private var _height:int;
		
		public function List(_w:int,_h:int,items:Array)
		{
			super();
			
			_items=items;
			_width=_w;
			_height=_h;
			init();
			
		}
		public function addElement():void{
			
		}
		public function removeElement():void{
			
		}
		public function clear():void{
			
		}
		private function init():void{
			
		}
	}
}
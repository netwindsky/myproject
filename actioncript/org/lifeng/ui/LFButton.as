package org.lifeng.ui
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.lifeng.events.CustomEvent;
	
	public class LFButton extends Sprite
	{
		public var id:String="";
		
		private var dispatcher:EventDispatcher;
		private var updisplay:DisplayObject;
		private var downdisplay:DisplayObject;
		public function LFButton()
		{
			super();
			this.buttonMode=true;
		}
		
		public function setUpStateImagePath(path:String):void{
			var loader:Loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,upcompleteHandler);
			loader.load(new URLRequest(path));
		}
		public function setDownStateImagePath(path:String):void{
			var loader:Loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,downcompleteHandler);
			loader.load(new URLRequest(path));
		}
		public function setOverStateImagePath(path:String):void{
			
		}
		private function upcompleteHandler(e:Event):void{
			e.target.removeEventListener(Event.COMPLETE,upcompleteHandler);
			updisplay=e.target.loader.content as DisplayObject;
			
			if(updisplay==null){
				throw(new Error("LFButton:upState显示对象不对。"));
			}
			
			if(!hasEventListener(MouseEvent.ROLL_OVER)){
				addEventListener(MouseEvent.ROLL_OVER,rolloverHandler);
			}
			if(!hasEventListener(MouseEvent.MOUSE_DOWN)){
				addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			}
			addChild(updisplay);
			dispatchEvent(new CustomEvent("upover"));
		}
		
		private function downcompleteHandler(e:Event):void{
			e.target.removeEventListener(Event.COMPLETE,downcompleteHandler);
			downdisplay=e.target.loader.content as DisplayObject;
			if(downdisplay==null){
				throw(new Error("LFButton:DownState显示对象不对。"));
			}
			if(!hasEventListener(MouseEvent.ROLL_OVER)){
				addEventListener(MouseEvent.ROLL_OVER,rolloverHandler);
			}
			if(!hasEventListener(MouseEvent.MOUSE_DOWN)){
				addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			}
			addChild(downdisplay);
			downdisplay.visible=false;
			dispatchEvent(new CustomEvent("downover"));
		}
		private function rolloverHandler(e:MouseEvent):void{
			//trace("rollover");
		}
		private function downHandler(e:MouseEvent):void{
			//trace("downHandler");
			updisplay.visible=false;
			downdisplay.visible=true;
		}
		public function resite():void{
			updisplay.visible=true;
			downdisplay.visible=false;
		}
		private function set upStatus(display:DisplayObject):void{
			
		}
		private function set overStatus(display:DisplayObject):void{
			
		}
		private function set downStatus(display:DisplayObject):void{
			
		}
	}
}
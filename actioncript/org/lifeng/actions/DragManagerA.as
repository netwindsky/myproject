package org.lifeng.actions
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	
	import org.lifeng.events.CustomEvent;
	import org.lifeng.filesystem.FileWriter;

	public class DragManagerA extends EventDispatcher
	{
		private var timer:Timer;
		private var _display:DisplayObjectContainer;
		private var point:Point;
		private var file:FileWriter;
		private var offsetbj:int=0;
		public function DragManagerA()
		{
			
		}
		public function initDragEventToDisplayObject(display:DisplayObjectContainer):void{
			//trace("dragobj",display.getChildByName("drag"));
			
			display.getChildByName("drag").addEventListener(MouseEvent.MOUSE_DOWN,mousedownHandler);
			
			
			//trace(display.getChildByName("drag").hasEventListener(MouseEvent.MOUSE_DOWN))
			display.stage.addEventListener(MouseEvent.MOUSE_UP,mouseupHandler);
			_display=display;
		}
		public function removeDragEventFromDisplayObject():void{
			if(_display){
				_display.getChildByName("drag").removeEventListener(MouseEvent.MOUSE_DOWN,mousedownHandler);
				_display.stage.removeEventListener(MouseEvent.MOUSE_UP,mouseupHandler);
			}
		}
		public function setOffset(value:int):void{
			offsetbj=value;
		}
		private function mouseupHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(timer){
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,timerHandler);
				timer=null;
				DatabaseServer.getInstance().setX(_display.x);
				DatabaseServer.getInstance().setY(_display.y);
			}
		}
		
		private function mousedownHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			//trace("aaaaaaaaaa");
			timer=new Timer(10);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
			point=new Point(_display.mouseX*_display.scaleX,_display.mouseY*_display.scaleX);
		}
		
		private function timerHandler(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			//trace("timer handler");
			if(_display.stage){
				_display.x=_display.stage.mouseX-point.x;
				_display.y=_display.stage.mouseY-point.y;
				var rect:Rectangle=_display.getRect(_display.parent);
				var barw:int=_display.getChildByName("bar").width*_display.scaleX;
				//trace(rect);
				var offset:int=20;
				
				if(rect.top<offset-offsetbj){
					_display.y=-offsetbj;
					dispatchEvent(new CustomEvent("top"));
				}
				if(rect.left<offset-offsetbj){
					_display.x=-offsetbj;
					dispatchEvent(new CustomEvent("left"));
				}
				if(rect.bottom>_display.stage.stageHeight-offset+offsetbj){
					
					_display.y=_display.stage.stageHeight-rect.height+offsetbj;
					dispatchEvent(new CustomEvent("bottom"));
				}
				if(rect.right>_display.stage.stageWidth-offset){
					_display.x=_display.stage.stageWidth-rect.width+offsetbj+barw;
					dispatchEvent(new CustomEvent("rigth"));
					
				}
			}else{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,timerHandler);
				timer=null;
			}
			
		}
	}
}
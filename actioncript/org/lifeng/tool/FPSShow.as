package org.lifeng.tool
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;

	public class FPSShow extends Sprite
	{
		private var timer:Timer=new Timer(1000);
		private var txt:TextField=new TextField();
		private var count:int=0;
		public function FPSShow()
		{
			super();
			init();
		}
		public function init():void{
			txt.textColor=0xff0000;
			txt.autoSize=TextFieldAutoSize.LEFT;
			txt.multiline=true;
			txt.defaultTextFormat=new TextFormat("Arial",10,0x00ff00);
			
			
			
			txt.text="FPS:00/00\nRAM:"+System.totalMemory/1024/8+"KB";
			var shape:Shape=new Shape();
			shape.graphics.beginFill(0xffffff,.5);
			shape.graphics.drawRect(0,0,txt.width+10,txt.height);
			shape.graphics.endFill();
			addChild(shape);
			addChild(txt);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		private function timerHandler(e:TimerEvent):void{
			if(this.stage){
				txt.text="FPS:"+count+"/"+this.stage.frameRate+"\nRAM:"+System.totalMemory/1024/8+"KB";
			}
			
			//trace(System.totalMemory,System.totalMemoryNumber,System.freeMemory,System.privateMemory);
			count=0;	
		}
		private function enterFrameHandler(e:Event):void{
			count++;
		}
		public function dispose():void{
			
		}
		
	}
}
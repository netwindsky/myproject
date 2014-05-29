package org.lifeng.display
{
	import com.crystalcg.ncity.events.CustomEvent;
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class CoolDownView extends Sprite
	{
		private var _width:int;
		private var _height:int;
		private var _time:int;
		
		private var timer:Timer=new Timer(1000,1);
		
		private var sprite:Sprite=new Sprite();
		private var mark:Sprite=new Sprite();
		/**
		 * 
		 * 
		 * 
		 * 冷却时间
		 * 
		 * */
		public function CoolDownView()
		{
			super();
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
		}
		public function setSize(_w:int,_h:int):void{
			_width=_w;
			_height=_h;
			
			this.graphics.beginFill(0xff0000,.3);
			this.graphics.drawRect(0,0,_width,_height);
			this.graphics.endFill();
			
			sprite.graphics.beginFill(0x0000ff,.5);
			sprite.graphics.drawRect(0,0,_width,_height);
			sprite.graphics.endFill();
			addChild(sprite);
			
			
			mark.graphics.beginFill(0x0000ff,.5);
			mark.graphics.drawRect(0,0,_width,_height);
			mark.graphics.endFill();
			
			addChild(mark);
			
			sprite.mask=mark;
			
		}
		public function setTimer(time:int):void{
			_time=time;
			timer.delay=_time;
			
		}
		
		public function start():void{
			sprite.y=0;
			timer.start();
			TweenLite.to(sprite,_time/1000,{y:(""+_height)});
		}
		private function timerHandler(e:TimerEvent):void{
			dispatchEvent(new CustomEvent("cooldownOver"));
			//sprite.y=0;
		}
	}
}
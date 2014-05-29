package org.lifeng.application.clock
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Clock extends Sprite
	{
		private var r:Number;//钟面半径
		private var hourHand:Shape;//时针
		private var minuteHand:Shape;//分针
		private var secondHand:Shape;//秒针
		
		public function Clock(r:Number)
		{
			this.r = r;
			initClock();
			initClockPoint();
			initClockFinger();
			
			var timer:Timer = new Timer(100,0);
			timer.addEventListener(TimerEvent.TIMER, refreshClock);
			timer.start();
			refreshClock(null);
		}
		
		//画钟面
		public function initClock():void
		{
			this.graphics.lineStyle(2);
			this.graphics.drawCircle(r,r,r+2);
			this.graphics.beginFill(0xffffff);
			this.graphics.drawCircle(r,r,r);
			this.graphics.beginFill(0x000000);
			this.graphics.drawCircle(r,r,1);
		}
		
		//画整点
		public function initClockPoint():void
		{
			for (var i:int=0; i<12; i++)
			{
				var px:Number = Math.sin(Math.PI*i/6)*(r-5);
				var py:Number = Math.cos(Math.PI*i/6)*(r-5);
				this.graphics.beginFill(0x000000);
				var rr:int = 1;
				if (i%3 == 0)
					rr = 2;
				this.graphics.drawCircle(r+px, r-py, rr);
			}
		}
		
		//初始化指针
		public function initClockFinger():void
		{
			hourHand = new Shape();
			hourHand.graphics.lineStyle(3);
			hourHand.graphics.moveTo(0, -0.5*r);
			hourHand.graphics.lineTo(0, 0);
			hourHand.x = r;
			hourHand.y = r;                
			addChild(hourHand);
			
			minuteHand = new Shape();
			minuteHand.graphics.lineStyle(2);
			minuteHand.graphics.moveTo(0, -0.6*r);
			minuteHand.graphics.lineTo(0, 0);
			minuteHand.x = r;
			minuteHand.y = r;
			addChild(minuteHand);
			
			secondHand = new Shape();
			secondHand.graphics.lineStyle(1);
			secondHand.graphics.moveTo(0, -0.8*r);
			secondHand.graphics.lineTo(0, 0);
			secondHand.x = r;
			secondHand.y = r;
			addChild(secondHand);
		}
		
		//刷新指针
		public function refreshClock(event:TimerEvent):void
		{
			var currentTime:Date = new Date();
			var hour:uint = currentTime.getHours();
			var minute:uint = currentTime.getMinutes();
			var second:uint = currentTime.getSeconds();
			
			this.hourHand.rotation = hour*30 + minute*0.5;
			this.minuteHand.rotation = minute*6;
			this.secondHand.rotation = second*6;
		}
	}
}
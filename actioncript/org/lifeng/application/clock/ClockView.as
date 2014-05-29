package org.lifeng.application.clock
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import org.lifeng.events.CustomEvent;
	import org.lifeng.filesystem.FileWriter;
	
	public class ClockView extends Sprite
	{
		private var r:Number;//钟面半径
		//private var hourHand:Shape;//时针
		//private var minuteHand:Shape;//分针
		//private var secondHand:Shape;//秒针
		private var ui:MovieClip;
		private var timer:Timer = new Timer(500,0);
		public function ClockView(r:Number)
		{
			this.r = r;
			//initClock();
			//initClockPoint();
			//initClockFinger();
			//ui=new UIStyle1();
			//addChild(ui);
			
			timer.addEventListener(TimerEvent.TIMER, refreshClock);
			//timer.start();
			//refreshClock(null);
		}
		public function changeStyle(stylename:String):void{
			dispatchEvent(new CustomEvent("warn","changestyle"));
			var maiovisible:Boolean=true;
			timer.stop();
			if(ui){
				maiovisible=ui.mz.visible;
				if(ui.parent){
					ui.parent.removeChild(ui);
					ui=null;
				}
			}
			dispatchEvent(new CustomEvent("warn","switchname  ---->>>"+stylename));
			switch(stylename){
				case "style1":
					ui=new UIStyle1();
					break;
				case "style2":
					ui=new UIStyle2();
					break;
				case "style3":
					ui=new UIStyle3();
					break;
				case "style4":
					ui=new UIStyle4();
					break;
				case "style5":
					ui=new UIStyle5();
					break;
			}
			dispatchEvent(new CustomEvent("warn","switchname  ---->>>"+ui));
			addChild(ui);
			if(maiovisible){
				showMiao();
			}else{
				hideMiao();
			}
			dispatchEvent(new CustomEvent("warn","addChild  ---->>>"+ui.x+":"+ui.y+":"+ui.parent));
			timer.start();
			refreshClock(null);
			DatabaseServer.getInstance().setStyle(stylename);
			dispatchEvent(new CustomEvent("warn","setStyle  ---->>>"+ui.x+":"+ui.y+":"+ui.parent));
			//new FileWriter().writeFile(File.applicationDirectory.nativePath+"\\style.db",stylename);
		}
		
		public function hideMiao():void{
			ui.mz.visible=false;
		}
		public function showMiao():void{
			ui.mz.visible=true;
		}
		/*
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
		*/
		//刷新指针
		public function refreshClock(event:TimerEvent):void
		{
			var currentTime:Date = new Date();
			var hour:uint = currentTime.getHours();
			var minute:uint = currentTime.getMinutes();
			var second:uint = currentTime.getSeconds();
			
			ui.sz.rotation = hour*30 + minute*0.5;
			ui.fz.rotation = minute*6;
			ui.mz.rotation = second*6;
		}
	}
}
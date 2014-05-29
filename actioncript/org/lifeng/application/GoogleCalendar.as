package org.lifeng.application
{
	//import com.adobe.net.URI;
	
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowType;
	import flash.display.Scene;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.events.TimerEvent;
	import flash.html.HTMLLoader;
	import flash.net.Socket;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import org.lifeng.filesystem.NativeWindowSetting;
	
	[SWF(width="1280",height="1024",frameRate="60")]
	public class GoogleCalendar extends Sprite
	{
		private var calendarloader:HTMLLoader=new HTMLLoader();
		//private var socket:Socket=new Socket();
		private var nat:NativeWindow;
		private var mark:Sprite=new Sprite();
		private var open:String="";
		private var exit:String="";
		public function GoogleCalendar()
		{
			var url:URLRequest=new URLRequest("https://www.google.com/calendar/render?pli=1&gsessionid=fjfjrPzEUdbCCwa36HsWww");
			//url.requestHeaders.push(new URLRequestHeader("User-Agent","Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1"))
			//var he:URLRequestHeader=new URLRequestHeader("User-Agent","Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1");
			calendarloader.userAgent="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1";
			calendarloader.load(url);
			calendarloader.paintsDefaultBackground=true;

			
			
			var a:NativeWindowInitOptions=new NativeWindowInitOptions();
			a.systemChrome="none";
			a.transparent=true;
			a.type=NativeWindowType.UTILITY;
			
			nat=new NativeWindow(a);
			nat.x=0;
			nat.y=0;
			nat.stage.scaleMode=StageScaleMode.NO_SCALE;
			nat.stage.align=StageAlign.TOP_LEFT;
			
			
			
			//nat.width=Screen.mainScreen.bounds.width;
			//nat.height=Screen.mainScreen.bounds.height;
			nat.addEventListener(NativeWindowBoundsEvent.RESIZE,resizeH);
			nat.maximize();
			nat.stage.addChild(calendarloader);
			nat.stage.addChild(mark);
			nat.stage.addEventListener(Event.ENTER_FRAME,enterH);
			
			nat.activate();
			nat.orderToBack();
			
			var setting:NativeWindowSetting=new NativeWindowSetting(nat);
			setting.setICONs([new Bitmap(new BitmapData(48,48,false,0xff0000))]);
			setting.setToolTop("谷歌日历");
			setting.addMenuItem("解  锁",function (e:Event){
				var timer:Timer=new Timer(5000,1);
				timer.addEventListener(TimerEvent.TIMER,openHandler);
				timer.start();
				nat.activate();
				nat.stage.addEventListener(KeyboardEvent.KEY_UP,openkeyupHandler);
				//mark.visible=false;
				
			},false);
			setting.addMenuItem("AAAAAAAAAA",function (e:Event){},true);
			setting.addMenuItem("锁  定",function (e:Event){mark.visible=true;},false);
			setting.addMenuItem("fuckyou",function (e:Event){},true);
			setting.addMenuItem("退  出",function (e:Event){
				var timer:Timer=new Timer(5000,1);
				timer.addEventListener(TimerEvent.TIMER,exitHandler);
				timer.start();
				nat.activate();
				nat.stage.addEventListener(KeyboardEvent.KEY_UP,exitkeyupHandler);
			},false);
			this.stage.nativeWindow.close();
		}
		protected function exitkeyupHandler(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			exit+=String.fromCharCode(event.keyCode);
			trace(exit);
		}
		protected function exitHandler(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			if(exit.toLocaleLowerCase()=="crystal8"){
				nat.close();
			}
			exit="";
			nat.stage.removeEventListener(KeyboardEvent.KEY_UP,exitkeyupHandler);
		}
		protected function openkeyupHandler(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			
			open+=String.fromCharCode(event.keyCode);
			trace(open);
		}
		protected function openHandler(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			trace("AAAAAAAAAAAAA",open)
			if(open.toLocaleLowerCase()=="crystal6"){
				mark.visible=false;
				
			}
			open="";
			nat.stage.removeEventListener(KeyboardEvent.KEY_UP,openkeyupHandler);
		}
		protected function resizeH(event:NativeWindowBoundsEvent):void
		{
			// TODO Auto-generated method stub
			calendarloader.width=event.target.stage.stageWidth;
			calendarloader.height=event.target.stage.stageHeight;
			mark.graphics.clear();
			mark.graphics.beginFill(0xff0000,0);
			mark.graphics.drawRect(0,0,event.target.stage.stageWidth,event.target.stage.stageHeight);
			mark.graphics.endFill();
		}
		protected function enterH(event:Event):void
		{
			// TODO Auto-generated method stub
			event.target.nativeWindow.orderToBack();
		}
	}
}
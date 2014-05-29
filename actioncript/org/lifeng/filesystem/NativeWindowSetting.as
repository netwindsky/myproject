package org.lifeng.filesystem
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.DisplayObjectContainer;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.Scene;
	import flash.display.Screen;
	import flash.events.Event;
	import flash.events.ScreenMouseEvent;

	public class NativeWindowSetting
	{
		private var _mainContainer:Object;
		public function NativeWindowSetting(maincontainer:Object)
		{
			_mainContainer=maincontainer;
			if(NativeApplication.supportsSystemTrayIcon){
				var sys:SystemTrayIcon=NativeApplication.nativeApplication.icon as SystemTrayIcon;
				//sys.tooltip=_tooltop;
				sys.addEventListener(ScreenMouseEvent.CLICK,clickH);
			}
		}
		protected function clickH(event:ScreenMouseEvent):void
		{
			// TODO Auto-generated method stub
			if(NativeApplication.nativeApplication.menu)
			NativeApplication.nativeApplication.menu.display(_mainContainer.stage,Screen.mainScreen.bounds.width-125,Screen.mainScreen.bounds.height-100);
			//trace()
		}
		public function setICONs(bitmaps:Array):void{
			NativeApplication.nativeApplication.icon.bitmaps=bitmaps;
			
		}
		public function addMenuItem(_label:String,func:Function,b:Boolean=false):void{
			trace(NativeApplication.supportsMenu);
			//if(NativeApplication.supportsMenu==false) return;
			var item:NativeMenuItem
			if(NativeApplication.nativeApplication.menu){
				item=new NativeMenuItem(_label,b);
				NativeApplication.nativeApplication.menu.addItem(item);
				item.addEventListener(Event.SELECT,func);
			}else{
				NativeApplication.nativeApplication.menu=new NativeMenu();
				item=new NativeMenuItem(_label,b);
				item.addEventListener(Event.SELECT,func);
				NativeApplication.nativeApplication.menu.addItem(item);
			}
			trace(NativeApplication.nativeApplication.menu.items.length);
			NativeApplication.nativeApplication.menu.addEventListener(Event.SELECT,menuselectH);
		}
		
		protected function menuselectH(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("helloWorld");
			//NativeApplication.nativeApplication.menu.display(NativeApplication.nativeApplication.activeWindow.stage,NativeApplication.nativeApplication.activeWindow.stage.mouseX,NativeApplication.nativeApplication.activeWindow.stage.mouseY);
		}
		public function setToolTop(_tooltop:String):void{
			if(NativeApplication.supportsSystemTrayIcon){
				var sys:SystemTrayIcon=NativeApplication.nativeApplication.icon as SystemTrayIcon;
				sys.tooltip=_tooltop;
			}
		}
	}
}
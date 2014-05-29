package org.lifeng.filesystem
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.events.Event;

	public class NativeWindowManager
	{
		public function NativeWindowManager()
		{
			
		}
		/**
		 * 
		 * 新建弹出窗口
		 * 
		 */
		public function createNativeWindow(title:String,width:int,height:int,x:int,y:int):NativeWindow{
			var nao:NativeWindowInitOptions=new NativeWindowInitOptions();
			//nao.systemChrome=true;
			//nao.
			
			
			var window:NativeWindow=new NativeWindow(nao);
			window.title=title;
			window.x=x;
			window.y=y;
			window.width=width;
			window.height=height;
			window.activate();
			return window;
		}
		/**
		 * 
		 * 创建系统托盘
		 * 
		 */
		public function createSystemtray(icon:Bitmap):NativeWindow{
			
			var nao:NativeWindowInitOptions=new NativeWindowInitOptions();
			nao.systemChrome=NativeWindowSystemChrome.NONE;
			nao.type=NativeWindowType.LIGHTWEIGHT;
			nao.transparent=true;
			var window:NativeWindow=new NativeWindow(nao);
			window.maximize();
			NativeApplication.nativeApplication.icon.bitmaps = [icon];
			if(NativeApplication.supportsSystemTrayIcon){
				var sti:SystemTrayIcon = SystemTrayIcon(NativeApplication.nativeApplication.icon);
			}
			/*
			var item:NativeMenuItem
			if(NativeApplication.nativeApplication.menu){
				item=new NativeMenuItem("退  出",false);
				NativeApplication.nativeApplication.menu.addItem(item);
				item.addEventListener(Event.SELECT,function ():void{
					NativeApplication.nativeApplication.activeWindow.close();
				});
			}
			*/
			window.activate();
			return window;
		}
	}
}
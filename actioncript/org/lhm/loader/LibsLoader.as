package org.lhm.loader
{
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	public class LibsLoader extends Sprite
	{
		public static const ALL_OVER:String="all_over";
		public static const ITEM_OVER:String="item_over";
		
		private var arr:Array = new Array();
		private var p:int = 0;
		private var id:String;
		private var swf:DisplayObject;
		private var mainloader:Loader;
		private var id_arr:Array=new Array();
		private var _lock:Boolean=false;
		
		private var sid:String;
		
		//private var cache:Dictionary=new Dictionary();
		
		public function LibsLoader()
		{
			super();
		}
		public function loadNow(url:String = "",id:String=""):void {
			arr.push({url:url,id:id});
		}
		public function start():void {
			if(!_lock)
				next();
		}
		public function dispose():void{
			mainloader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler)
			arr.length=0;
			id_arr.length=0;
		}
		public function clear():void{
			arr.length=0;
			id_arr.length=0;
		}
		private function next():void {
			if (arr.length != 0) {
				var a:Object = arr.shift()
				id=a.id;
				mainloader= new Loader();
				mainloader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
				mainloader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioerrorHandler);
				mainloader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progressHandler);
				mainloader.load(new URLRequest(a.url),new LoaderContext(false,ApplicationDomain.currentDomain));
				_lock=true;
			}else {
				dispatchEvent(new Event(ALL_OVER));
			}
		}
		private function progressHandler(e:ProgressEvent):void{
			//var num:Number=e.bytesLoaded
			dispatchEvent(e);
		}
		private function completeHandler(e:Event):void {
			//trace(id,"::",id_arr,id_arr.indexOf(id));
			if(id=="index"){
				swf=mainloader.content as DisplayObject;
			}
			
			_lock=false;
			dispatchEvent(new Event(ITEM_OVER)); 
			/* swf = mainloader.content as DisplayObject;
			new Sprite().addChild(swf);
			swf.parent.removeChild(swf)
			dispatchEvent(new Event(ITEM_OVER)); */
			trace("over");
			next();
			
		}
		public function getSwf():DisplayObject{
			return swf;
		}
		private function ioerrorHandler(e:IOErrorEvent):void{
			next();
		}
	}
}
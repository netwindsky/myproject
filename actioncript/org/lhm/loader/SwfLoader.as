package org.lhm.loader 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class SwfLoader extends EventDispatcher
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
		
		private var cache:Dictionary=new Dictionary();
		public function SwfLoader() 
		{
			
		}
		public function loadNow(url:String = "", id:String="",sid:String=""):void {
			if(id_arr.indexOf(id)==-1){
				id_arr.push(id);
				arr.push({url:url,id:id,sid:sid});
				//arr.sortOn("url");
			}
		}
		public function start():void {
			if(!_lock)
			next();
		}
		public function dispose():void{
			mainloader.removeEventListener(Event.COMPLETE, completeHandler)
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
				id = a.id;
				sid=a.sid;
				mainloader= new Loader();
				mainloader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
				mainloader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioerrorHandler);
				trace(a.url);
				mainloader.load(new URLRequest(a.url));
				_lock=true;
			}else {
				dispatchEvent(new Event(ALL_OVER));
			}
		}
		private function completeHandler(e:Event):void {
			//trace(id,"::",id_arr,id_arr.indexOf(id));
			_lock=false;
			var num:int=id_arr.indexOf(id);
			if(num!=-1){
				id_arr.splice(num,1);
			}
			
			swf=e.target.loader.content;
			var sprite:Sprite=new Sprite();
			sprite.addChild(swf);
			sprite.removeChild(swf);
			dispatchEvent(new Event(ITEM_OVER)); 
			/* swf = mainloader.content as DisplayObject;
			new Sprite().addChild(swf);
			swf.parent.removeChild(swf)
			dispatchEvent(new Event(ITEM_OVER)); */
			next();
			
		}
		private function ioerrorHandler(e:IOErrorEvent):void{
			next();
		}
		public function getSwf():DisplayObject {
			return swf ;
		}		
		public function getID():String {
			return id;
		}
		private function isNeedlessLoader(id:String):Boolean{
			if(cache[id]!=null){
				return true;
			}else{
				return false;
			}
		}
	}
}
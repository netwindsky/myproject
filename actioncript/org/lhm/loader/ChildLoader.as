package org.lhm.loader
{
	import com.crystalcg.expo.visitexpo.events.VisitEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	public class ChildLoader extends Sprite
	{
		public static const ALL_OVER:String="call_over";
		public static const ITEM_OVER:String="citem_over";
		
		private var _id:String;
		private var _arr:Array;
		private var _lock:Boolean=false;
		private var _loader:Loader;
		
		//public var id:String;
		public var cid:String;
		public var swf:DisplayObject;
		public var site:String="1";
		public function ChildLoader()
		{
			super();
			
		}
		public function load(id:String,arr:Array):void {
			//if(_id==id) return;
			_id=id;
			clear();
			_arr=arr;
		}
		public function start():void {
			if(_arr.length==0) return;
			if(!_lock)
				next();
		}
		public function dispose():void{
			_loader.removeEventListener(Event.COMPLETE, completeHandler)
			_arr.length=0;
			//id_arr.length=0;
		}
		public function clear():void{
			if(_arr){
				_arr.length=0;
			}
			//id_arr.length=0;
		}
		private function next():void {
			if (_arr.length != 0){
				var a:Object = _arr.pop();
				cid = a["id"];
				site=a["site"];
				_loader= new Loader();
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioerrorHandler);
				_loader.load(new URLRequest(a["path"]));
				_lock=true;
			}else {
				dispatchEvent(new Event(ALL_OVER));
			}
		}
		private function completeHandler(e:Event):void {
			//trace(id,"::",id_arr,id_arr.indexOf(id));
			_lock=false;
			
			swf=e.target.loader.content;
			var sprite:Sprite=new Sprite();
			sprite.addChild(swf);
			sprite.removeChild(swf);
			//dispatchEvent(new Event(ITEM_OVER));
			dispatchEvent(new VisitEvent(ITEM_OVER,{swf:swf,cid:cid,site:site},_id))
			next();
			
		}
		private function ioerrorHandler(e:IOErrorEvent):void{
			_lock=false;
			next();
			
		}
		/*public function getSwf():DisplayObject {
			return swf ;
		}		
		public function getID():String {
			return id;
		}*/
	}
}
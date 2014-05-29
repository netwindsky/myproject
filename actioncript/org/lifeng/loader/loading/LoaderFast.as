package org.lifeng.loader.loading
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	
	import org.lifeng.events.CustomEvent;
	import org.lifeng.loader.loading.loaders.ImageLoader;
	import org.lifeng.loader.loading.loaders.NEWURLStream;
	import org.lifeng.loader.loading.loaders.SwfLoader;
	import org.lifeng.regexp.ExtensionManager;

	public class LoaderFast extends EventDispatcher
	{
		
		public static const ITEM_OVER:String="ItemOver";
		
		private var _list:LoaderList=new LoaderList();
		private var _manager:LoaderManager;
		private var status:String="stop";
		private var loaders:Array=new Array();
		public function LoaderFast(processnum:int)
		{
			_manager=new LoaderManager(processnum);
			_manager.addEventListener(CustomEvent.EVENT_NAME,handler);
			//trace(_manager.getLoaderCount());
			
		}
		
		protected function handler(event:CustomEvent):void
		{
			// TODO Auto-generated method stub
			switch(event.command){
				case "LoaderOver":
					var obj:Object=event.body;
					var loader:NEWURLStream=obj.loader as NEWURLStream;
					if(loaders.indexOf(loader)!=-1){
						loaders.splice(loaders.indexOf(loader),1);
					}
					switch(event.body.type){
						case RequestObjectType.IMAGE:
							var imageloader:ImageLoader=new ImageLoader();
							imageloader.url=loader.url;
							imageloader.type=loader.type;
							imageloader.id=loader.id;
							imageloader.loadBytes(obj.bytes);
							imageloader.addEventListener(Event.COMPLETE,imagecompleteH);
							
							break;
						case RequestObjectType.SWF:
							var swfloader:SwfLoader=new SwfLoader();
							//swfloader.url=loader.url;
							//swfloader.type=loader.type;
							//swfloader.id=loader.id;
							//swfloader.loadBytes(obj.bytes,new LoaderContext(false,null,null));
							//swfloader.addEventListener(Event.COMPLETE,swfcompleteH);
							break;
						case RequestObjectType.TEXT:
							var bytes:ByteArray=obj.bytes;
							var string:String=bytes.readMultiByte(bytes.bytesAvailable,"utf-8");
							dispatchEvent(new CustomEvent("ItemOver",{id:loader.id,type:loader.type,content:string}));
							break;
						case RequestObjectType.DATA:
							dispatchEvent(new CustomEvent("ItemOver",{id:loader.id,type:loader.type,content:obj.bytes}));
							break;
					}
					next();
					break;
			}
		}
		
		protected function swfcompleteH(event:Event):void
		{
			// TODO Auto-generated method stub
			
			var loader:SwfLoader=event.target  as SwfLoader;
			var swf:*=event.target.content;
			dispatchEvent(new CustomEvent("ItemOver",{id:loader.id,type:loader.type,content:swf}));
		}
		
		protected function imagecompleteH(event:Event):void
		{
			// TODO Auto-generated method stub
			var loader:ImageLoader=event.target as ImageLoader;
			var bitmap:Bitmap=event.target.content;
			dispatchEvent(new CustomEvent("ItemOver",{id:loader.id,type:loader.type,content:bitmap}));
		}
		public function load(url:String,id:String,type:String=null):void{
			_list.addElement(new RequestObject(url,id,type));	
		}
		public function loadNow(url:String,id:String,type:String=null):void{
			_list.addNowElement(new RequestObject(url,id,type));
		}
		private function next():void{
			var obj:RequestObject=_list.ShiftElement();
			if(obj){
				var loader:NEWURLStream=_manager.getLoader();
				if(loader){
					var exM:ExtensionManager=new ExtensionManager(obj.requesturl);
					loader.type=exM.getType();
					loader.url=obj.requesturl;
					loader.id=obj.ID;
					
					//trace(loader.id);
					loader.load(new URLRequest(obj.requesturl));
					
					loaders.push(loader);
				}else{
					_list.addNowElement(obj);
				}
			}else{
				
			}
		}
		public function start():void{
			status="start";
			var num:int=_manager.getLoaderCount()
			for(var i:int=0;i<num;i++){
				next()
			}
		}
		public function stop():void{
			status="stop";
		}
		public function pause():void{
			status="pause";	
		}
		public function clear():void{
			_list.clear();
		}
	}
}
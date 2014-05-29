package org.lifeng.loader
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	public class NWDLoader extends EventDispatcher
	{
		private var loader:URLStream;
		private var loadArr:Array=new Array();
		private var isLocked:Boolean=false;
		private var currentLoadObject:LoadObject;
		public var data:*;
		private var loadStatus:String="run";
		public function NWDLoader()
		{
			loader=new URLStream();
			loader.addEventListener(Event.COMPLETE,streamCompleteHandler);
			loader.addEventListener(ProgressEvent.PROGRESS,progressHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
		}
		/**
		 * 
		 * 添加加载项。
		 * isreload是否允许重复添加。
		 * 
		 * 
		 * 
		 * */
		public function addElement(obj:LoadObject,isreload:Boolean=false):void{
			loadArr.push(obj);
			/*if(isreload){
				loadArr.push(obj);
			}else{
				//trace("AAAAAAAAAAAa");
				//trace(loadArr.every(callback));
				if(loadArr.every(callback)){
					loadArr.push(obj);
				}else{
					
				}
				
			}*/
		}
		public function start():void{
			if(!isLocked){
				loadStatus="run";
				//trace("ffffffffffff");
				//isLocked=true;
				next();
			}
		}
		public function stop():void{
			loader.close();
			loadArr=[];
			loadStatus="stop";
			
		}
		public function pause():void{
			loader.close();
			loadArr.push(currentLoadObject);
			loadStatus="pause"
		}
		public function dispose():void{
			
		}
		private function callback(element:*, index:int, arr:Array):Boolean{
			//trace(element);
			for(var i:int=0;i<arr.length;i++){
				//trace(arr[i].id,element.id)
				if(arr[i].id==element.id){
					return false;
				}
			}
			return true;
		}
		private function next():void{
			if(loadArr.length>0){
				isLocked=true;
				currentLoadObject=loadArr.pop() as LoadObject;
				//trace(currentLoadObject.path,currentLoadObject.id,currentLoadObject.type);
				loader.load(new URLRequest(currentLoadObject.path));
			}else{
				isLocked=false;
			}
		}
		private function streamCompleteHandler(e:Event):void{
			
			var byteArr:ByteArray=new ByteArray();
			loader.readBytes(byteArr,0,loader.bytesAvailable);
			if(loadStatus=="stop"||loadStatus=="pause") return;
			switch(currentLoadObject.type){
				case LoadObjectType.TYPE_BYTE:
					dispatchEvent(new LoaderEvent(LoaderEvent.ITEM_OVER,{type:LoadObjectType.TYPE_BYTE,data:byteArr},currentLoadObject.id));
					next();
				break;
				case LoadObjectType.TYPE_IMA:
					var loader:Loader=new Loader();
					loader.name=currentLoadObject.id;
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,imaCompleteHandler);
					loader.loadBytes(byteArr);
				break;
				case LoadObjectType.TYPE_SWF_CLASS_PACKAGE:
					var context:LoaderContext=new LoaderContext(false,ApplicationDomain.currentDomain);
					var libloader:Loader=new Loader();
					libloader.name=currentLoadObject.id;
					libloader.contentLoaderInfo.addEventListener(Event.COMPLETE,libHandler);
					libloader.loadBytes(byteArr,context);
				break;
				case LoadObjectType.TYPE_SWF_MOVIE:
					var swfloader:Loader=new Loader();
					swfloader.name=currentLoadObject.id;
					swfloader.contentLoaderInfo.addEventListener(Event.COMPLETE,swfHandler);
					swfloader.loadBytes(byteArr);
				break;
				case LoadObjectType.TYPE_TEXT:
					dispatchEvent(new LoaderEvent(LoaderEvent.ITEM_OVER,{type:LoadObjectType.TYPE_TEXT,data:byteArr.readMultiByte(byteArr.bytesAvailable,"UTF-8")},currentLoadObject.id));
					next();
				break;
				case LoadObjectType.TYPE_XML:
					dispatchEvent(new LoaderEvent(LoaderEvent.ITEM_OVER,{type:LoadObjectType.TYPE_XML,data:XML(byteArr.readMultiByte(byteArr.bytesAvailable,"UTF-8"))},currentLoadObject.id));
					next();
				break;
				default:
					dispatchEvent(new LoaderEvent(LoaderEvent.ITEM_OVER,{type:LoadObjectType.TYPE_BYTE,data:byteArr},currentLoadObject.id));
					next();
				break;
			
			}
		}
		private function imaCompleteHandler(e:Event):void{
			isLocked=false;
			if(loadStatus=="stop"||loadStatus=="pause") return;
			dispatchEvent(new LoaderEvent(LoaderEvent.ITEM_OVER,{type:LoadObjectType.TYPE_IMA,data:e.currentTarget.loader.content},e.currentTarget.loader.name));
			//trace("------->>>>",e.currentTarget.loader.name);
			
			next();
		}
		private function libHandler(e:Event):void{
			if(loadStatus=="stop"||loadStatus=="pause") return;
			dispatchEvent(new LoaderEvent(LoaderEvent.ITEM_OVER,{type:LoadObjectType.TYPE_SWF_CLASS_PACKAGE,data:e.currentTarget.loader.content},e.currentTarget.loader.name));
			//trace("libHandler");
			next();
		}
		private function swfHandler(e:Event):void{
			if(loadStatus=="stop"||loadStatus=="pause") return;
			dispatchEvent(new LoaderEvent(LoaderEvent.ITEM_OVER,{type:LoadObjectType.TYPE_SWF_MOVIE,data:e.currentTarget.loader.content},e.currentTarget.loader.name));
			//trace("swfHandler");
			next();
		}
		private function progressHandler(e:ProgressEvent):void{
		}
		private function ioErrorHandler(e:IOErrorEvent):void{
			///trace("ioErrorHandler");
			isLocked=false;
			next();
		}
	}
}
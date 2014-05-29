package org.lhm.loader
{
	import com.crystalcg.expo.visitexpo.events.VisitEvent;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	public class VisitLoader extends Sprite
	{
		public static const ITEM_LOADED:String="item_loaded";
		public static const PROGRESS:String="progress_loading"
		
		private var sharedPool:Dictionary=new Dictionary();
		private var mainLoader:URLLoader;
		private var needlessLoader:Loader;
		private var sameLoader:SameLoader;
		private var cache:Dictionary;
		private var load_arr:Array=new Array();
		private var del_arr:Array;
		private var nloader_arr:Array=new Array();
		private var child_loader:ChildLoader;
		private var _locked:Boolean=false;
		private var _timer:Timer;
		private var _currentObj:*;
		public function VisitLoader()
		{
			super();
			cache=new Dictionary();
			mainLoader=new URLLoader();
			sameLoader=new SameLoader();
			child_loader=new ChildLoader();
			_timer=new Timer(10);
			mainLoader.dataFormat=URLLoaderDataFormat.BINARY;
			mainLoader.addEventListener(Event.COMPLETE,completeHandler);
			mainLoader.addEventListener(ProgressEvent.PROGRESS,progressHandler);
			mainLoader.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			sameLoader.addEventListener(VisitEvent.NAME,sameHandler);
			
			child_loader.addEventListener(VisitEvent.NAME,citemOverHandler);
			child_loader.addEventListener(ChildLoader.ALL_OVER,callOverHandler);
			
			_timer.addEventListener(TimerEvent.TIMER,enterframeHandler)
			_timer.start();
		}
		public function loadNow(url:String,id:String,sid:String,dis:Number):void{
			//load_arr.push({id:id,url:url,sid:sid});
			var a:*=getMC(String(sid))
			if(a!=null){
				dispatchEvent(new VisitEvent(ITEM_LOADED,a,id));
			}else{
				if(cache[sid]!=null) {
					nloader_arr.push({id:id,sid:sid})
				}else{
					load_arr.push({id:id,url:url,sid:sid,distance:dis});	
				}
			}
			load_arr.sortOn("distance", Array.NUMERIC);
		}
		public function get loaderArr():Array{
			return load_arr;
		}
		public function start():void{
			if(!_locked)
				next();
		}
		public function pause():void{
			_locked=true;
		}
		public function stop():void{
			_locked=true;
			try{
			mainLoader.close();	
			}catch(e:Error){
				
			}
		}
		public function restart():void{
			_locked=false;
			start();
		}
		public function removeObjects(_del_arr:Array):Array{
			del_arr=_del_arr;
			return load_arr=load_arr.filter(removefilterHandler);
		}
		private function removefilterHandler(element:*,index:int,arr:Array):Boolean{
			var b:Boolean=true;
			for(var i:int=0;i<del_arr.length;i++){
				if(element.id==del_arr[i]){
					return false;
				}
			}
			return b;
		}
		public function dispose():void{
			load_arr.length=0;
			nloader_arr.length=0;
			try{
				mainLoader.close();
			}catch(e:Error){
				
			}
			
			sameLoader.dispose();
			clear();
			_locked=false;
		}
		public function clear():void{
			for(var name:* in sharedPool){
				delete sharedPool[name];
			}
			for(var cname:* in cache){
				delete cache[cname];
			}
		}
		private function next():void{
			var a:*=load_arr[0];
			_currentObj=a;
			if(a==null) return;
			_locked=true;
			mainLoader.load(new URLRequest(a.url)); 
		}
		private function completeHandler(e:Event):void{
			//var obj:Object=load_arr[0];
			var obj:Object=_currentObj;
			//if(obj==null) return;
			var bytearr:ByteArray=mainLoader.data as ByteArray;
			cache[obj.sid]=bytearr;
			//mainLoader.readBytes(bytearr,0,mainLoader.bytesAvailable);
			var arr:Array=getSameObject(load_arr,obj.sid);
			sameLoader.loadNow(arr,bytearr);
			sameLoader.start();
			_locked=false;
			next();
			
		}
		private function ioErrorHandler(e:Event):void{
			//throw e;
			_locked=false;
		}
		private function isneedlessLoader(sid:String):Boolean{
			if(cache[sid]){
				return true;
			}else{
				return false;
			}
		}
		private function getSameObject(arr:Array,id:String):Array{
			var same_arr:Array=new Array();
			for(var i:int=0;i<arr.length;i++){
				if(arr[i].sid==id){
					same_arr.push(arr.splice(i,1));
				}
			}
			return same_arr;
		}
		private function sameHandler(e:VisitEvent):void{
			switch(e.command){
				case SameLoader.ITEM_OVER:
					dispatchEvent(new VisitEvent(ITEM_LOADED,e.body,e.vtype));
				break;
				case SameLoader.ALL_OVER:
					
				break;
			}
		}
		private function needlessHandler(e:Event):void{
			dispatchEvent(new VisitEvent(ITEM_LOADED,e.target.loader.content,e.target.loader.name));
		}
		private function progressHandler(e:ProgressEvent):void{
			dispatchEvent(new VisitEvent(PROGRESS,Math.floor(e.bytesLoaded/e.bytesTotal*10000)*.01,_currentObj.id));
		}
		private function enterframeHandler(e:Event):void{
			if(nloader_arr.length!=0){
				var o:*=nloader_arr.pop();
				var loader:Loader=new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,needlessHandler);
				loader.name=o.id;
				loader.loadBytes(cache[o.sid]); 
			}
		}
		public function recycleMC(id:String,mc:*):void{
			var arr:Array=sharedPool[String(id)];
			if(arr==null){
				sharedPool[String(id)]=new Array();
				arr=sharedPool[String(id)];
			}
			if(arr.length<15){
				sharedPool[String(id)].push(mc);
			}
		}
		public function getMC(id:String):*{
			var arr:Array=sharedPool[id];
			var o:*;
			if(arr==null){
				o=null;
			}else{
				if(arr.length>0){
					o=arr.shift();
				}else{
					o=null;
				}
			}
			return o;
		}
		public function loadAssisMC(id:String,arr:Array):void{
			child_loader.load(id,arr);
			child_loader.start();
		}
		private function citemOverHandler(e:VisitEvent):void{
			dispatchEvent(new VisitEvent(e.command,e.body,e.vtype));
						
		}
		private function callOverHandler(e:Event):void{
			dispatchEvent(new VisitEvent(ChildLoader.ALL_OVER));
		}
	}
}
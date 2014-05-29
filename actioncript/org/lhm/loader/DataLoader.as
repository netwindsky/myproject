package org.lhm.loader
{
	import com.crystalcg.expo.visitexpo.events.VisitEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class DataLoader extends Sprite
	{
		private var arr:Array=new Array();
		private var _locked:Boolean=false;
		private var loader:URLLoader;
		private var num:Number=0;
		public function DataLoader()
		{
			super();
			loader=new URLLoader();
			loader.addEventListener(Event.COMPLETE,completeHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR,ioerrorHandler);
		}
		public function load(url:String):void{
			if(arr.indexOf(url)==-1){
				arr.push(url);
			}
		}
		public function start():void{
			num=arr.length;
			if(!_locked){
				next();
			}
			
		}
		public function dispose():void{
			
		}
		public function next():void{
			num--
			if(arr.length>0){
				_locked=true;
				var url:String=arr.pop();
				loader.load(new URLRequest(url));
			}else{
				dispatchEvent(new VisitEvent("loaderover",loader.data))
			}
		}
		private function completeHandler(e:Event):void{
			dispatchEvent(new VisitEvent("loaderover",loader.data))
			_locked=false;
			next();
		}
		private function ioerrorHandler(e:IOErrorEvent):void{
			next();
		}
		
	}
}
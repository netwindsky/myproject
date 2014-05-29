package  org.lhm.loader
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	public class RSLLoader extends EventDispatcher
	{
		private var a:Loader;
		public var data:*;
		public function RSLLoader()
		{
			a=new Loader();
			a.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
			//a.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			//a.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progressHandler);
		}
		public function load(url:String):void{
			a.load(new URLRequest(url),new LoaderContext(false,ApplicationDomain.currentDomain));
		}
		private function completeHandler(event:Event):void{
			data=a.contentLoaderInfo.content;
			this.dispatchEvent(event);
		}
		private function ioErrorHandler(e:IOErrorEvent):void{
			this.dispatchEvent(e);
		}
		private function progressHandler(e:ProgressEvent):void{
			this.dispatchEvent(e);
		}
	}
}
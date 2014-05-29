package org.lifeng.loader.loading.loaders
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	public class ImageLoader extends Loader
	{
		public var id:String;
		public var type:String;
		public var url:String;
		public function ImageLoader()
		{
			super();
			contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
		}
		
		protected function completeHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
}
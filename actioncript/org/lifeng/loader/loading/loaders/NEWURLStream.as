package org.lifeng.loader.loading.loaders
{
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	import org.lifeng.events.CustomEvent;
	import org.lifeng.loader.loading.RequestObject;
	import org.lifeng.loader.loading.unit.LoadedObject;
	
	public class NEWURLStream extends URLStream
	{
		public static const LOAD_OVER:String="Load_Over";
		public static const GET_REQUEST:String="get_request";
		
		public var type:String
		public var url:String;
		public var id:String;
		public function NEWURLStream()
		{
			super();
			addEventListener(Event.COMPLETE,completeHandler);
		}
		public function start():void{
			dispatchEvent(new CustomEvent(GET_REQUEST));
		}
		public function setRequest(req:RequestObject):void{
			load(new URLRequest(req.requesturl));
		}
		protected function completeHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			var byte:ByteArray=new ByteArray();
			this.readBytes(byte,0,this.bytesAvailable);
			
			var obj:LoadedObject=new LoadedObject();
			obj.bytes=byte;
			obj.ID=id;
			obj.type=type;
			obj.url=url;
			dispatchEvent(new CustomEvent(LOAD_OVER,obj));
		}
	}
}
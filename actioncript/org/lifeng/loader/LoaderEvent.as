package org.lifeng.loader
{
	import flash.events.Event;

	public class LoaderEvent extends Event
	{
		public static const SEND_NOTE:String="loader_send_note";
		public static const ITEM_OVER:String="loader_item_over"
		public var command:String;
		public var body:Object;
		public var eventType:String;
		public function LoaderEvent(_com:String,_body:*=null,_type:String=null)
		{
			super(SEND_NOTE);
			command=_com;
			body=_body;
			eventType=_type;
		}
		
	}
}
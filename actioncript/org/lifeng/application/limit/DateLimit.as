package org.lifeng.application.limit
{
	import flash.events.EventDispatcher;

	public class DateLimit extends EventDispatcher
	{
		public function DateLimit()
		{
			
		}
		public function judge():Boolean{
			var data:Date=new Date();
			if(data.fullYear==2012){
				if(data.month==10){
					if(data.date<30){
						return true;
					}
				}
			}
			return false;
		}
	}
}
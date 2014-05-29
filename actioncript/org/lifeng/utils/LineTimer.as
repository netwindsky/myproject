package org.lifeng.utils
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.lifeng.events.CustomEvent;
	
	public class LineTimer extends EventDispatcher
	{
		private var arr:Array;
		private var timer:Timer=new Timer(0,1);
		private var dely:int=0;
		private var prvedely:int=0;
		public static const LINE_TIME_ITEM_OVER:String="line_time_item_over";
		public static const LINE_TIME_OVER:String="line_time_over";
		public function LineTimer(linetimearr:Array)
		{
			arr=linetimearr;
			if(arr){
				for(var i:int=0;i<arr.length;i++){
					arr[i]=arr[i]*1000;
				}
			}
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
		}
		public function start():void{
			if(arr.length>0){
				dely=arr.shift();
				timer.delay=dely;
				timer.start();
				prvedely=dely;
			}
		}
		private function timerHandler(e:TimerEvent):void{
			dispatchEvent(new CustomEvent(LINE_TIME_ITEM_OVER,int(dely*.001)));
			timer.reset();
			if(arr.length>0){
				dely=arr.shift();
				
				timer.delay=dely-prvedely;
				//trace(timer.delay);
				prvedely=dely;
				timer.start();
				
			}else{
				dispatchEvent(new CustomEvent(LINE_TIME_OVER,int(dely*.001)));
			}
		}
	}
}
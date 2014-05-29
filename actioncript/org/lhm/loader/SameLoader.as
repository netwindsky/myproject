package org.lhm.loader
{
	import com.crystalcg.expo.visitexpo.events.VisitEvent;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;

	public class SameLoader extends Sprite
	{
		public static const STACK_MODEL:String="stack";
		public static const QUEUE_MODEL:String="queue";
		public static const ITEM_OVER:String="item_over";
		public static const ALL_OVER:String="all_over";
		
		private var same_arr:Array=new Array();
		private var _lock:Boolean=false;
		private var model:String=QUEUE_MODEL//"stack"//"queue"
		private var count:int=0;
		private var total:int=0;
		public function SameLoader()
		{
			super();
		}
		public function loadNow(arr:Array,bytearr:ByteArray):void{
			if(arr.length==0) return;
			same_arr.push({obj:arr,bytearr:bytearr})
		}
		public function dispose():void{
			same_arr.length=0;
		}
		public function start():void{
			if(!_lock)
			next();	
		}
		public function next():void{
			if(same_arr.length==0) return ;
			var a:Object;
			if(model==STACK_MODEL){
				a=same_arr.pop()
			}else{
				a=same_arr.shift()
			}
			var bytearr:ByteArray=a.bytearr;
			total=a.obj.length;
			for(var i:int=0;i<a.obj.length;i++){
				var loader:Loader=new Loader();
				var id:String=a.obj[i][0].id;
				loader.name=id
				loader.loadBytes(bytearr);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
			} 
		}
		private function completeHandler(e:Event):void{
			//trace("fuck",e.target.loader.name);
			count++;
			if(count==total){
				dispatchEvent(new VisitEvent(ITEM_OVER,e.target.loader.content,e.target.loader.name));
				dispatchEvent(new VisitEvent(ALL_OVER));
				next();
			}else{
				dispatchEvent(new VisitEvent(ITEM_OVER,e.target.loader.content,e.target.loader.name));
			}
			
			
		}
	}
}
package org.lifeng.loader.loading
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	import org.lifeng.events.CustomEvent;
	import org.lifeng.loader.loading.loaders.NEWURLStream;

	public class LoaderManager extends EventDispatcher
	{
		private var array:Array=new Array();
		//private var list:LoaderList;
		public function LoaderManager(num:int)
		{
			for(var i:int=0;i<num;i++){
				var loader:NEWURLStream=new NEWURLStream();
				loader.addEventListener(Event.COMPLETE,completeHandler);
				array.push(loader);
			}
		}
		/*public function setList(_list:LoaderList):void{
			list=_list;
		}*/
		protected function completeHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			var loader:NEWURLStream=event.target as NEWURLStream;
			array.push(loader);
			var bytearr:ByteArray=new ByteArray();
			loader.readBytes(bytearr,0,loader.bytesAvailable);
			bytearr.position=0;
			dispatchEvent(new CustomEvent("LoaderOver",{type:loader.type,bytes:bytearr,loader:loader}));
		}
		public function start():void{
			
		}
		/*private function next():void{
			var obj:LoaderItemObject=list.ShiftElement();
			if(obj!=null){
				
			}else{
				
			}
		}*/
		/*public function getLoader():NEWURLStream{
			
			if(array.length>0){
				return 	array.shift();
			}else{
				return null;
			}
			
		}
		public function getLoaderCount():int{
			return array.length;
		}*/
		
	}
}
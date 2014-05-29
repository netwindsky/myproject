package org.lifeng.loader.loading
{
	import mx.events.Request;

	public class LoaderList
	{
		private var list:Array=new Array();
		//private var max:int=20000;
		//private var min:int=0;
		public function LoaderList()
		{
		}
		public function addElement(obj:RequestObject):void{
			list.push(obj);
		}
		public function addNowElement(obj:RequestObject):void{

			list.unshift(obj);
		}
		public function ShiftElement():RequestObject{
			if(list.length>0){
				return list.shift() as RequestObject;
			}else{
				return null;
			}
		}
		public function clear():void{
			list=new Array();
		}
	}
}
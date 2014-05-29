package org.lifeng.lang
{
	public class ArrayExt
	{
		private var _array:Array
		public function ArrayExt()
		{
			_array=new Array();
		}
		public function removeElement(key:Object,value:Object):void{
			for(var i:int=0;i<_array.length;i++){
				
				//trace(getElementByIndex(i)[key]);
				if(getElementByIndex(i)[key]==value){
					_array.splice(i,1);
				}
			}
		}
		public function addElement(obj:Object):void{
			_array.push(obj);
		}
		public function getElementByIndex(index:int):Object{
			return _array[index];
		}
		public function get length():int{
			return _array.length;
		}
		public function getElementByKeyAndValue(key:Object,value:Object):Object{
			for(var i:int=0;i<_array.length;i++){
				if(getElementByIndex(i)[key]==value){
					return getElementByIndex(i);
				}
			}
			return null;
		}
		public function getIndexByKeyAndValue(key:Object,value:Object):int{
			for(var i:int=0;i<_array.length;i++){
				if(getElementByIndex(i)[key]==value){
					return i;
				}
			}
			return -1;
		}
		public function removeAll():void{
			_array.length=0;
		}
	}
}
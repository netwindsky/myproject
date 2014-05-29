package org.lifeng.string
{
	public class PolishingZORE
	{
		public function PolishingZORE()
		{
		}
		public function polishing(num:Number,count:int):String{
			var i:int=String(num).length;
			var str:String=String(num);
			for(;i<count;i++){
				str="0"+str;
			}
			return str;
		}
		
	}
}
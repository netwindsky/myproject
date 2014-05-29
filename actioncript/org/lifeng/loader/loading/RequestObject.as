package org.lifeng.loader.loading
{
	public class RequestObject
	{
		private var url:String;
		private var type:String;
		private var weight:int;
		private var id:String;
		public function RequestObject(_url:String,_id:String,_type:String=null,_weight:int=0)
		{
			url=_url;
			type=_type;
			id=_id;
			weight=_weight;
		}
		public function get numweight():int{
			return weight;
		}
		public function get requesturl():String{
			return url;
		}
		public function get ID():String{
			
			return id;
		}
		public function toString():String{
			return "[url="+url+",id="+id+",type="+type+",weight="+weight+"]\n";
		}
	}
}
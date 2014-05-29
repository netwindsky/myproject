package org.lifeng.loader
{
	public class LoadObject
	{
		public var id:String="";
		public var name:String="";
		public var path:String="";
		public var type:String="";
		public function LoadObject(_id:String,_path:String,_type:String="stream",_name:String=null){
			id=_id;
			path=_path;
			type=_type;
			name=_name;
		}
		public function toString():String{
			return "[id="+id+" name="+name+", path="+path+", type="+type+"]";
		}

	}
}
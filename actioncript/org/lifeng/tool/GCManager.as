package org.lifeng.tool
{
	import flash.net.LocalConnection;

	public class GCManager
	{
		public function GCManager()
		{
		}
		public static function gc():void{
			try{
				var con1:LocalConnection=new LocalConnection();
				var con2:LocalConnection=new LocalConnection();
				con1.connect("gc");
				con2.connect("gc");
			}catch(e:Error){
				
			}
		}
	}
}
package org.lifeng.db
{
	import com.adobe.protocols.dict.Database;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class DataBaseTableExportXML
	{
		public function DataBaseTableExportXML()
		{
		}
		public static function export(dbpath:String,tablename:String):void{
			var db:DataBaseManager=new DataBaseManager();
			db.openDB(dbpath);
			var arr:Array=db.executeNow("select * from "+tablename);
			var exportxml:String="<data>\n"
			for(var i:int=0;i<arr.length;i++){
				var obj:Object=arr[i];
				var str:String="<team "
				
				for(var key:* in obj){
					//trace(key,obj[key]);
					str+=key+" ='"+obj[key]+"' ";
				}
				str+="/>\n";
				//trace(str);
				exportxml+=str;
			}
			exportxml+="</data>"
			//trace(new XML(exportxml).toString())
			var file:File=new File(File.applicationDirectory.resolvePath(tablename+".xml").nativePath);
			var filestream:FileStream=new FileStream();
			filestream.open(file,FileMode.WRITE);
			filestream.writeMultiByte(exportxml,"utf-8");
			filestream.close();
		}
	}
}
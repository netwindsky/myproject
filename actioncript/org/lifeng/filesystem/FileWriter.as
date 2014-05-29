package org.lifeng.filesystem
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class FileWriter
	{
		public function FileWriter()
		{
		}
		public function writeFile(_file:String,content:String):void{
			var file:File=new File(_file);
			var stream:FileStream=new FileStream();
			
			
			stream.open(file,FileMode.WRITE);
			//FileMode.UPDATE
			trace("writeFile---->>>>",_file,content);
			stream.writeMultiByte(content,"utf-8");
			stream.close();
			//return stream.readMultiByte(stream.bytesAvailable,"utf-8");
		}
		public function writeLn(_file:String,content:String):void{
			var file:File=new File(_file);
			var stream:FileStream=new FileStream();
			stream.open(file,FileMode.APPEND);
			stream.writeMultiByte(content+"\n","utf-8");
			stream.close();
		}
	}
}
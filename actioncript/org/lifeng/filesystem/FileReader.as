package org.lifeng.filesystem
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	
	public class FileReader
	{
		public function FileReader()
		{
		}
		public function readFile(_file:String,bm:String="utf-8"):String{
			var file:File=new File(_file);
			var stream:FileStream=new FileStream();
			stream.open(file,FileMode.READ);
			var string:String=stream.readMultiByte(stream.bytesAvailable,bm);
			
			//stream.readMultiByte(stream.bytesAvailable,File
			stream.close();
			return string;
		}
	}
}
package org.lifeng.image
{
	import com.adobe.images.JPGEncoder;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	public class ImageCreateManager
	{
		
		private var arrlist:Array=new Array();
		private var isWorking:Boolean=false;
		public static const IMAGE_PNG:String="PNG";
		public static const IMAGE_JPG:String="JPG";
		private var currentFile:File;
		
		public function ImageCreateManager()
		{
		}
		public function start():void{
			if(isWorking) return;
			next();
			
		}
		public function add(file:File,type:String=IMAGE_JPG):void{
			arrlist.push(file);
			trace(file.name);
		}
		/*public function add(_bd:BitmapData,_file:File,_type:String=IMAGE_JPG):void{
			arrlist.push({bitmapdata:_bd,type:_type,file:_file});
		}*/
		protected function createScaleImage(file:File):void{
			trace("createImage---->>>>")
			var filep:File=file.parent.resolvePath("small").resolvePath(file.name);
			trace(filep.nativePath)
			if(filep.exists){
				
				isWorking=false;
				next();

				return;
			}
			
			var fs:FileStream=new FileStream();
			var byte:ByteArray=new ByteArray();
			trace(file.name)
			fs.open(file,FileMode.READ);
			fs.readBytes(byte,0,fs.bytesAvailable);
			var loader:Loader=new Loader();
			loader.loadBytes(byte);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,icomH);
		}
		
		protected function icomH(event:Event):void
		{
			// TODO Auto-generated method stub
			
			
			trace("------------>>>loader complete");
			var loader:Loader=event.target.loader;
			//trace(loader.content);

			var bd:BitmapData=Bitmap(loader.content).bitmapData;
			
			
			var bitmapbd:BitmapData=new BitmapData(1024,575);
			var sp:Sprite=new Sprite();
			var bmp:Bitmap=new Bitmap(bd);
			bmp.width=1024;
			bmp.height=575;
			bmp.smoothing=true;
			sp.addChild(bmp);
			bitmapbd.draw(sp);
			bmp.bitmapData.dispose();
			
			
			var filep:File=currentFile.parent.resolvePath("small").resolvePath(currentFile.name);
			//filep.resolvePath("small").resolvePath(currentFile.name);
			
			trace(filep.nativePath)
			var coder:JPGEncoder=new JPGEncoder();
			var byte:ByteArray=coder.encode(bitmapbd);
			byte.position=0;
			var fs:FileStream=new FileStream();
			fs.open(filep,FileMode.WRITE);
			fs.writeBytes(byte,0,byte.length);
			fs.close();
			isWorking=false;
			next();
			
		}
		public function next():void{
			
			trace("--->>next",arrlist.length);
			if(arrlist.length>0){
				isWorking=true;
				var obj:Object=arrlist.shift();
				
				
				var file:File=obj as File;
				
				currentFile=file;
				
				createScaleImage(file);
				
				/*var filep:File=file.parent;
				filep.resolvePath("small").resolvePath(file.name);;
				var coder:JPGEncoder=new JPGEncoder();
				var byte:ByteArray=coder.encode(obj.bitmapdata);
				byte.position=0;
				var fs:FileStream=new FileStream();
				fs.open(filep,FileMode.WRITE);
				fs.writeBytes(byte,0,byte.length);
				fs.close();*/
				
			}else{
				isWorking=false;
			}
		}
	}
}
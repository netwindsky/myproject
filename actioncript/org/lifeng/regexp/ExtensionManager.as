package org.lifeng.regexp
{
	public class ExtensionManager
	{
		
		public static const IMAGE:String="image";
		public static const SWF:String="swf";
		public static const TEXT:String="text";
		public static const DATA:String="data";
		
		private var _url:String;
		public function ExtensionManager(url:String){
			_url=url;
		}
		public function isImage():Boolean{
			var jpgp:RegExp=/.jpg$/i;
			var pngp:RegExp=/.png$/i;
			var gifp:RegExp=/.gif$/i;
			if(jpgp.test(_url)||pngp.test(_url)||gifp.test(_url)){
				return true;
			}else{
				return false;
			}
			
		}
		public function isSwf():Boolean{
			var swfp:RegExp=/.swf$/i;
			if(swfp.test(_url)){
				return true;
			}else{
				return false;
			}
		}
		public function isText():Boolean{
			var txtp:RegExp=/.txt$/i;
			var xmlp:RegExp=/.xml$/i;
			if(txtp.test(_url)||xmlp.test(_url)){
				return true;
			}else{
				return false;
			}
		}
		public function getType():String{
			if(isImage()){
				return IMAGE;
			}else if(isSwf()){
				return SWF;
			}else if(isText()){
				return TEXT;
			}else {
				return DATA;
			}
		}
	}
}
package org.lifeng.image
{
	import flash.utils.ByteArray;
	
	public class JudgeImageType
	{
		public function JudgeImageType()
		{
		}
		public static function isPNG(byte:ByteArray):Boolean{
			if(byte[0]==0x89&&byte[1]==0x50&&byte[2]==0x4e&&byte[3]==0x47){
				return true;
			}else{
				return false;
			}
				
		}
		public static function isBMP(byte:ByteArray):Boolean{
			if(byte[0]==0x42&&byte[1]==0x4d){
				return true;
			}else{
				return false;
			}
			
		}
		public static function isGIF(byte:ByteArray):Boolean{
			if(byte[0]==0x47&&byte[1]==0x49&&byte[2]==0x46&&byte[3]==0x38){
				return true;
			}else{
				return false;
			}	
		}
		public static function isJPG(byte:ByteArray):Boolean{
			if(byte[0]==0xff&&byte[1]==0xd8&&byte[2]==0xff&&byte[3]==0xe0){
				return true;
			}else{
				if(byte[0]==0xff&&byte[1]==0xd8&&byte[2]==0xff&&byte[3]==0xe1){
					return true;
				}else{
					return false;
				}
				
				
			}
		}
		public static function getImageType(byte:ByteArray):String{
			//trace(byte[0].toString(16),byte[1].toString(16),byte[2].toString(16),byte[3].toString(16));
			if(isPNG(byte)){
				return ImageType.PNG;
			}else{
				if(isJPG(byte)){
					return ImageType.JPG;
				}else{
					if(isGIF(byte)){
						return ImageType.GIF
					}else{
						if(isBMP(byte)){
							return ImageType.BMP;
						}else{
							return null;
						}
					}
				}
			}
			
		}

	}
}
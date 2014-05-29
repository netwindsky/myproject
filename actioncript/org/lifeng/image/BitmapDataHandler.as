package org.lifeng.image
{
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;

	public class BitmapDataHandler
	{
		public function BitmapDataHandler()
		{
			
		}
		/*public static function colorTrans(source:BitmapData,ro:Number=0,go:Number=0,bo:Number=0):void{
			var resultColorTransform = new ColorTransform();
			resultColorTransform.redOffset = ro;
			resultColorTransform.greenOffset = go;
			resultColorTransform.blueOffset = bo;
			sourceBitmap=new Bitmap(source);
			var sp=new Sprite();
			sp.addChild(sourceBitmap);
			var sp2=new Sprite();
			sp2.addChild(sp);
			sp.transform.colorTransform = resultColorTransform;
			returnBitmapData=new BitmapData(sourceBitmap.width,sourceBitmap.height,true, 0x00FFFFFF);
			returnBitmapData.draw(sp2);
			sp2=null;
			//sp1=null;
			sourceBitmap=null;
			return returnBitmapData;
		}*/
	}
}
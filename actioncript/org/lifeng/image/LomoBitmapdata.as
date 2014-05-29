package org.lifeng.image
{
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class LomoBitmapdata
	{
		private var bitmapdata:BitmapData;
		private var lightBitmapdata:BitmapData;
		public function LomoBitmapdata()
		{
		}
		public function processLomo(bitmapdata:BitmapData):void{
			this.bitmapdata = bitmapdata;
			processSereen();
			lightBitmapdata = bitmapdata.clone();
			processInvert();
			processRedAdd();
			drawShape();
		}
		private function processPixel(fun:Function):void{
			for(var i:int=0;i<bitmapdata.width;i++){
				for(var j:int=0;j<bitmapdata.height;j++){
					fun(i,j);
				}
			}
		}
		private function processSereen():void{
			processPixel(sereenBitmaps);
		}
		private function sereenBitmaps(i:int,j:int):void{
			var color32:uint = bitmapdata.getPixel(i,j);
			var red:int = color32 >> 16;
			var green:int = color32 >> 8 & 0xFF;
			var blue:int = color32 & 0xFF;
					
			var redInt:int = screenBase(red,red);
			var greenInt:int = screenBase(green,green);
			var blueInt:int = screenBase(blue,blue);
					
			var newUint:uint = redInt << 16 | greenInt << 8 | blueInt;
			bitmapdata.setPixel(i,j,newUint);
		}
		private function screenBase(topPixel:int, bottomPixel:int):int {
			return (255 - ((255 - topPixel) * (255 - bottomPixel))/255);
		}
		private function processInvert():void{
			bitmapdata.colorTransform(new Rectangle(0,0,bitmapdata.width,bitmapdata.height),new ColorTransform(-1,-1,-1,1,255,255,255,1));
		}
		private function processRedAdd():void{
			processPixel(redadd);
		}
		private function redadd(i:int,j:int):void{
			var top:uint = bitmapdata.getPixel(i,j);
			var bottom:uint = lightBitmapdata.getPixel(i,j);
			
			var red:int = top >> 16;
			var green:int = top >> 8 & 0xFF;
			var blue:int = top & 0xFF;
			
			var redbottom:int = bottom >> 16;
			var greenbottom:int = bottom >> 8 & 0xFF;
			var bluebottom:int = bottom & 0xFF;
			
			var resultR:int = redbottom;
			var resultG:int = greenbottom;
			var resultB:int = blue*0.2 + bluebottom*0.8;
			
			var newUint:uint = resultR << 16 | resultG << 8 | resultB;
			bitmapdata.setPixel(i,j,newUint);
		}
		private function drawShape():void{
			var shape:Shape = new Shape;
			var g:Graphics = shape.graphics;
			var fillType:String = GradientType.RADIAL;
			var colors:Array = [0x000000, 0x000000];
			var alphas:Array = [0, 0.3];
			var ratios:Array = [200,255];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(bitmapdata.width+100, bitmapdata.height+100, 0, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
			g.beginGradientFill(fillType, colors, alphas, ratios,matr);  
			g.drawRect(0,0,bitmapdata.width+160,bitmapdata.height+160);
			matr = new Matrix();
			matr.tx = -50;
			matr.ty = -50;
			bitmapdata.draw(shape,matr);
		}
	}
}
package org.lifeng.image
{
	import flash.display.BitmapData;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Point;
	

	public class FilterFactory
	{
		//浮雕效果
		public static const CONVOLUTION:String="ConvolutionFilter";
		//底片
		public static const INVERT:String="invert";
		//去色
		public static const GRAY:String="gray";
		public static function getFilter(str:String):Array{
			var arr:Array;
			switch(str){
				case CONVOLUTION:
					//arr=[new ConvolutionFilter(3,3,[-10,-1,0,-1,1,1,0,1,10])]
					/*
					var matrix:Array = [ Math.cos(radian+pi4)*256,Math.cos(radian+2*pi4)*256,Math.cos(radian+3*pi4)*256,
						Math.cos(radian)*256,0,Math.cos(radian+4*pi4)*256,
						Math.cos(radian-pi4)*256,Math.cos(radian-2*pi4)*256,Math.cos(radian-3*pi4)*256 ];
					var filter:ConvolutionFilter = new ConvolutionFilter(3, 3, matrix, matrix.length, bias, preserveAlpha, clamp, clampColor, clampAlpha);
					arr=[filter];*/
					break;
				case GRAY:
					/*var colorArray:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0];
					colorArray[0] = (1-0)*0.3086+0;
					colorArray[1] = (1-0)*0.6094;
					colorArray[2] = (1-0)*0.0820;
					
					colorArray[5] = (1-0)*0.3086;
					colorArray[6] = (1-0)*0.6094+0;
					colorArray[7] = (1-0)*0.0820;
					
					colorArray[10] = (1-0)*0.3086;
					colorArray[11] = (1-0)*0.6094;
					colorArray[12] = (1-0)*0.0820+0;
					
					colorArray[18] = 1;
 
					arr=[new ColorMatrixFilter(colorArray)];*/
					
					var myElements_array:Array = [0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
					var myColorMatrix_filter:ColorMatrixFilter = new ColorMatrixFilter(myElements_array);
					return [myColorMatrix_filter];
					break;
				case INVERT:
					
					break;
			}
			return arr;
		}
		public static function getBrightnessFilter(brightness:Number):Array{
			//var brightness:Number;//取值范围0~5
			var colorArray:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0];
			colorArray[0] = brightness;
			colorArray[6] = brightness;
			colorArray[12] = brightness;
			colorArray[18] = 1;
			return [new ColorMatrixFilter(colorArray)]; 
		}
		public static function getSaturationFilter(saturation:Number):Array{
			var colorArray:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0];
			//var saturation:Number;//取值范围0~3
			colorArray[0] = (1-saturation)*0.3086+saturation;
			colorArray[1] = (1-saturation)*0.6094;
			colorArray[2] = (1-saturation)*0.0820;
			
			colorArray[5] = (1-saturation)*0.3086;
			colorArray[6] = (1-saturation)*0.6094+saturation;
			colorArray[7] = (1-saturation)*0.0820;
			
			colorArray[10] = (1-saturation)*0.3086;
			colorArray[11] = (1-saturation)*0.6094;
			colorArray[12] = (1-saturation)*0.0820+saturation;
			
			colorArray[18] = 1;
			
			return [new ColorMatrixFilter(colorArray)]; 
		}
		public static function getcontrast(contrast:Number):Array{
			var colorArray:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0];
			//var contrast:Number;//取值范围0~1
			var a:Number = contrast*11;
			var b:Number = 63.5-(contrast*698.5);
			colorArray[0] = a;
			colorArray[4] = b;
			colorArray[6] = a;
			colorArray[9] = b;
			colorArray[12] = a;
			colorArray[14] = b;
			colorArray[18] = 1;
			return [new ColorMatrixFilter(colorArray)];

		}
		/**
		 * 浮雕效果。
		 * 
		 * 
		 * 
		 * */
		public static function getEmbossFilter(angle:uint=315):Array {
			//var angle=315;
			/*var radian:Number=angle*Math.PI/180;
			var pi4:Number=Math.PI/4;
			var clamp:Boolean = false;
			var clampColor:Number = 0xFF0000;
			var clampAlpha:Number = 256;
			var bias:Number = 128;
			var preserveAlpha:Boolean = false;
			var matrix:Array = [ Math.cos(radian+pi4)*256,Math.cos(radian+2*pi4)*256,Math.cos(radian+3*pi4)*256,
				Math.cos(radian)*256,0,Math.cos(radian+4*pi4)*256,
				Math.cos(radian-pi4)*256,Math.cos(radian-2*pi4)*256,Math.cos(radian-3*pi4)*256 ];
			var matrixCols:Number = 3;
			var matrixRows:Number = 3;
			var filter:ConvolutionFilter = new ConvolutionFilter(matrixCols, matrixRows, matrix, matrix.length, bias, preserveAlpha, clamp, clampColor, clampAlpha);
			return getGrayFilter().concat(filter);
			*/
			return [new ConvolutionFilter(3,3,[-10,-1,0,-1,1,1,0,1,10])].concat(getGrayFilter())
		}
		/**
		 * 
		 * 去色
		 * 
		 * */
		public static function getGrayFilter():Array{
			var myElements_array:Array = [0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
			var myColorMatrix_filter:ColorMatrixFilter = new ColorMatrixFilter(myElements_array);
			return [myColorMatrix_filter];
		}
		/**
		 * 普通模糊。
		 * 
		 * */
		/*public static function getBlurFilter(blurX:Number=1,blurY:Number=1,quality:int=BitmapFilterQuality.HIGH):Array {
			
			trace(BitmapFilterQuality.HIGH,BitmapFilterQuality.LOW)
			var filter:BlurFilter=new BlurFilter(blurX, blurY,quality);
			return [filter];
		}*/
		/**
		 * 
		 * 锐化
		 * 
		 * */
		public static function sharpenFilter(sharp:Number=0.7):Array {
			var matrix: Array = [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
			matrix[1] = matrix[3] = matrix[5] = matrix[7] = -sharp;
			matrix[4] = 1 + sharp * 4;
			var filter: ConvolutionFilter = new ConvolutionFilter( 3, 3, matrix );
			return [filter]
		}
		/**
		 * 
		 * 凸起效果
		 * 
		 * */
		/*
		public static function getRaiseFilter(distance:Number=5,angleInDegrees:Number=45,quality:int=BitmapFilterQuality.HIGH):Array {
			//var distance:Number       = 5;
			//var angleInDegrees:Number = 45;
			var highlightColor:Number = 0xCCCCCC;
			var highlightAlpha:Number = 0.8;
			var shadowColor:Number    = 0x808080;
			var shadowAlpha:Number    = 0.8;
			var blurX:Number          = 5;
			var blurY:Number          = 5;
			var strength:Number       = 5;
			//var quality:Number        = BitmapFilterQuality.HIGH;
			var type:String           = BitmapFilterType.INNER;
			var knockout:Boolean      = false;
			var filter: BevelFilter =new BevelFilter(distance,
				angleInDegrees,
				highlightColor,
				highlightAlpha,
				shadowColor,
				shadowAlpha,
				blurX,
				blurY,
				strength,
				quality,
				type,
				knockout);
			return [filter];
		}*/
		
		/**
		 * 
		 * 老照片效果
		 * 
		 * */
		
		public static function getOldPictureFilter():Array {
			var matrix:Array = new Array();
			matrix = matrix.concat([0.94, 0, 0, 0, 0]);
			matrix = matrix.concat([0, 0.9, 0, 0, 0]);
			matrix = matrix.concat([0, 0, 0.8, 0, 0]);
			matrix = matrix.concat([0, 0, 0, 0.8, 0]);
			var filter:ColorMatrixFilter= new ColorMatrixFilter(matrix);
			return getGrayFilter().concat(filter)
			return returnBitmapData;
		}
		/**
		 * 
		 * 噪点效果
		 * 
		 * */
		/*public static function noiseFilter(degree:Number=128) {
			//degree 0-255
			var noise,color,r,g,b;
			returnBitmapData=source.clone();
			for (var i=0; i<source.height; i++) {
				for (var j=0; j<source.width; j++) {
					noise=int(Math.random()*degree*2)-degree;
					color=source.getPixel(j, i);
					r = (color & 0xff0000) >> 16;
					g = (color & 0x00ff00) >> 8;
					b = color & 0x0000ff;
					r=r+noise<0?0:r+noise>255?255:r+noise;
					g=g+noise<0?0:g+noise>255?255:g+noise;
					b=b+noise<0?0:b+noise>255?255:b+noise;
					returnBitmapData.setPixel(j,i,r*65536+g*256+b);
				}
			}
			return returnBitmapData;
		}*/
		
		/**
		 * 
		 * 
		 * 水波效果
		 * 
		 * */
		public static function getWaterColorFilter(source:BitmapData,scaleX:Number=5,scaleY:Number=5):Array {
			var componentX:Number = 1;
			var componentY:Number = 1;
			var color:Number = 0x000000;
			var alpha:Number = 0x000000;
			var tempBitmap:BitmapData=new BitmapData(source.width,source.height,true,0x00FFFFFF);
			tempBitmap.perlinNoise(3, 3, 1, 1, true, true, 1, false);
			var filter:DisplacementMapFilter = new DisplacementMapFilter(tempBitmap, new Point(0, 0),componentX, componentY, scaleX, scaleY, DisplacementMapFilterMode.COLOR, color, alpha);
			return [filter];
		}
		/**
		 * 
		 * 溶解效果
		 * 
		 * */
		public static function getDiffuseFilter(source:BitmapData,scaleX:Number=5,scaleY:Number=5):Array {
			var componentX:Number = 1;
			var componentY:Number = 1;
			var color:Number = 0x000000;
			var alpha:Number = 0x000000;
			var tempBitmap:BitmapData=new BitmapData(source.width,source.height,true,0x00FFFFFF);
			tempBitmap.noise(888888);
			var filter:DisplacementMapFilter = new DisplacementMapFilter(tempBitmap, new Point(0, 0),componentX, componentY, scaleX, scaleY, DisplacementMapFilterMode.COLOR, color, alpha);
			return [filter];
		}
		
		public static function getSaturationFilterA(source:BitmapData,rp:Number=1,gp:Number=1,bp:Number=1):Array {
			var matrix:Array = new Array();
			matrix = matrix.concat([rp, 0, 0, 0, 0]);// red
			matrix = matrix.concat([0, gp, 0, 0, 0]);// green
			matrix = matrix.concat([0, 0, bp, 0, 0]);// blue
			matrix = matrix.concat([0, 0, 0, 1, 0]);// alpha
			var filter:BitmapFilter = new ColorMatrixFilter(matrix);
			return [filter];
		}
	}
}
package org.lifeng.image
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	public class BitmapFactory
	{
		public function BitmapFactory(bd:BitmapData)
		{
		}
		/**
		 * 
		 * 获取X方向旋转的bitmadata；
		 * 
		 * */
		public static function getXScaleBitmapData(bd:BitmapData):BitmapData{
			var planeBitmapData:BitmapData = new BitmapData( bd.width, bd.height,true,0);
			var planeMatrix : Matrix = new Matrix(-1, 0, 0, 1, bd.width, 0 );
			planeBitmapData.draw( bd, planeMatrix,null,null,null,true ); 
			return planeBitmapData;
		}
		/*
		
		
		*/
		public static function getBitmapDataByRectangle(bd:BitmapData,rect:Rectangle):BitmapData{
			var bitmapbd:BitmapData=new BitmapData(rect.width,rect.height);
			var bytes:ByteArray=bd.getPixels(rect);
			bytes.position=0;
			bitmapbd.setPixels(new Rectangle(0,0,rect.width,rect.height),bytes);
			return bitmapbd;
		}
		
		/**
		 * 
		 * 获取缩放以后的Bitmapdata
		 * 
		 * 
		 * */
		public static function getBitmapDataByScale(bd:BitmapData,xscale:Number,yscale:Number):BitmapData{
			var bitmapbd:BitmapData=new BitmapData(bd.width*xscale,bd.height*yscale);
			var sp:Sprite=new Sprite();
			var bmp:Bitmap=new Bitmap(bd);
			bmp.smoothing=true;
			bmp.scaleX=xscale;
			bmp.scaleY=yscale;
			sp.addChild(bmp);
			bitmapbd.draw(sp);
			bmp.bitmapData.dispose();
			
			
			return bitmapbd;
		}

		/**
		 * 
		 * 
		 * 获取Y方向旋转的bitmapdata；
		 * 
		 * 
		 * */
		public static function getYScaleBitmapData(bd:BitmapData):BitmapData{
			var planeBitmapData:BitmapData = new BitmapData( bd.width, bd.height,true,0);
			var planeMatrix : Matrix = new Matrix(1, 0, 0, -1, 0, bd.height ); //new Matrix(-1, 0, 0, 1, bd.width, 0 );
			planeBitmapData.draw( bd, planeMatrix,null,null,null,true ); 
			return planeBitmapData;
		}
		/**
		 * 
		 * 获取底片效果Bitmapdata；
		 * 
		 * 
		 * */
		public static function getInvertBitmapData(source:BitmapData):BitmapData{
			var sourceBitmap:Bitmap=new Bitmap(source);
			var tempMovieClip:Sprite=new Sprite();
			tempMovieClip.addChild(sourceBitmap);
			//--------------------------------------
			var mytmpmc:Sprite=new Sprite();
			mytmpmc.graphics.lineStyle(0,0x000000, 100);
			mytmpmc.graphics.moveTo(0,0);
			mytmpmc.graphics.beginFill(0x000000);
			mytmpmc.graphics.lineTo(sourceBitmap.width, 0);
			mytmpmc.graphics.lineTo(sourceBitmap.width, sourceBitmap.height);
			mytmpmc.graphics.lineTo(0, sourceBitmap.height);
			mytmpmc.graphics.lineTo(0,0);
			mytmpmc.graphics.endFill();
			mytmpmc.blendMode = BlendMode.INVERT;
			tempMovieClip.addChild(mytmpmc);
			//--------------------------------------
			var returnBitmapData:BitmapData=new BitmapData(tempMovieClip.width,tempMovieClip.height,true, 0x00FFFFFF);
			returnBitmapData.draw(tempMovieClip);
			return returnBitmapData;
		}
		/**
		 * 
		 * 获取杂点效果。
		 * 
		 * */
		public static function getNoiseBitmapdata(source:BitmapData,degree:Number=128):BitmapData{
			var noise:Number,color:Number,r:Number,g:Number,b:Number;
			var bd:BitmapData=source.clone();
			for (var i:int=0; i<source.height; i++) {
				for (var j:int=0; j<source.width; j++) {
					noise=int(Math.random()*degree*2)-degree;
					color=source.getPixel(j, i);
					r = (color & 0xff0000) >> 16;
					g = (color & 0x00ff00) >> 8;
					b = color & 0x0000ff;
					r=r+noise<0?0:r+noise>255?255:r+noise;
					g=g+noise<0?0:g+noise>255?255:g+noise;
					b=b+noise<0?0:b+noise>255?255:b+noise;
					bd.setPixel(j,i,r*65536+g*256+b);
				}
			}
			return bd;
		}
		/**
		 * 
		 * 获取素描效果。
		 * 
		 * */
		public static function getSketchBitmapdata(source:BitmapData,threshold:Number=30):BitmapData{
			//threshold 0-100
			var filter:Array=FilterFactory.getGrayFilter();
			var sourceBitmap:Bitmap=new Bitmap(source);
			sourceBitmap.filters=filter
			var bd:BitmapData=new BitmapData(sourceBitmap.width,sourceBitmap.height,true, 0x00FFFFFF);
			bd.draw(sourceBitmap);
			var color:int,gray1:int,gray2:Number;
			for (var i:int=0; i<source.height-1; i++) {
				for (var j:int=0; j<source.width-1; j++) {
					color=source.getPixel(j, i);
					gray1 = (color & 0xff0000) >> 16;
					color=source.getPixel(j+1, i+1);
					gray2 = (color & 0xff0000) >> 16;
					if (Math.abs(gray1-gray2)>=threshold) {
						bd.setPixel(j,i,0x222222);
					} else {
						bd.setPixel(j,i,0xFFFFFF);
					}
				}
			}
			for (i=0; i<source.height; i++) {
				bd.setPixel(source.width-1,i,0xFFFFFF);
			}
			for (i=0; i<source.width; i++) {
				bd.setPixel(i,source.height-1,0xFFFFFF);
			}
			return bd;
		}
		/**
		 * 
		 * 
		 * 球型扭曲效果bitmapdata
		 * 
		 * */
		public static function getSpherizeBitmapdata(source:BitmapData):BitmapData{
			var midx:int=int(source.width/2);
			var midy:int=int(source.height/2);
			var maxmidxy:int=midx>midy?midx:midy;
			var radian:Number,radius:Number,offsetX:Number,offsetY:Number,color:Number,r:Number,g:Number,b:Number;
			var bd:BitmapData=source.clone();
			for (var i:int=0; i<source.height-1; i++) {
				for (var j:int=0; j<source.width-1; j++) {
					
					offsetX=j-midx;
					offsetY=i-midy;
					radian=Math.atan2(offsetY,offsetX);
					radius=(offsetX*offsetX+offsetY*offsetY)/maxmidxy;
					var x:int=int(radius*Math.cos(radian))+midx;
					var y:int=int(radius*Math.sin(radian))+midy;
					if (x<0) {
						x=0;
					}
					if (x>=source.width) {
						x=source.width-1;
					}
					if (y<0) {
						y=0;
					}
					if (y>=source.height) {
						y=source.height-1;
					}
					color=source.getPixel(x, y);
					r = (color & 0xff0000) >> 16;
					g = (color & 0x00ff00) >> 8;
					b = color & 0x0000ff;
					bd.setPixel(j,i,r*65536+g*256+b);
					
				}
			}
			return bd;
		}
		
		public static function getPinchBitmapdata(source:BitmapData,degree:Number=16):BitmapData{
			var midx:int=int(source.width/2);
			var midy:int=int(source.height/2);
			var radian:Number,radius:Number,offsetX:Number,offsetY:Number,color:Number,r:Number,g:Number,b:Number;
			var bd:BitmapData=source.clone();
			for (var i:int=0; i<source.height-1; i++) {
				for (var j:int=0; j<source.width-1; j++) {
					offsetX=j-midx;
					offsetY=i-midy;
					radian=Math.atan2(offsetY,offsetX);
					radius=Math.sqrt(offsetX*offsetX+offsetY*offsetY);
					radius=Math.sqrt(radius)*degree;
					var x:int=int(radius*Math.cos(radian))+midx;
					var y:int=int(radius*Math.sin(radian))+midy;
					if (x<0) {
						x=0;
					}
					if (x>=source.width) {
						x=source.width-1;
					}
					if (y<0) {
						y=0;
					}
					if (y>=source.height) {
						y=source.height-1;
					}
					color=source.getPixel(x, y);
					r = (color & 0xff0000) >> 16;
					g = (color & 0x00ff00) >> 8;
					b = color & 0x0000ff;
					bd.setPixel(j,i,r*65536+g*256+b);
				}
			}
			return bd;
		}
		/**
		 * 
		 * 
		 * 灯光效果。
		 * 
		 * */
		public static function getLightingBitmapdata(source:BitmapData,power:Number=128,posx:Number=0.5,posy:Number=0.5,r:Number=0):BitmapData{
			//power 0-255
			var midx:Number=int(source.width*posx);
			var midy:Number=int(source.height*posy);
			if (r==0) {
				r=Math.sqrt(midx*midx+midy*midy);
			}
			if (r==0) {
				r=Math.sqrt(source.width*source.width/4+source.height*source.height/4);
			}
			var radius:int=int(r);
			var sr:Number=r*r;
			var bd:BitmapData=source.clone();
			var sd:Number,color:Number,r:Number,g:Number,b:Number,distance:Number,brightness:Number;
			for (var y:int=0; y<source.height; y++) {
				for (var x:int=0; x < source.width; x++) {
					sd=(x-midx)*(x-midx)+(y-midy)*(y-midy);
					if (sd<sr) {
						color=source.getPixel(x, y);
						r = (color & 0xff0000) >> 16;
						g = (color & 0x00ff00) >> 8;
						b = color & 0x0000ff;
						distance=Math.sqrt(sd);
						brightness=int(power*(radius-distance)/radius);
						r=r+brightness>255?255:r+brightness;
						g=g+brightness>255?255:g+brightness;
						b=b+brightness>255?255:b+brightness;
						bd.setPixel(x,y,r*65536+g*256+b);
					}
				}
			}
			return bd;
		}
		/**
		 * 
		 * 马赛克效果。
		 * 
		 * */
		public static function getMosaicBitmapdata(source:BitmapData,block:Number=6):BitmapData{
			//block 1-32
			var bd:BitmapData=source.clone();
			var sumr:Number,sumg:Number,sumb:Number,product:Number,color:Number,r:Number,g:Number,b:Number,br:Number,bg:Number,bb:Number;
			for (var y:int=0; y<source.height; y+=block) {
				for (var x:int=0; x < source.width; x+=block) {
					sumr=0;
					sumg=0;
					sumb=0;
					product=0;
					for (var j:int=0; j<block; j++) {
						for (var i:int=0; i<block; i++) {
							if (x+i<source.width&&y+j<source.height) {
								color=source.getPixel(x+i, y+j);
								r = (color & 0xff0000) >> 16;
								g = (color & 0x00ff00) >> 8;
								b = color & 0x0000ff;
								sumr+=r;
								sumg+=g;
								sumb+=b;
								product++;
							}
						}
					}
					br=int(sumr/product);
					bg=int(sumg/product);
					bb=int(sumb/product);
					for (j=0; j<block; j++) {
						for (i=0; i<block; i++) {
							if (x+i<source.width&&y+j<source.height) {
								bd.setPixel(x+i, y+j,br * 65536 + bg * 256 + bb);
							}
						}
					}
				}
			}
			return bd;
		}
		/**
		 * 
		 * 
		 * 水彩效果。
		 * 
		 * */
		public static function getOilPaintingBitmapdata(source:BitmapData,brushSize:Number=1,coarseness:Number=32):BitmapData{
			//brushSize 1-8
			//coarseness 1-255
			var color:Number,gray:Number,r:Number,g:Number,b:Number,a:Number;
			var arraylen:Number=coarseness+1;
			var CountIntensity:Array=new Array();
			var RedAverage:Array=new Array();
			var GreenAverage:Array=new Array();
			var BlueAverage:Array=new Array();
			var AlphaAverage:Array=new Array();
			
			var filter:Array=FilterFactory.getGrayFilter();
			var sourceBitmap:Bitmap=new Bitmap(source);
			sourceBitmap.filters=filter;
			var tempData:BitmapData;
			tempData=new BitmapData(sourceBitmap.width,sourceBitmap.height,true, 0x00FFFFFF);
			tempData.draw(sourceBitmap);
			var bd:BitmapData=tempData.clone();
			var top:Number,bottom:Number,left:Number,right:Number;
			
			for (var y:int=0; y<source.height; y++) {
				top=y-brushSize;
				bottom=y+brushSize+1;
				if (top<0) {
					top=0;
				}
				if (bottom>=source.height) {
					bottom=source.height-1;
				}
				for (var x:int=0; x<source.width; x++) {
					left=x-brushSize;
					right=x+brushSize+1;
					if (left<0) {
						left=0;
					}
					if (right>=source.width) {
						right=source.width;
					}
					for (var i:int=0; i<arraylen; i++) {
						CountIntensity[i]=0;
						RedAverage[i]=0;
						GreenAverage[i]=0;
						BlueAverage[i]=0;
						AlphaAverage[i]=0;
					}
					for (var j:int=top; j<bottom; j++) {
						for (i=left; i<right; i++) {
							color=tempData.getPixel(i, j);
							gray = (color & 0xff0000) >> 16;
							color=source.getPixel32(i, j);
							a = color >> 24 & 0xFF;
							r = color >> 16 & 0xFF;
							g = color >> 8 & 0xFF;
							b = color & 0xFF;
							var intensity:int=int(coarseness*gray/255);
							CountIntensity[intensity]++;
							RedAverage[intensity]+=r;
							GreenAverage[intensity]+=g;
							BlueAverage[intensity]+=b;
							AlphaAverage[intensity]+=a;
						}
					}
					var closenIntensity:int=0;
					var maxInstance:Number=CountIntensity[0];
					for (i=1; i<arraylen; i++) {
						if (CountIntensity[i]>maxInstance) {
							closenIntensity=i;
							maxInstance=CountIntensity[i];
						}
					}
					a=int(AlphaAverage[closenIntensity]/maxInstance);
					r=int(RedAverage[closenIntensity]/maxInstance);
					g=int(GreenAverage[closenIntensity]/maxInstance);
					b=int(BlueAverage[closenIntensity]/maxInstance);
					bd.setPixel32(x,y,a*16777216+r*65536+g*256+b);
				}
			}
			return bd;
		}
		/**
		 * 
		 * 
		 * 
		 * 黑白效果
		 * 
		 * */
		public static function getThresholdBitmapdata(source:BitmapData,threshold:uint=128):BitmapData{
			var bd:BitmapData = new BitmapData(source.width, source.height,true,0xFF000000);
			var pt:Point = new Point(0, 0);
			var rect:Rectangle = new Rectangle(0, 0,source.width,source.height);
			threshold=threshold<0?0:threshold>255?255:threshold;
			var thre:uint =  255*0xFFFFFF+threshold*0xFFFF+threshold*0xFF+threshold;
			var color:uint = 0x00FFFFFF;
			var maskColor:uint = 0xFFFFFFFF;
			bd.threshold(source, rect, pt, ">", thre, color, maskColor, false);
			return bd;
		}
		public static function getReflection(target:DisplayObject,height:Number = -1):BitmapData{         
			if(height<0)height = target.height*.4       
			var bit:BitmapData = new BitmapData(target.width,height,true,0);         
			bit.draw(target,new Matrix(1,0,0,-1,0,target.height));                         
			var mtx:Matrix = new Matrix();         
			mtx.createGradientBox(target.width,height,0.5 * Math.PI);         
			var shape:Shape = new Shape();         
			shape.graphics.beginGradientFill(GradientType.LINEAR,[0,0],[0.5,0],[0,255],mtx)         
			shape.graphics.drawRect(0,0,target.width,height);         
			shape.graphics.endFill();                        
			var alpha:BitmapData = new BitmapData(target.width,height,true,0);         
			alpha.draw(shape);         
			bit.copyPixels(bit,bit.rect,new Point(0,0),alpha,new Point(0,0),false);         
			return bit.clone()
		}
		
		//应用一例 
		//var reflection:Bitmap = new Bitmap(getReflection(target,100)); reflection.x = target.x; reflection.y = target.y + target.height; addChild(reflection); 
	}
}
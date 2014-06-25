package org.lifeng.image
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	
	public class DisplayShadow extends Sprite
	{
		private var _displayer:DisplayObject;
		private var _x:int=0;
		private var _y:int=0;
		private var _width:int=0;
		private var _height:int=0;
		private var bmp:Bitmap;
		private var bd:BitmapData;
		private var timer:Timer=new Timer(40);
		public function DisplayShadow()
		{
			super();
			timer.addEventListener(TimerEvent.TIMER,renderHandler);
		}
		
		protected function renderHandler(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			var _bmp:Bitmap=getBitmap();
			var _bd:BitmapData=getBitmapData();
			_bd.draw(_displayer,new Matrix(1,0,0,1,-_x,-_y));
			//trace(_bd.compare(_bmp.bitmapData));
			/*var nnbd:BitmapData;
			if(_bmp.bitmapData!=null){
				trace(_bd.compare(_bmp.bitmapData));
			}*/
			_bmp.bitmapData=_bd;
			_bmp.smoothing=true;
			addChild(_bmp);
			
			//trace(_bd);
			
		}
		private function getBitmapData():BitmapData{
			//trace(_width,_height);
			if(bd==null){
				bd=new BitmapData(_width,_height,true,0);
			}
			return bd;
		}
		private function getBitmap():Bitmap{
			if(bmp==null){
				bmp=new Bitmap();
				bmp.bitmapData=new BitmapData(_width,_height,true,0);
			}
			return bmp;
		}
		public function setDisplayerSource(displayer:DisplayObject):void{
			_displayer=displayer;
		}
		public function start():void{
			
			if(_displayer){
				timer.start();
			}else{
				throw(new Error("请调用setDisplayerSource"));
			}
		}
		public function setXY(x:int,y:int):void{
			_x=x;
			_y=y;
		}
		
		public function setSize(_w:int,_h:int):void{
			_width=_w;
			_height=_h;
		}
		
		public function stop():void{
			timer.stop();
		}
	}
}
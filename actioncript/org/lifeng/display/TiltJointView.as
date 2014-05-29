package org.lifeng.display
{
	import com.crystalcg.ncity.events.CustomEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import org.lifeng.loader.*;
	
	
	/**
	 * 1、动态加载裁切好的图片进行拼接。
	 * 2、给定原始图片尺寸。
	 * 3、给定显示尺寸。
	 * 3、给定显示中心（再原始图上的坐标）。
	 * 4、给定显示矩形。
	 * 5、图片命名格式。i0__X_Y.jpg
	 * 
	 */
	public class TiltJointView extends Sprite
	{
		
		
		private var _viewRect:Rectangle;
		private var _width:int;
		private var _height:int;
		private var _centerx:int;
		private var _contery:int;
		private var _imagefolderpath:String;
		private var _imageName:String="i0";
		private var _tiltwidth:int;
		private var _tiltheight:int;
		private var _ndwloader:NWDLoader=new NWDLoader();
		
		///---------------------------------------------------------
		private var image_tilt_rect_Arrs:Array=new Array();
		private var mapcontainer:Sprite=new Sprite();
		private var imagecontainerArray:Array=new Array();
		private var isdown:Boolean=false
		public function TiltJointView()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE,addtostage);
		}
		public function init():void{
			//this.graphics.lineStyle(1,0xff0000);
			//this.graphics.beginFill(0x0066ff);
			//this.graphics.drawRect(0,0,_viewRect.width,_viewRect.height);
			//this.graphics.endFill();
			//------------------------------------------------------
			image_tilt_rect_Arrs=getTiltRects();
			
			_ndwloader.addEventListener(LoaderEvent.SEND_NOTE,handler);
			
			
			addChild(mapcontainer);
			
			
			
			
			
			//mapcontainer.scaleX=mapcontainer.scaleY=.1;
		}
		private function addtostage(e:Event):void{
			this.addEventListener(MouseEvent.MOUSE_DOWN,downH);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,moveH);
			stage.addEventListener(MouseEvent.MOUSE_UP,upH);
		}
		private function downH(e:MouseEvent):void{
			isdown=true;
			this.dispatchEvent(new CustomEvent("mousedown"));
			mapcontainer.startDrag(false,new Rectangle(_viewRect.width-_width,_viewRect.height-_height,_width-_viewRect.width,_height-_viewRect.height));
		}
		private function upH(e:MouseEvent):void{
			if(isdown){
				mapcontainer.stopDrag();
				isdown=false;
			}
			
		}
		private function moveH(e:MouseEvent):void{
			if(isdown){
				//var offsetx:int=this.mouseX-ox;
				//var offsety:int=this.mouseY-oy;
				//var rect:Rectangle=map.getViewRect();
				//rect.x-=offsetx;
				//rect.y-=offsety;
				//map.setViewRect(rect);
				//map.update();
				//ox=this.mouseX;
				//oy=this.mouseY;
				_viewRect.x=-mapcontainer.x;
				_viewRect.y=-mapcontainer.y;
				
				update();
				
				
				
			}
			e.updateAfterEvent();
		}
		public function update():void{
			
			//mapcontainer.x=-_viewRect.x;
			//mapcontainer.y=-_viewRect.y;
			//trace(mapcontainer.x,mapcontainer.y);
			dispatchEvent(new CustomEvent("move",_viewRect));
			parseLoaderObject(getViewTitls());
			
		}
		//----------内部方法------------------------------------
		private function getTiltRects():Array{
			try
			{
				var txnum:int=_width/_tiltwidth+2;
				var tynum:int=_height/_tiltheight+2;
			} 
			catch(error:Error) 
			{
				throw(new Error("请设置瓦片大小或者原始图片大小"))
			}
			var vect:Array=new Array();
			for(var i:int=0;i<txnum;i++){
				for(var j:int=0;j<tynum;j++){
					var rect:Rectangle=new Rectangle(i*_tiltwidth,j*_tiltheight,_tiltwidth,_tiltheight);
					//trace(rect);
					vect.push(rect);
				}
			}
			return vect;
		}
		private function getViewTitls():Array{
			var arr:Array=new Array();
			for(var i:int=0;i<image_tilt_rect_Arrs.length;i++){
				var rect:Rectangle=image_tilt_rect_Arrs[i] as Rectangle;
				if(_viewRect.intersects(rect)){
					arr.push(rect);
				}
			}
			return arr;
		}
		private function parseLoaderObject(array:Array):void{
			for(var i:int=0;i<array.length;i++){
				var rect:Rectangle=array[i] as Rectangle;
				var x:int=rect.x/_tiltwidth;
				var y:int=rect.y/_tiltheight;
				var id:String=x+"_"+y;
				var old:Sprite=mapcontainer.getChildByName(id) as Sprite;
				if(old!=null){
					continue;
				}
				var sprite:Sprite=new Sprite();
				sprite.name=id;
				sprite.x=rect.x;
				sprite.y=rect.y;

				mapcontainer.addChild(sprite);
				var loaderobj:LoadObject=new LoadObject(id,_imagefolderpath+_imageName+"__"+y+"_"+x+".jpg",LoadObjectType.TYPE_IMA,_imageName+"__"+y+"_"+x+".jpg");
				_ndwloader.addElement(loaderobj);
			}
			_ndwloader.start();
		}
		private function hasImage(id:String):Boolean{
			
			var num:int=mapcontainer.numChildren;
			for(var i:int=0;i<num;i++){
				var sprite:Sprite=mapcontainer.getChildAt(i) as Sprite;
				if(sprite.name==id){
					return true;
				}
			}
			return false;
		}
		private function handler(e:LoaderEvent):void{
			
			var image:Bitmap=e.body.data;
			image.smoothing=true;
			//var siteArr:Array=e.eventType.split("_");
			//var x:int=int(siteArr[0])*_tiltwidth;
			//var y:int=int(siteArr[1])*_tiltheight;
			var sprite:Sprite=mapcontainer.getChildByName(e.eventType) as Sprite;
			//trace(sprite.name);
			if(sprite){
				sprite.addChild(image);
			}
			//var sprite:Sprite=new Sprite();
			//sprite.x=x;
			//sprite.y=y;
			//sprite.addChild(image);
			//sprite.name=e.eventType;
			//mapcontainer.addChild(sprite);
			//imagecontainerArray.push(sprite);
		}
		private function FilterLoaded():void{
			for(var i:int=0;i<imagecontainerArray.length;i++){
				var sprite:Sprite=imagecontainerArray[i] as Sprite;
				//var x:int=int(sprite.x/_tiltwidth+.5);
				//var y:int=int(sprite.y/_tiltheight+.5);
				
				var rect:Rectangle=new Rectangle(sprite.x,sprite.y,_tiltwidth,_tiltheight);
				if(!_viewRect.intersects(rect)){
					imagecontainerArray.splice(i,1);
					sprite.parent.removeChild(sprite);
				}
			}
		}
		//----------对外开放接口--------------------------------
		public function setViewRect(rect:Rectangle):void{
			_viewRect=rect;
			trace(_viewRect);
			if(_viewRect.x<0){
				_viewRect.x=0;
			}
			if(_viewRect.y<0){
				_viewRect.y=0;
			}
			if(_viewRect.x>_width-_viewRect.width){
				_viewRect.x=_width-_viewRect.width
			}
			if(_viewRect.y>_height-_viewRect.height){
				_viewRect.y=_height-_viewRect.height
			}
			//trace("-------------->>>",_viewRect);
			
			mapcontainer.x=-_viewRect.x;
			mapcontainer.y=-_viewRect.y;
			dispatchEvent(new CustomEvent("move",_viewRect));
		}
		public function getViewRect():Rectangle{
			return _viewRect;
		}
		public function setMapSize(width:int,height:int):void{
			_width=width;
			_height=height;
			//this.graphics.lineStyle(1,0xff0000);
			mapcontainer.graphics.beginFill(0x0066ff,0);
			mapcontainer.graphics.drawRect(0,0,_width,_height);
			mapcontainer.graphics.endFill();
		}
		public function setViewCenter(x:int,y:int):void{
			
		}
		public function setViewSize(width:int,height:int):void{
			
		}
		public function setImagefolderpath(path:String):void{
			_imagefolderpath=path;
		}
		public function setImagename(name:String):void{
			_imageName=name;
		}
		public function setTiltSize(width:int,height:int):void{
			_tiltwidth=width;
			_tiltheight=height;
		}
	}
}
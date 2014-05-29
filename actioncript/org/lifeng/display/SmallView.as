package org.lifeng.display
{
	import com.crystalcg.ncity.events.CustomEvent;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class SmallView extends Sprite
	{
		private var _bwidth:int=0;
		private var _bheight:int=0;
		private var _width:int=0;
		private var _height:int=0;
		private var _scale:Number=1;
		private var _rect:Rectangle;
		private var window:Sprite=new Sprite();
		private var _bg:UIMapmodel=new UIMapmodel();
		private var _bmp:Bitmap;
		private var _isopen:Boolean=true;
		public function SmallView()
		{
			super();
			addChild(_bg);
			
			_bmp=new Bitmap(new UISmallImage);
			
			//_bmp.x=-100;
			//window.mouseChildren=false;
			//window.mouseEnabled=false;
			addChild(window);
			var sp:Sprite=new Sprite();
			sp.addChild(_bmp);
			addChild(sp);
			_bmp.y=5;
			_bg.mc.addEventListener(MouseEvent.CLICK,closeHandler);
			sp.addEventListener(MouseEvent.CLICK,clickHandler);
		}
		private function closeHandler(e:MouseEvent):void{
			trace("close");
			if(_isopen){
				TweenLite.to(this,.5,{x:-265,onComplete:closeH});
			}else{
				TweenLite.to(this,.5,{x:0,onComplete:openH});
			}
			_isopen=!_isopen;
			
		}
		private function openH():void{
			
			_bg.mc.gotoAndStop(1);
			//_bg.mc.close_btn.addEventListener(MouseEvent.CLICK,closeHandler);
		}
		private function closeH():void{
			//trace(_bg.mc);
			_bg.mc.gotoAndStop(2);
			//_bg.mc.open_btn.addEventListener(MouseEvent.CLICK,closeHandler);
		}
		private function clickHandler(e:MouseEvent):void{
			trace(this.mouseX,this.mouseY);
			//window.x=this.mouseX;
			//window.y=this.mouseY;
			
			dispatchEvent(new CustomEvent("smove",new Rectangle(int(this.mouseX/_scale-512),int(this.mouseY/_scale-384),1024,768)));
		}
		public function setBigViewSize(_w:int,_h:int):void{
			_bwidth=_w;
			_bheight=_h;
		}
		public function setSize(_w:int,_h:int):void{
			_width=_w;
			_height=_h;
		}
		public function setViewRect(_r:Rectangle):void{
			_rect=_r;
			
			
			
			window.x=_rect.x*_scale;
			window.y=_rect.y*_scale;
		}
		public function setXY(_x:int,_y:int):void{
		
			//_rect=_r;
			
			window.x=_x*_scale;
			window.y=_y*_scale;
			
			//update();
			update();
		}
		public function init():void{
			_scale=_width/(_bwidth);
			/*this.graphics.beginFill(0x0066ff,1);
			this.graphics.drawRect(0,0,_width,_height);
			this.graphics.endFill();*/
		}
		public function update():void{
			window.graphics.clear();
			window.graphics.lineStyle(1,0xff0000);
			window.graphics.drawRect(0,0,_rect.width*_scale,_rect.height*_scale);
			window.graphics.endFill();
		}
	}
}
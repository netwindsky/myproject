package org.lifeng.display
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class N3DView extends Sprite
	{
		private var count:int=23;
		private var p:int=0;
		private var loader:Loader=new Loader();
		private var path:String="";
		private var image:Bitmap;
		public function N3DView()
		{
			super();
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
			
		}
		public function init(str:String):void{
			path=str;
			initView();
		}
		public function next():void{
			p++;
			if(p>count-1){
				p=0;
			}
			initView();
		}
		public function prve():void{
			p--;
			if(p<0){
				p=count-1;
			}
			initView();
		}
		private function initView():void{
			//loader.close();
			trace(path+"/"+p+".png");
			/*if(loader!=null){
				if(loader.parent){
					loader.parent.removeChild(loader);
				}
			}*/

			
			loader.load(new URLRequest("images/"+path+"/"+p+".png"));
			//addChild(loader);
		}
		public function clear():void{
			if(loader){
				loader.unloadAndStop(true);
				//var num:int=this.numChildren;
			}
			while(this.numChildren){
				this.removeChildAt(0);
			}
			p=0;
		}
		protected function completeHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("uuuuuu");
			var oldimage:Bitmap;
			if(image!=null){
				oldimage=image;
			}
			image=event.target.loader.content;

			addChild(image);

			if(oldimage){
				if(oldimage.parent){
					oldimage.parent.removeChild(oldimage);
					oldimage.bitmapData.dispose();
				}
			}
		}
	}
}
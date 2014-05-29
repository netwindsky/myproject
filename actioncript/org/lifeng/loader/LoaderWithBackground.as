package org.lifeng.loader
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	public class LoaderWithBackground extends Sprite
	{
		//private var _content:DisplayObject;
		//private var _contentLoaderInfo:LoaderInfo;
		private var loader:Loader=new Loader();
		//public var iswidth:Boolean=false;
		public function LoaderWithBackground()
		{
			super();
			//_contentLoaderInfo=loader.contentLoaderInfo;
			//_content=loader.con
			addChild(loader);
			//loader.visible=false;
			
		}
		public function close():void{
			loader.close();
		}
		public function set iswidth(bool:Boolean):void{
			this.graphics.clear();
			this.graphics.beginFill(0xffffff,1);
			if(bool){
				//trace("HHHHH")
				this.graphics.drawRect(0,0,876,578);
			}else{
				//trace("wocao");
				this.graphics.drawRect(0,0,438,578);
			}
			this.graphics.endFill();
		}
		public function load(request:URLRequest, context:LoaderContext = null):void{

			loader.load(request,context);
		}
		public function loadBytes(bytes:ByteArray, context:LoaderContext = null):void{
			loader.loadBytes(bytes,context);
		}
		public function unload():void{
			loader.unload();
		}
		public function get content():DisplayObject{
			return  loader.content;
		}
		public function get contentLoaderInfo():LoaderInfo{
			return loader.contentLoaderInfo;
		}
	}
}
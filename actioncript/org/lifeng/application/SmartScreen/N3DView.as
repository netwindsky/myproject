package org.lifeng.application.SmartScreen
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.StageWebView;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import org.lifeng.bulkloader.BulkLoader;
	import org.lifeng.filesystem.FileManager;
	
	public class N3DView extends Sprite
	{
		private var count:int=23;
		private var p:int=0;
		private var loader:Loader;//=new Loader();
		private var path:String="";
		private var image:Bitmap;
		private var nativePath:String="";
		//private var bg:BackGroundView=new BackGroundView();
		private var content:Sprite=new Sprite();

		private var isinitover:Boolean=false;
		private var images:Array=new Array();
		private var stime:Number;
		private var cnum:int=0;
		
		//private var ix:int=0;
		//private var iy:int=0;
		
		private var offsetx:int=0;
		private var offsety:int=0;
		
		private var oscale:Number=1;
		private var xxxs:Number=1;
		///private var ys:Number=1;
		private var ipadscale:Number=1;
		
		private var _xw:int=1024;
		private var _yh:int=768;
		//private var _yh:int=288;
		private var _timer:Timer=new Timer(500);
		
		private var imgw:int=0;
		private var imgh:int=0;
		private var imgscale:Number=0;
		public function N3DView(bgpath:String=null)
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE,addtoStage);
			addEventListener(Event.REMOVED_FROM_STAGE,removestage);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			
			/*if(bgpath!=null){
				bg.init(bgpath);
				bg.name="backgound"
			}*/
			//addChild(bg);
			
			addChild(content);

			
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			next();
		}
		
		protected function removestage(event:Event):void
		{
			// TODO Auto-generated method stub
			_timer.stop();
		}
		
		protected function addtoStage(event:Event):void
		{
			// TODO Auto-generated method stub
			stage.addEventListener(Event.RESIZE,resizeH);
			xxxs=this.stage.stageHeight/768;
			
			
		}
		
		protected function resizeH(event:Event):void
		{
			// TODO Auto-generated method stub
			/*if(stage){
				this.x=-(this.width-stage.stageWidth)*.5;
				this.y=-(this.height-stage.stageHeight)*.5;
			}*/

			if(stage&&image){
				var vs:Number=image.width/image.height;
				var ss:Number=this.stage.stageWidth/this.stage.stageHeight;
				//var s:Number=Math.max(vs,ss);
				
				//trace(vs>ss);
				
				if(vs>=ss){
					
					oscale=this.stage.stageWidth/image.width;
					image.width=this.stage.stageWidth;
					image.height=image.width/vs;
					_xw=image.width;
					_yh=image.height;
					image.x=-image.width*.5//(this.stage.stageWidth-_xw)*.5;
					image.y=-image.height*.5//(this.stage.stageHeight-image.height)*.5;
					
				}else{
					oscale=this.stage.height/image.height;
					image.height=this.stage.stageHeight;
					image.width=image.height*vs;
					_xw=image.width;
					_yh=image.height*.5;
					image.y=-image.height*.5;
					image.x=-image.width*.5//(this.stage.stageWidth-image.width)*.5;
					trace(image.x);
				}
			}
			
			
			//content.x=this.stage.stageWidth*.5;
			//content.y=this.stage.stageHeight*.5;
			//ix=-this.stage.stageWidth*.5;
			//iy=-this.stage.stageHeight*.5;
			
			offsetx=this.stage.stageWidth*.5;
			offsety=this.stage.stageHeight*.5;
			//content.x=offsetx;
			//content.y=offsety;
			content.x=this.stage.stageWidth*.5;
			content.y=this.stage.stageHeight*.5;
			
			trace(content.x,content.y)
			//bg.setSize(this.stage.stageWidth,this.stage.stageHeight);
		}
		public function init(str:String):void{
			clear();
			images=[];
			cnum=0;
			isinitover=false;
			path=str;
			
			var filea:File=new File(File.applicationDirectory.nativePath);
			//trace("AAAAAAAAAAA------>>>>",file.parent.parent.resolvePath("assets").resolvePath("n3d").nativePath);
			var hostfile:File=new File(filea.parent.parent.resolvePath("assets").resolvePath("n3d").nativePath);
			
			var file:FileManager=new FileManager();
			

			//trace(File.applicationDirectory.nativePath+"/n3d/"+path+"/");
			///return;
			//var arr:Array=file.getFilesScanFolder(new File(File.applicationDirectory.nativePath+"/n3d/"+path+"/"),["jpg","png"]);
			var arr:Array=file.getFilesScanFolder(hostfile.resolvePath(path),["jpg","png"]);
			
			count=arr.length;
			
			for(var i:int=0;i<count;i++){
				var f:File=new File(hostfile.resolvePath(path).nativePath);
				var ifile:File=f.resolvePath(i+".png");
				
				if(!ifile.exists){
					ifile=f.resolvePath(i+".jpg");
				}
				var stream:FileStream=new FileStream();
				stream.open(ifile,FileMode.READ);
				var byte:ByteArray=new ByteArray();
				stream.readBytes(byte,0,stream.bytesAvailable);
				//bytes.push(byte);
				loader=new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
				loader.loadBytes(byte);
				loader.name=""+i;	
			}
		}
		public function autoplay():void{
			_timer.start();
		}
		public function next():void{
			p++;
			if(p>count-1){
				p=0;
			}
			initView();
		}
		public function scaleNum(scale:Number):void{
			content.scaleX=content.scaleY=scale;
		}
		public function gotoNum(num:int):void{
			/*var file:FileManager=new FileManager();
			
			
			var arr:Array=file.getFilesScanFolder(new File(nativePath+path+"/"),["jpg","png"]);
			
			count=arr.length;
			trace(f.nativePath,count);
			
			*/
/*
			var f:File=new File(nativePath+path+"/");
			var ifile:File=f.resolvePath(num+".png");
			var stream:FileStream=new FileStream();
			stream.open(ifile,FileMode.READ);
			var byte:ByteArray=new ByteArray();
			stream.readBytes(byte,0,stream.bytesAvailable);
			trace("--------------->>",getTimer()-aaa)*/
			p=num;
			//trace(p)
			initView();
			//loader.loadBytes(bytes[num]);
		}
		
		public function prve():void{
			p--;
			if(p<0){
				p=count-1;
			}
			initView();
		}
		public function setPath(str:String):void{
			nativePath=str;
		}
		private function initView():void{
			//loader.close();
			//trace("---------------->>>>>",nativePath+path+"/"+p+".png");
			/*if(loader!=null){
				if(loader.parent){
					loader.parent.removeChild(loader);
				}
			}*/
			if(isinitover){
				
				while(content.numChildren>0){
					content.removeChildAt(0);
				}
				stime=getTimer();
				var bmp:Bitmap=images[p];
				image=bmp;
				content.addChild(bmp);
			}
			
			resizeH(null);

		}
		
		public function clear():void{
			if(loader){
				loader.unloadAndStop(true);
			}
			while(content.numChildren>0){
				content.removeChildAt(0);
			}
			while(images.length>0){
				var bmp:Bitmap=images.pop();
				bmp.bitmapData.dispose();
			}
			p=0;
		}
		public function operate(x:int,y:int,scale:Number):void{
			//trace(x,y,scale,image.scaleX,image.width,image.height  ,imgw,imgh);
			//image.scaleX=image.scaleY=1;
			//trace(x,y,scale,image.width,image.height,_xw);
			
			
			offsetx=x*stage.stageWidth/1024;//xxxs//+(this.stage.stageWidth-_xw)*.5;
			offsety=y*stage.stageWidth/1024;//*xxxs;
			image.x=offsetx;
			image.y=offsety;
			
			
				
			trace(scale,imgscale,y,image.y);
			image.scaleX=image.scaleY=scale*imgscale;
			
		}
		protected function completeHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			var loader:Loader=event.target.loader;
			cnum++;
			image=event.target.loader.content;
			image.smoothing=true;
			images[loader.name]=image;
			
			imgw=image.width;
			imgh=image.height;
			
			
			imgscale=stage.stageWidth/imgw;
			
			trace("BBBBBBBBBB----->>>>",imgw,imgh,imgscale);
			if(cnum==count){
				isinitover=true;
				initView();
			}
			return ;
			/*
			var oldimage:Bitmap;
			if(image!=null){
				oldimage=image;
			}
			image=event.target.loader.content;
			image.smoothing=true;
			content.addChild(image);

			if(oldimage){
				if(oldimage.parent){
					oldimage.parent.removeChild(oldimage);
					oldimage.bitmapData.dispose();
				}
			}*/
			
		}
	}
}
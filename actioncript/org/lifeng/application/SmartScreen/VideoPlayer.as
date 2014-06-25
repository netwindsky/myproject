package org.lifeng.application.SmartScreen
{
	import adobe.utils.CustomActions;
	
	//import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.media.StageVideo;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import org.lifeng.events.CustomEvent;
	import org.lifeng.image.FilterFactory;

	
	public class VideoPlayer extends Sprite
	{
		private var conn:NetConnection
		private var stream:NetStream;
		private var metaListener:Object
		private var video:*;
		private var st:SoundTransform
		
		private var totalLength:uint=0
		private var videowidth:int=0;
		private var videoheight:int=0;
		
		private var brightNum:Number=1;
		private var soundNum:Number=1;
		private var logTimer:Timer=new Timer(60000);
		//private var 
		private var p:int=0;
		private var videoArr:Array;//=new Array();
		private var ispause:Boolean=false;
		//-----------------------------------------------------------
		private var Linesprite:Sprite=new Sprite();
		private var linew:int=1;
		private var lineh:int=1;
		private var isGPU:Boolean=false;
		private var isautoplay:Boolean=true;
		//-----------------------------------------------------------
		
		private var playTimer:Timer=new Timer(1000);
		
		private var videolength:int;
		
		public function VideoPlayer()
		{

			
			logTimer.addEventListener(TimerEvent.TIMER,logTimerHandler);
			MySharedObject.getInstance().initData();
			addEventListener(Event.ADDED_TO_STAGE,addtoStage);
			
			playTimer.addEventListener(TimerEvent.TIMER,playTimerHandler);
		}
		public function playtimerStar():void{
			playTimer.start();
		}
		public function playtimerStop():void{
			playTimer.stop();
		}
		protected function playTimerHandler(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			//trace(stream.time*1000);
			if(videolength>0){
				var dp:int=Math.round((stream.time*1000/videolength)*100);
				//trace("playjd--->>",dp);
				dispatchEvent(new CustomEvent("playprocess",dp));
			}
		}
		private function onStageVideoAvailability(e:Object):void{
			if(e.availability =="available"){
				isGPU=true;
			}
			//MySharedObject.getInstance().sound=10;
			//soundNum=(MySharedObject.getInstance().sound)/100;
			trace("soundnum--->>>",soundNum);	
			this.stage.color=0x000000;
			trace(isGPU)
			if(!isGPU){
				video = new Video();
				video.width = 1024;
				video.height = 512;
				video.smoothing=true;
				addChild(video);
			}else{
				video=stage.stageVideos[0];
				video.viewPort=new Rectangle(0,0,1024,512);
				
			}

			metaListener= new Object();
			metaListener.onMetaData = theMeta;
			
			//video.deblocking=2;
			//init("flvs/1.flv");
			//var loader:URLLoader=new URLLoader();
			//loader.addEventListener(Event.COMPLETE,completeHandler);
			//loader.load(new URLRequest("config.xml"));
			stage.addEventListener(Event.RESIZE,resizeHandler);
			
			addChild(Linesprite);
			
			drawLine();
			
			
			//trace("initover")
			dispatchEvent(new CustomEvent("initover",isGPU));
		}
		private function addtoStage(e:Event):void{

			stage.addEventListener("stageVideoAvailability", onStageVideoAvailability);
			conn= new NetConnection();
			metaListener= new Object();
			metaListener.onMetaData = theMeta;
			
			video = new Video();
			video.width = 1920;
			video.height = 1080;
			video.smoothing=true;
			addChild(video);
		}
		private function drawLine():void{
			Linesprite.graphics.clear();
			Linesprite.graphics.lineStyle(2,0xff0000,1);
			var w:int=this.stage.stageWidth/linew;
			var h:int=this.stage.stageHeight/lineh;
			
			trace("-------------------------------<<>>>",w,h,linew,lineh);
			for(var i:int=1;i<lineh;i++){
				trace(h*i);
				Linesprite.graphics.moveTo(0,h*i);
				Linesprite.graphics.lineTo(this.stage.stageWidth,h*i);
			}
			
			for(var j:int=1;j<linew;j++){
				Linesprite.graphics.moveTo(w*j,0);
				Linesprite.graphics.lineTo(w*j,this.stage.stageHeight);
			}

		}
		private function resizeHandler(e:Event):void{
			//trace("resizeHandler");
			trace("------------->>>",videowidth,videoheight);
			var vs:Number=videowidth/videoheight;
			var ss:Number=this.stage.stageWidth/this.stage.stageHeight;
			//var s:Number=Math.max(vs,ss);
			
			trace(vs>ss);
			
			
			
			if(vs>ss){
				
				if(isGPU){
					video.viewPort=new Rectangle(0,(this.stage.stageHeight-video.videoHeight)*.5,this.stage.stageWidth,video.videoWidth/vs);
				}else{
					video.width=this.stage.stageWidth;
					video.height=video.width/vs;
					video.x=0;
					video.y=(this.stage.stageHeight-video.height)*.5;
				}

			}else{
				
				if(isGPU){
					video.viewPort=new Rectangle((this.stage.stageWidth-video.videoWidth)*.5,0,video.videoHeight*vs,this.stage.stageHeight);
					
				}else{
				video.height=this.stage.stageHeight;
				video.width=video.height*vs;
				video.y=0;
				video.x=(this.stage.stageWidth-video.width)*.5;
				}
				
			}
			drawLine();
			//trace("------------->>>",videowidth,videoheight,video.width,video.height);
			
			
			/*var sw:Number=videowidth/this.stage.stageWidth;
			var sh:Number=videoheight/this.stage.stageHeight;
			
			
			trace("ooooooooooooo",sw,sh);
			
			var s:Number=Math.max(sw,sh);
			video.width = int(videowidth/s);
			video.height = int(videoheight/s);
			
			trace("fuckyou ---->>>>",video.width,video.height)
			if(sw<sh){
				trace("video.x",video.x);
				video.x=int(Math.abs((this.stage.stageWidth-video.width))*.5);
			}else{
				trace("video.y",video.y);
				video.y=int((this.stage.stageHeight-video.height)*.5);
			}*/
			//video.y=int((this.stage.stageHeight-video.height)*.5);
			
			//trace(video.width,video.height,video.y);
			//video.y=int(Math.abs(this.stage.stageHeight-video.height)*.5);
		}
		/*private function completeHandler(e:Event):void{
			trace(e.target.data);
			
			var xml:XML=new XML(e.target.data);
			var xl:XMLList=xml.item;
			for(var i:int=0;i<xl.length();i++){
				//trace(xl[i].@url);
				videoArr.push(xl[i].@url);
			}
			init("flvs/"+videoArr[p]);
			if(p<videoArr.length-1){
				p++;
			}else{
				p=0;
			}
			
			
			
		}*/
		public function clearVideoList():void{
			videoArr=null;
			p=0;
		}
		protected function logTimerHandler(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			
			DatabaseServer.getInstance().LogTime();
			
			dispatchEvent(new CustomEvent("logtime"));
			
		}
		public function initArrayList(arr:Array,_isautoplay:Boolean):void{
			videoArr=arr;
			trace("初始化 视频数组",arr.length);
			//init("flvs/"+videoArr[p]);
			//init(File.applicationDirectory.resolvePath(videoArr[p]).nativePath);
			isautoplay=_isautoplay;
			if(videoArr.length>0){
				
				if(isautoplay){
					trace(videoArr);
					init(videoArr[p].path);
				}
			}
			
			/*if(MySharedObject.getInstance().state == 0){
				if(p<videoArr.length-1){
					p++;
				}else{
					p=0;
				}
			}*/
		}
		public function setScreenWHNum(wnum:int,hnum:int):void{
			linew=wnum;
			lineh=hnum;
			drawLine();
		}
		public function insertPlay(name:String):void{
			//init("flvs/"+name);
			//init(File.applicationDirectory.resolvePath(videoArr[p]).nativePath);
			for(var i:int=0;i<videoArr.length;i++){
				if(videoArr[i].name==name){
					p=i;
					break;
				}
			}
			init(videoArr[p].path);
			
			/*if(MySharedObject.getInstance().state == 0){
				if(p<videoArr.length-1){
					p++;
				}else{
					p=0;
				}
			}*/
		}
		public function getIspause():Boolean{
			return ispause;
		}
		public function getVideoList():String{
			var string:String="";
			for(var i:int=0;i<videoArr.length;i++){
				if(i<videoArr.length-1){
				string+=videoArr[i].name+",";
					
				}else{
					string+=videoArr[i].name;
				}
			}
			
			return string;
		}
		public function play():void{
			if(ispause){
				stream.togglePause();
				//playTimer.start();
				ispause=false;
			}
		}
		public function getSoundvalue():Number{
			return MySharedObject.getInstance().sound;
			//MySharedObject.getInstance().sound = Math.floor(soundNum*100);
		}
		public function pause():void{
			if(!ispause){
				stream.togglePause();
				//playTimer.stop();
				ispause=true;
			}
		}
		public function addBright():void{
			brightNum+=.1;
			//video.filters=FilterFactory.getBrightnessFilter(brightNum);
		}
		public function subBright():void{
			if(brightNum>=.1){
				brightNum-=.1;
				//video.filters=FilterFactory.getBrightnessFilter(brightNum);
				//TweenMax.to(video, 1, {colorTransform:{brightness:brightNum}});
				
			}
		}
		public function setBright(num:int):void{
			brightNum=num*0.01
			//TweenMax.to(this, 3, {colorTransform:{brightness:brightNum}});
		}
		public function seek(num:int):void{
			stream.seek(stream.time+num);
		}
		public function gotoSeek(num:int):void{
			
			var n:Number=videolength*num/100000;
			stream.seek(n);
		}
		public function addVolume():void{
			if(soundNum<=.9){
				soundNum+=.1;
				st.volume=soundNum;
				stream.soundTransform = st;
				
			}
			
		}
		public function subVolume():void{
			//trace(st.volume,"AAAAAAAAAAAAAAAAAAAA")
			
			if(soundNum>=.1){
				soundNum-=.1;
				st.volume=soundNum;
				stream.soundTransform = st;
			}
		}
		public function setVolume(num:int):void{
			var n:Number=num*.01;
			if(n>=0&&n<=1){
				soundNum=n;
				st.volume=soundNum;
				stream.soundTransform = st;
			}
		}
		public function next():void{
			//init(File.applicationDirectory.resolvePath(videoArr[p]).nativePath);
			if(MySharedObject.getInstance().state == 0){
				if(p<videoArr.length-1){
					p++;
				}else{
					p=0;
				}
			}
			init(videoArr[p].path);
			
			ispause=false;
		}
		public function repaly():void{
			/*if(p!=0){
				//init("flvs/"+videoArr[p-1]);	
				//init(File.applicationDirectory.resolvePath(videoArr[p-1]).nativePath);
				init(videoArr[p].path);
			}else{
				//init("flvs/"+videoArr[videoArr.length-1]);
				init(videoArr[videoArr.length-1].path);
				
				//init(File.applicationDirectory.resolvePath(videoArr[videoArr.length-1]).nativePath);
			}*/
			
			init(videoArr[p].path);
			ispause=false;
		}
		public function prev():void{
			//init("flvs/"+videoArr[p]);
			p=(p-2+videoArr.length)%videoArr.length;
			//init(File.applicationDirectory.resolvePath(videoArr[p]).nativePath);
			//videoArr.length-1
			//init("flvs/"+videoArr[p]);
			//videoArr.length-1
			if(MySharedObject.getInstance().state == 0){
				if(p<videoArr.length-1){
					p++;
				}else{
					p=0;
				}
			}
			init(videoArr[p].path);
			ispause=false;
		}
		public function init(url:String):void{
			
			//return;
			if(stream){
				stream.close();
			}
			if(conn){
				conn.close();
			}
			
			st = new SoundTransform();
			st.volume=soundNum;
			
			conn.connect(null);
			stream = new NetStream(conn);
			stream.addEventListener(NetStatusEvent.NET_STATUS,netStatusHandler)
			//stream.bufferTime = 6;
			stream.play(url);
			//playTimer.start();
			//playtimerStar();
			
			stream.client = metaListener;
			stream.soundTransform = st;
			if(isGPU){
			
			}else{
				//video.clear();	
			}
			
			video.attachNetStream(stream);
			
			
			//pause();
			
			
			//p++;
			//logTimer.start();
			//DatabaseServer.getInstance().LogTime();
		}
		
		private function theMeta(data:Object):void
		{
			videowidth=data["width"];
			videoheight=data["height"];
			videolength=data["duration"]*1000;
			/*for(var i:* in data){
				trace(i,data[i])
				
				
			}*/
			//duration 116.04   116009
			
			var vs:Number=videowidth/videoheight;
			var ss:Number=this.stage.stageWidth/this.stage.stageHeight;
			trace(vs>ss);
			/*if(vs>ss){
				video.width=this.stage.stageWidth;
				video.height=video.width/vs;
				video.x=0;
				video.y=(this.stage.stageHeight-video.height)*.5;
				
			}else{
				
				video.height=this.stage.stageHeight;
				video.width=video.height*vs;
				video.y=0;
				video.x=(this.stage.stageWidth-video.width)*.5;
				
				
			}*/
			
			if(vs>ss){
				
				if(isGPU){
					video.viewPort=new Rectangle(0,(this.stage.stageHeight-video.videoHeight)*.5,this.stage.stageWidth,video.videoWidth/vs);
				}else{
					video.width=this.stage.stageWidth;
					video.height=video.width/vs;
					video.x=0;
					video.y=(this.stage.stageHeight-video.height)*.5;
				}
				
				
			}else{
				
				if(isGPU){
					video.viewPort=new Rectangle((this.stage.stageWidth-video.videoWidth)*.5,0,video.videoHeight*vs,this.stage.stageHeight);
					
				}else{
					video.height=this.stage.stageHeight;
					video.width=video.height*vs;
					video.y=0;
					video.x=(this.stage.stageWidth-video.width)*.5;
				}
				
			}
			
			drawLine();
			//trace("------------->>>",videowidth,videoheight,video.width,video.height);
			/*var sw:Number=videowidth/this.stage.stageWidth;
			var sh:Number=videoheight/this.stage.stageHeight;
			var s:Number=Math.max(sw,sh);
			video.width = int(videowidth/s);
			video.height = int(videoheight/s);
			
			
			trace("fuckyou ---->>>>",video.width,video.height)
			if(sw<sh){
				trace("video.x",video.x);
				video.x=int(Math.abs((this.stage.stageWidth-video.width))*.5);
			}else{
				trace("video.y",video.y);
				video.y=int((this.stage.stageHeight-video.height)*.5);
			}
			*/
			//video.y=int((this.stage.stageHeight-video.height)*.5);
			totalLength = data.duration;
		}
		private function netStatusHandler(e:NetStatusEvent):void
		{
			trace(e.info.code);
			switch (e.info.code)
			{
				case "NetConnection.Connect.Success" :
					trace("视频流开始播放")
					break;
				case "NetStream.Play.StreamNotFound" :
					//dispatchEvent(new CustomEvent("flvUrlError"))
					break;
				case "NetStream.Play.Stop" :
					trace("播放完成");
					//init("flvs/"+videoArr[p]);
					//init(File.applicationDirectory.resolvePath(videoArr[p]).nativePath);
					dispatchEvent(new CustomEvent("playover"));
					
					if(!isautoplay){
						//var v:Video;
						video.clear();
						//playTimer.stop();
						return;
					}
					
					
					
					if(MySharedObject.getInstance().state == 0){
						if(p<videoArr.length-1){
							p++;
						}else{
							p=0;
						}
					}
					init(videoArr[p].path);
					break;
				case "NetStream.Play.Start":
					//trace(video.videoWidth,video.videoHeight)
					break;
			}
			
		}
	}
}
package org.lifeng.display
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.*;
	import flash.media.SoundTransform;
	import flash.media.StageVideo;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	
	import org.lifeng.events.CustomEvent;
	
	public class Videos extends Sprite
	{
		private var mXlt:XMLList;
		private var video:Video
		//private var video:StageVideo;
		private var connection:NetConnection;
		private var stream:NetStream;
		private var N:int
		//private var ui:UIVideos
		
		
		public function Videos()
		{
			
			this.addEventListener(Event.ADDED_TO_STAGE,addStage)
		}
		
		private function addStage(e:Event):void
		{
			
			//ui=new UIVideos()
			//ui.playBtn.x=640
			//ui.playBtn.y=300
			
				
				
			var sprite:Sprite=new Sprite();
			sprite.graphics.beginFill(0xff6600,0);
			sprite.graphics.drawRect(0,0,1024,768);
			sprite.graphics.endFill();
			
			//ui.playBtn.visible=false
			
			
			video = new Video();
			//video = new StageVideo();
			video.x = 0;
			video.y = 0;
			video.width = 320;
			video.height = 240;
			//ui.videoMc.addChild(video);
			
			addChild(video);
			//addChild(sprite);
			//addChild(ui)
			//init("configs/videos.xml");
			
			sprite.addEventListener(MouseEvent.CLICK,breakH);
		}
		private function breakH(e:MouseEvent):void{
			//video.clear()
			stream.close()
			dispatchEvent(new CustomEvent("VIDEO_COMPLETE"))
			//trace("complete")
			//ui.playBtn.removeEventListener(MouseEvent.CLICK,playBtnClick)
		}
		public function init(str:String):void
		{
			N=0
			var urlld:URLLoader=new URLLoader();
			urlld.load(new URLRequest(str))
			urlld.addEventListener(Event.COMPLETE,onLoadXmlComplete);
		}
		public function remove():void
		{
			mXlt=null
		}
		private function playBtnClick(e:MouseEvent):void
		{
			initVideo()
			stream.resume()
			//ui.playBtn.visible=false
		}
		private function onLoadXmlComplete(e:Event):void
		{
			var xml:XML=new XML(e.currentTarget.data)
			mXlt =xml.children()
			initVideo()
			//ui.playBtn.addEventListener(MouseEvent.CLICK,playBtnClick)
		}
		private function initVideo():void
		{
			connection = new NetConnection();
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			connection.connect(null);
		}
		public function playVideo(videopath:String):void{
			initVideo();
			connectStream(videopath);
		}


		private function netStatusHandler(event:NetStatusEvent):void
		{
			//trace(event.info.code);
			switch (event.info.code)
			{
				case "NetConnection.Connect.Success" :
					//connectStream(mXlt[N]);
					break;
				case "NetStream.Play.StreamNotFound" :
					trace("Unable to locate video: ");
					break;
				case "NetStream.Play.Stop" :
				trace("121212121212")
					/*N++
					trace(N)
					if(N>=mXlt.length())
					{
						
						dispatchEvent(new CustomEvent("VIDEO_COMPLETE"))
						trace("complete")
						//ui.playBtn.removeEventListener(MouseEvent.CLICK,playBtnClick)
					}
					else
					{
						//ui.playBtn.visible=true;
						trace("btn")
					}*/
					break;
			}
		}

		private function connectStream(url:String):void
		{
			stream = new NetStream(connection);
			stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			//stream.onMetaData=new Object()
			var metaListener:Object=new Object();
			metaListener.onMetaData = function a(data:Object):void{
				
			}
			
			stream.client = metaListener;
			stream.bufferTime=5;
			//video.clear()
			video.attachNetStream(stream);
			stream.play(url);
			//stream.pause()
		}

		private function asyncErrorHandler(event:AsyncErrorEvent):void
		{

		}

	}

}
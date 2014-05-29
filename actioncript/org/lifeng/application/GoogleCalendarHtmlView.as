package org.lifeng.application
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	
	import org.lifeng.filesystem.FileWriter;
	
	public class GoogleCalendarHtmlView extends Sprite
	{
		private var calendarloader:HTMLLoader=new HTMLLoader();
		
		private var mark:Sprite=new Sprite();
		
		private var drag:Sprite=new Sprite();
		private var isdrag:Boolean=false;
		private var autosize:Boolean;
		public function GoogleCalendarHtmlView(autosize:Boolean=true)
		{
			super();
			autosize=autosize;
			var url:URLRequest=new URLRequest("https://www.google.com/calendar/render?pli=1&gsessionid=fjfjrPzEUdbCCwa36HsWww");
			//url.requestHeaders.push(new URLRequestHeader("User-Agent","Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1"))
			//var he:URLRequestHeader=new URLRequestHeader("User-Agent","Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1");
			calendarloader.userAgent="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1";
			calendarloader.load(url);
			calendarloader.paintsDefaultBackground=true;
			
			addChild(drag);
			
			mark.mouseEnabled=false;
			mark.mouseChildren=false;
			
			addChild(calendarloader);
			
			addChild(mark);
			
			calendarloader.mask=mark;
			
			addEventListener(Event.ADDED_TO_STAGE,addtoStage);
		}
		
		protected function addtoStage(event:Event):void
		{
			// TODO Auto-generated method stub
			if(autosize){
				calendarloader.width=stage.stageWidth;
				calendarloader.height=stage.stageHeight;
				//trace(calendarloader.width,calendarloader.height);
				mark.graphics.clear();
				mark.graphics.beginFill(0xff6600,1);
				mark.graphics.drawRect(0,70,calendarloader.width,calendarloader.height-70);
				mark.graphics.endFill();
				
				drag.graphics.clear();
				drag.graphics.beginFill(0x000000,1);
				drag.graphics.drawRect(-5,-5+40,calendarloader.width+10,calendarloader.height+10-40);
				drag.graphics.endFill();
			}
			drag.buttonMode=true;
			drag.addEventListener(MouseEvent.MOUSE_DOWN,startdragHandler);
			drag.addEventListener(MouseEvent.MOUSE_UP,stopdragHandler);
			drag.addEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
			calendarloader.addEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
			drag.visible=false;
		}
		
		protected function moveHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			trace("move");
			if(isdrag){
				calendarloader.x=drag.x;
				calendarloader.y=drag.y;
				
				mark.x=drag.x;
				mark.y=drag.y;
				var file:FileWriter=new FileWriter();
				file.writeFile(File.applicationDirectory.nativePath+"\\cfg.ini",drag.x+","+drag.y);
			}
			event.updateAfterEvent();
		}
		
		protected function stopdragHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			//this.stopDrag();
			
			drag.stopDrag();
			isdrag=false;
			
		}
		
		protected function startdragHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			//this.startDrag(false);
			drag.startDrag(false);
			isdrag=true;
			event.updateAfterEvent();
		}
		public function setsize(_w:int,_h:int):void{
			calendarloader.width=_w;
			calendarloader.height=_h;
			
			mark.graphics.clear();
			mark.graphics.beginFill(0xff6600,1);
			mark.graphics.drawRect(0,70,calendarloader.width,calendarloader.height-70);
			mark.graphics.endFill();
			
			drag.graphics.clear();
			drag.graphics.beginFill(0x000000,1);
			drag.graphics.drawRect(-5,-5+40,calendarloader.width+10,calendarloader.height+10-40);
			drag.graphics.endFill();
			
			drag.buttonMode=true;
			drag.addEventListener(MouseEvent.MOUSE_DOWN,startdragHandler);
			drag.addEventListener(MouseEvent.MOUSE_UP,stopdragHandler);
			//this.stage.addEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
			drag.visible=false;
		}
		public function viewDrag(bool:Boolean):void{
			if(bool){
				drag.visible=true;
			}else{
				drag.visible=false;
			}
		}
		public function setXY(_x:int,_y:int):void{
			calendarloader.x=_x;
			calendarloader.y=_y;
			
			mark.x=_x;
			mark.y=_y;
			
			drag.x=_x;
			drag.y=_y;
		}
	}
}
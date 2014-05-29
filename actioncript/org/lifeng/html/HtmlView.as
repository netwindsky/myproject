package org.lifeng.html
{

	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTMLUncaughtScriptExceptionEvent;
	import flash.events.LocationChangeEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.html.HTMLLoader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.Timer;
	import flash.utils.setInterval;
	
	public class HtmlView extends Sprite
	{
		private var jspathArr:Array=new Array();
		private var html:HTMLLoader=new HTMLLoader();
		private var hello:Object;
		public function HtmlView()
		{
			super();
			addChild(html);
			html.width=1000;
			html.height=720;
			html.userAgent="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1";
			html.addEventListener(MouseEvent.CLICK,clickHanler);
			//html.addEventListener(
			//html.navigateInSystemBrowser=true;
			html.addEventListener(Event.COMPLETE,renderH);
			html.manageCookies=true;
			html.cacheResponse=true;
			html.addEventListener(Event.LOCATION_CHANGE,localchange);
			html.addEventListener(HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION,ErrorHandler);
			//html.addEventListener(Event.HTML_RENDER,renderAAAA);

			/*hello=html.window.document.createElement("script");
			hello.src="http://code.jquery.com/jquery-1.8.2.min.js";
			//hello.src="./jquery-1.8.0.js";
			hello.onload =helloworld;
			*/
		}
		
		protected function ErrorHandler(event:HTMLUncaughtScriptExceptionEvent):void
		{
			// TODO Auto-generated method stub
			trace("JS 解析异常！");
		}
		
		protected function localchange(event:LocationChangeEvent):void
		{
			// TODO Auto-generated method stub
			trace(event.location);
		}
		protected function clickHanler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			trace("------------>>>>",event.currentTarget.name,event.localX,event.localY);
		}
		public function setHtmlUrl(url:String):void{
			html.load(new URLRequest(url));
			
			
			return;
			var loader:URLLoader=new URLLoader();
			loader.addEventListener(Event.COMPLETE,completeHandler);
			trace("加载页面……"+url);
			loader.load(new URLRequest(url));
		}
		public function setSize(_w:int,_h:int):void{
			html.width=_w;
			html.height=_h;
		}
		private function renderH(e:Event):void{
			
			/*hello=html.window.document.createElement("script");
			//hello.src="http://code.jquery.com/jquery-1.8.2.min.js";
			hello.src="./jquery-1.8.0.js";
			hello.onload =helloworld;
			
			*/
			
			
			html.removeEventListener(Event.COMPLETE,renderH);
			//html.window.document.body.appendChild(hello);
			
			var js="";
			while(jspathArr.length>0){
				js+=getJSString(jspathArr.shift());
			}
			//js+="function a(){return jQuery('a.WB_btn_login')[0]}"
			html.window.eval(js);
			
			trace(html.window.jQuery("html tbody tr"));
			
			var obj:*=html.window.jQuery("html tbody tr");
			trace(obj.length,new Date());
			for(var i:int=0;i<obj.length;i++) 
			{ 
				//trace(i,obj[i]);
				/*for(var j in obj[i]){
					trace(j,obj[i][j]);
					trace(obj[i].outerHTML);
					trace(obj[i].innerText);
				}*/
				//trace(obj[i].outerHTML);
				//trace(obj[i].innerText);
				
				var stt:String=obj[i].innerText;
				var arr:Array=stt.split("	");
				
				trace(arr.length,arr);
				
			} 
			
			
			/*trace(html.window.jQuery("input#userId").val("netwindsky@qq.com"));
			trace(html.window.jQuery("input#passwd").val("6543210@163.com"));

			var timerH:Timer=new Timer(2000,1);
			timerH.addEventListener(TimerEvent.TIMER,timerHandler);
			timerH.start();
			
			var _x:int=535+this.stage.nativeWindow.x;
			var _y:int=370+this.stage.nativeWindow.y;
			trace(_x,_y);
			var nainfo:NativeProcessStartupInfo=new NativeProcessStartupInfo();
			var na:NativeProcess=new NativeProcess();
			nainfo.arguments=new Vector.<String>();
			nainfo.arguments.push(_x);
			nainfo.arguments.push(_y);
			//trace(File.applicationDirectory+"\\LButton.exe");
			
			nainfo.executable=new File(File.applicationDirectory.nativePath+"\\LButton.exe");
			na.start(nainfo);
			///////--------------------------------------------------------------------
			var _x:int=535+this.stage.nativeWindow.x;
			var _y:int=270+this.stage.nativeWindow.y;
			trace(_x,_y);
			var nainfo:NativeProcessStartupInfo=new NativeProcessStartupInfo();
			var na:NativeProcess=new NativeProcess();
			nainfo.arguments=new Vector.<String>();
			nainfo.arguments.push(_x);
			nainfo.arguments.push(_y);
			//trace(File.applicationDirectory+"\\LButton.exe");
			
			nainfo.executable=new File(File.applicationDirectory.nativePath+"\\LButton.exe");
			na.start(nainfo);*/
			
			
			/*
			var  event:MouseEvent=new MouseEvent(MouseEvent.MOUSE_OVER,true,false,535,350);
			//var  eventa:MouseEvent=new MouseEvent(MouseEvent.MOUSE_UP,true,false,535,350);
			html.dispatchEvent(event);*/
			//this.stage.nativeWindow.stage.m
			
			
			//html.dispatchEvent(eventa);
			//trace(html.window.jQuery("a.WB_btn_oauth")[0].click);
			//trace(html.);
			/*for(var i:int in html){
				trace(html[i]);
			}*/
			return;
			
			//html.window.document.body.innerHTML += '<a href="javascript:alert(jQuery);">sdfdf</a>';
			//trace("加载页面……",html.window.document.body.innerHTML);
			trace("加载页面……",html.window.$);
			/*var array:Array=html.window.a();
			for(var i:int=0;i<array.length;i++){
				trace(array[i].name,array[i].url);
			}*/
			
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			/*trace("---->>>",html.window.a());
			var b:Object=html.window.a();
			for(var i:* in b){
				trace(i,":",b[i])
			}*/
			var arr:Array=this.stage.nativeWindow.stage.getObjectsUnderPoint(new Point(190,35));
			trace(arr.length);
			//arr[0].x=100;
			var bmp:Bitmap=arr[0];
			trace(bmp.name);
			trace("AAAAAAAAAAAAAAA",arr[1]);
			
		}
		private function helloworld(e:*):void{
			trace("helloworld");
			//html.window.alert(html.window.jQuery);
			trace(html.window.jQuery("input#userId").val("netwindsky@qq.com"));
			trace(html.window.jQuery("input#passwd").val("aaaaa@163.com"));
			trace(html.window.jQuery("a.WB_btn_login")[0]);
		}
		private function completeHandler(e:Event):void{
			var string:String=e.target.data;
			trace(string);
			var js="";
			while(jspathArr.length>0){
				js+=getJSString(jspathArr.shift());
			}
			//trace(js);
			var sarr:Array=string.split("<head>");
			trace(sarr[0]+"<head>"+js+sarr[1]);
			setHtmlString(sarr[0]+js+sarr[1]);
			
			//insertJS(string);
		}
		private function setHtmlString(string:String):void{
			html.loadString(string);
		}
		public function insertJS(jspath:String):void{
			jspathArr.push(jspath);
		}
		private function getJSString(jspath:String):String{
			var file:File=new File(File.applicationDirectory.nativePath+"\\" +jspath);
			var filestream:FileStream=new FileStream();
			filestream.open(file,FileMode.READ);
			//var jsstring:String='<script type="text/javascript">'
			var jsstring:String=filestream.readMultiByte(filestream.bytesAvailable,"GBK");
			//jsstring+='</script>';
			filestream.close();
			
			return jsstring;
		}
	}
}
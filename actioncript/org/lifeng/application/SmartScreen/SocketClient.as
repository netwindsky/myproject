package org.lifeng.application.SmartScreen
{

	import com.adobe.protocols.dict.events.MatchEvent;
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.Timer;
	
	import org.lifeng.events.CustomEvent;
	import org.lifeng.tool.GCManager;

	public class SocketClient extends EventDispatcher
	{
		private var socket:Socket;
		private var host:String = "";
		private var jsonObj:Object;
		private var degreeArr:Array = [];
		private var _timer:Timer;
		public function SocketClient()
		{

		}
		public function init(_host:String):void {
			//stage.displayState = StageDisplayState.FULL_SCREEN;
			host=_host;
			initsocket();
			_timer=new Timer(60000);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			
		}
		private function initsocket():void {
			
			dispatchEvent(new CustomEvent("mm","开始链接中控服务器！\n"));
			if(socket){
				socket.removeEventListener(Event.CLOSE, closeHandler);
				socket.removeEventListener(Event.CONNECT, connectHandler);
				socket.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				socket.removeEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
				GCManager.gc();
			}
			socket=new Socket();
			socket.connect(host,1256);
			socket.addEventListener(Event.CLOSE, closeHandler);
			socket.addEventListener(Event.CONNECT, connectHandler);
			socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		}
		/**
		 * 关闭连接
		 */
		private function closeHandler(event:Event):void {
			trace("closeHandler: " + event);
			dispatchEvent(new CustomEvent("mm","与中控服务器已断开链接！\n"));
			//ligth.gotoAndStop(1);
			_timer.stop();
			initsocket();
			//trace("B");
		}
		/**
		 * 连接成功
		 */
		private function connectHandler(event:Event):void {
			trace("connectHandler")
			dispatchEvent(new CustomEvent("mm","与中控服务器已建立链接！\n"));
			//ligth.gotoAndStop(2);
			sendRequest();
			_timer.start();
		}
		/**
		 * 连接错误
		 */
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
			dispatchEvent(new CustomEvent("mm","与中控服务器链接出现错误,确认网络配置正确，并且中控服务器已开启！\n"));
			//ligth.gotoAndStop(1);
			//trace("A");
			_timer.stop();
			initsocket();
		}
		/**
		 * 安全错误
		 */
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
			//dispatchEvent(new CustomEvent("mm","与中控服务器链接出现错误,确认网络配置正确，并且中控服务器已开启！"));
			
			_timer.stop();
			initsocket();
		}
		/**
		 * 读取数据
		 */
		private function socketDataHandler(event:ProgressEvent):void {
			//trace("socketDataHandler: " + event);
			readResponse();
		}
		/**
		 * 读数据
		 * readMultiByte  使用指定的字符集，从该字节流读取一个多字节字符串
		 */
		private function readResponse():void {
			var string:String = socket.readMultiByte(socket.bytesAvailable,"utf-8");
			
			dispatchEvent(new CustomEvent("mm",string));
			var arr:Array = string.split("\n");
			//tMc.txt.text = "收到服务器消息：" + arr.length + "\n" + arr + "\n";
			
			for (var i:int=0; i<arr.length; i++) 
			{
				if (arr[i].toString() != "") {
					//jsonObj = JSON.decode(arr[i].toString());
					jsonObj=com.adobe.serialization.json.JSON.decode(String(arr[i]));
					//trace("收到服务器消息：" + string + "\n");
					dispatchEvent(new CustomEvent("message",jsonObj));

					/*if (jsonObj.models) {
						//dataNum = jsonObj.models.length;
						//writeln("{'command':" + "'" + 'getdotc' + "'}" );
						//writeln("{'command':" + "'" + 'gethumidity' + "'}" );
						//_timer.start();
					}
					
					if (jsonObj.number) {
						//trace(jsonObj.number);
						//degreeArr.push(jsonObj.number);
						
					}*/
				}
			}
			arr=null;
		}
		private function timerHandler(e:TimerEvent):void {
			//trace("半分执行次——————————————————————————————————————————————————————————");
			//degreeArr = [];
			//writeln("{'command':" + "'" + 'getdotc' + "'}" );
			//writeln("{'command':" + "'" + 'gethumidity' + "'}" );
			//var s:String="{'command':'connected','random':"+Math.random()+"}";
			//var r:Number=Math.random();
			//writeln("{'command':'connected','random':"+r+"}");
			writeln("{'command':'connected'}");
			//s=null;
			
		}
		/**
		 * 写入函数
		 */
		private function sendRequest():void {
			writeln("{'command':login,'type':server,'models':[{'command':[videoplay,videopause,setbright,setvolume,videonext,videoprev],'description':'第一块屏幕','status':'1','type':'control_player'}]}");
		}
		/**
		 * 向服务器写入数据
		 * writeUTFBytes  将一个 UTF-8 字符串写入套接字
		 */
		public function writeln(str:String):void {
			str +=  "\n";
			try {
				//textarea.textFlow=TextConverter.importToFlow("<font color='#0066ff' face='Arial' size='12'>"+"向服务器发送消息："+str+"</font><br>",TextConverter.TEXT_FIELD_HTML_FORMAT);
				//textarea.appendText("向服务器发送消息：" + str);
				//trace("向服务器发送消息：" + str);
				socket.writeUTFBytes(str);
				socket.flush();
			} catch (e:Error) {
				//trace(e);
				//textarea.textFlow=TextConverter.importToFlow("<font color='#ff0000' face='Arial' size='12'>"+"向服务器发送消息异常："+e+"</font><br>",TextConverter.TEXT_FIELD_HTML_FORMAT);
				//textarea.appendText("向服务器发送消息异常：" + e + "\n");
				//trace("向服务器发送消息异常：" + e + "\n");
			}
			str=null;
		}
	}
}
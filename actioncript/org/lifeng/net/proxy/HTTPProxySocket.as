/********************************
HTTP Proxy Socket Class
Author:Swfdong
Date:2010-07-04
http://blog.swfdong.org
********************************/
package  org.lifeng.net.proxy {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	
	import org.lifeng.events.ProxyEvent;

	public class HTTPProxySocket extends Socket{
		private var _proxyHost:String;
		private var _proxyPort:int;
		private var _ua:String;
		private var _host:String;
		private var _port:int;
		public function HTTPProxySocket(host:String,port:uint=80,ua:String="Swfdong Proxy"):void {
			_proxyHost=host;
			_proxyPort=port;
			_ua=ua;
		}
		//连接
		override public function connect(host:String,port:int):void{
			_host=host;
			_port=port;
			super.connect(_proxyHost,_proxyPort);
			super.addEventListener(Event.CONNECT,connectHandler,false,0,true);
		}
		//关闭连接
		override public function close():void{
			super.removeEventListener(Event.CONNECT,connectHandler);
			super.close();
		}
		//Getter
		//代理主机&端口
		public function get proxyHost():String{
			return _proxyHost;
		}
		public function get proxyPort():int{
			return _proxyPort;
		}
		//UserAgent
		public function get userAgent():String{
			return _ua;
		}
		//目标主机&端口
		public function get host():String{
			return _host;
		}
		public function get port():int{
			return _port;
		}
		//连接侦听
		private function connectHandler(e:Event):void{
			trace("connectHandler","CONNECT "+_host+":"+_port+" HTTP/1.1\r\nUser-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; Maxthon; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1; InfoPath.2)\r\nHost: "+_host+"\r\nContent-Length: 0\r\nProxy-Connection: Keep-Alive\r\n\r\n Connection: keep-alive\r\n");
			super.writeUTFBytes("GET /data/101010100.html HTTP/1.1\r\n CONNECT "+_host+":"+_port+" HTTP/1.1\r\n Accept-Encoding: gzip,deflate,sdch\r\n User-Agent:  Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; Maxthon; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1; InfoPath.2)\r\nHost: "+_host+"\r\n Connection: keep-alive\r\n Content-Length: 0\r\nProxy-Connection: Keep-Alive\r\n\r\n Connection: keep-alive\r\n");
			
			super.removeEventListener(Event.CONNECT,connectHandler);
			super.addEventListener(ProgressEvent.SOCKET_DATA,proxyStateHandler,false,0,true);
			super.flush();
		}
		//代理状态侦听
		private function proxyStateHandler(e:ProgressEvent):void{
			
			var event:ProxyEvent;
			var response:String=super.readUTFBytes(super.bytesAvailable);
			trace("proxyStateHandler",response);
			super.removeEventListener(ProgressEvent.SOCKET_DATA,proxyStateHandler);
			if(response.lastIndexOf("established")!=-1){
				event=new ProxyEvent(ProxyEvent.CONNECTED);
			}else{
				event=new ProxyEvent(ProxyEvent.ERROR);
			}
			dispatchEvent(event);
		}
	}
}
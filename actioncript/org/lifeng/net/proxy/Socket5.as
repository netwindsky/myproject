/**
 * @MD5:
 * @AUTHOR: Leo
 * @CREATED: 2010-8-20
 * @AUTHOR MSN:  todayliu@hotmail.com
 * @DESCRIPTION: 
 *
 */
package  org.lifeng.net.proxy
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.ByteArray;
	
	public class Socket5 extends EventDispatcher
	{
		private var $proxy_host:String="127.0.0.1";
		private var $proxy_ip:uint = 1080;
		private var $proxy_user:String = "test";
		private var $proxy_pwd:String = "test";
		private var $host:String = "";
		private var $ip:uint = 80;
		private var $data:ByteArray = new ByteArray();
		private var $socket:SocketProxy5;
		public function Socket5()
		{
			
			$socket=new SocketProxy5();
			eventListner($socket);
		}
		public function socketProxy(_phost:String,_pip:uint = 1080,_pu:String="",_ppwd:String = ""):void{
			$proxy_host = _phost;
			$proxy_ip         = _pip;
			$proxy_user = _pu;
			$proxy_pwd        = _ppwd;
			$socket.connect($proxy_host, $proxy_ip);
		}
		public function connet(_host:String,_ip:uint = 80):void{
			_ip &= 0xFFFF;
			$host = _host;
			$ip = _ip;
		}
		public function send(_value:String):void{
			var _tmp:ByteArray = new ByteArray();
			_tmp.writeUTFBytes(_value);
			if($socket.connected){
				if($socket.status == SocketProxy5.PROXY_READY){
					$socket.writeBytes(_tmp);
					$socket.flush();
				}
			}else{
				$data.writeBytes(_tmp);
			}
		}
		private function eventListner(dispatcher:EventDispatcher):void
		{
			dispatcher.addEventListener(Event.CLOSE, closeHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(Event.CONNECT, connectedHandler);
			dispatcher.addEventListener(ProgressEvent.SOCKET_DATA, dealResultHandler);
		}
		private function connectedHandler(event:Event):void
		{
			trace(event);
			$socket.helloProxy();
		}
		
		private function closeHandler(event:Event):void
		{
			trace(event)
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
			trace(event);
		}
		
		private function dealResultHandler(event:ProgressEvent):void
		{
			var _len:uint=$socket.bytesAvailable;
			var _bytes:ByteArray=new ByteArray();
			var _rst:uint=0;
			if($socket.status == SocketProxy5.PROXY_CHECKING){
				if(_len<2)return;
				_rst = $socket.readShort();
				_rst &= 0xF;
				if(_rst==0x02){        //0x02要求用户名和密码
					$socket.status = SocketProxy5.PROXY_LOGIN;
					$socket.login($proxy_user,$proxy_pwd);
					
				}else if(_rst==0x00){
					$socket.status = SocketProxy5.PROXY_ENTER_ADDR;
					$socket.RealAddress($host, $ip);
				}else{
					trace(75);
				}
			}else if($socket.status == SocketProxy5.PROXY_LOGIN){
				if(_len<2)return;
				_rst=$socket.readShort();
				_rst  &= 0xF;
				if(_rst==0x0){
					$socket.status = SocketProxy5.PROXY_ENTER_ADDR;
					$socket.RealAddress($host, $ip);
				}else{
					trace(85);
				}
			}else if($socket.status == SocketProxy5.PROXY_ENTER_ADDR){
				$socket.readBytes(_bytes,0,$socket.bytesAvailable);
				_rst=_bytes.readShort();
				_rst  &= 0xF;
				if(_rst==0x0){  //· X’00’ 成功
					$socket.status = SocketProxy5.PROXY_READY;
					_rst = _bytes.readByte();
					_rst  &= 0xF;
					//信息
					if      (_rst == 0x01){//· IPV4：X’01’ 4
					}else if(_rst == 0x03){//· 域名：X’03’ 
					}else if(_rst == 0x04){//· IPV6：X’04’
					}
					//成功联接
					if($data.length>0){
						$socket.writeBytes($data);
						$socket.flush();
					}
				}else if(_rst == 0x01){//· X’01’ 普通的SOCKS服务器请求失败        
				}else if(_rst == 0x02){//· X’02’ 现有的规则不允许的连接
				}else if(_rst == 0x03){//· X’03’ 网络不可达
				}else if(_rst == 0x04){//· X’04’ 主机不可达
				}else if(_rst == 0x05){//· X’05’ 连接被拒
				}else if(_rst == 0x06){//· X’06’ TTL超时
				}else if(_rst == 0x07){//· X’07’ 不支持的命令
				}else if(_rst == 0x08){//· X’08’ 不支持的地址类型
				}else{
					trace("//· X’09’ – X’FF’ 未定义");
				}
			}else if($socket.status == SocketProxy5.PROXY_READY){
				//TODO:这里放处理直接地区返回的值。
				trace($socket.readUTFBytes(_len));
			}
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			trace(event)
		}
	}
}
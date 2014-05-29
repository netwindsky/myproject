/**
 * @MD5:
 * @AUTHOR: Leo
 * @CREATED: 2010-8-20
 * @AUTHOR MSN:  todayliu@hotmail.com
 * @DESCRIPTION: 
 *
 */
package org.lifeng.net.proxy
{
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	public class SocketProxy5 extends Socket
	{
		//当前的状态
		private var __status__:uint=0x02;
		public static const PROXY_CHECKING:uint=0x02;
		public static const PROXY_LOGIN:uint=0x03;
		public static const PROXY_ENTER_ADDR:uint=0x04;
		public static const PROXY_READY:uint=0x05;
		
		public function SocketProxy5(host:String=null, port:int=0)
		{
			super(host, port);
		}
		
		public function get status():uint
		{
			return __status__;
		}
		
		public function set status(_value:uint):void
		{
			trace("-----------"+_value);
			__status__=_value;
		}
		
		//版本号（1字节） | 认证方法数(1字节) | 认证方法序列（1-255个字节长度）
		//0x01 通用安全服务应用程序接口(GSSAPI)
		//                0x02 用户名/密码(USERNAME/PASSWORD)
		//                0x03 至 X'7F' IANA 分配(IANA ASSIGNED)
		//                0x80 至 X'FE' 私人方法保留(RESERVED FOR PRIVATE METHODS)
		//                0xFF 无可接受方法(NO ACCEPTABLE METHODS)
		public function helloProxy(_value:ByteArray=null):void
		{
			if (__status__ != PROXY_CHECKING)
				return;
			if (!_value)
			{
				_value=new ByteArray();
				_value.writeByte(0x05);
				_value.writeByte(0x02); //支持几种模式
				_value.writeByte(0x00); //支持无验证模式
				_value.writeByte(0x02); //用户名与密码验证模式
			}
			this.writeBytes(_value);
			this.flush();
		}
		
		// VER        CMD        RSV           ATYP        DST.ADDR        DST.PROT
		//        1        1        X’00’        1        Variable        2
		//说明：
		//VER 协议版本: X’05’
		//· CMD
		//· CONNECT：X’01’
		//· BIND：X’02’
		//· UDP ASSOCIATE：X’03’
		//· RSV 保留
		//· ATYP 后面的地址类型
		//· IPV4：X’01’
		//· 域名：X’03’
		//· IPV6：X’04’'
		//· DST.ADDR 目的地址
		//· DST.PORT 以网络字节顺序出现的端口号
		// ATYP 后面的地址类型  说明：
		//                · X'01'
		//                基于IPV4的IP地址，4个字节长
		//                · X'03'
		//                基于域名的地址，地址字段中的第一字节是以字节为单位的该域名的长度，没有结尾的NUL字节。
		//                · X'04'
		//                IPV6 16个字节长。
		public function RealAddress(_host:String=null, _port:int=0):void
		{
			if (__status__ != PROXY_ENTER_ADDR)return;
			
			var _reg:RegExp=/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/;
			var _tmpstr:Array=_reg.exec(_host);
			var _tmp:ByteArray=new ByteArray();
			var _tmphost:ByteArray = new ByteArray();
			var _tmplen:uint = 0;
			_tmp.writeByte(0x05);
			_tmp.writeByte(0x01);
			_tmp.writeByte(0x00); //· RSV 保留 0x00
			if (!_tmpstr)
			{
				_tmp.writeByte(0x03);
				_tmphost.writeMultiByte(_host,"gb2312");
				_tmp.writeByte(_tmphost.length);
				_tmp.writeBytes(_tmphost);
			}
			else
			{        //· ATYP 后面的地址类型
				_tmp.writeByte(0x01);
				var _tmpad:Array=_host.split(".");
				_tmp.writeByte(_tmpad[0]);
				_tmp.writeByte(_tmpad[1]);
				_tmp.writeByte(_tmpad[2]);
				_tmp.writeByte(_tmpad[3]);
			}
			_tmp.writeShort(_port);
			this.writeBytes(_tmp);
			this.flush();
		}
		
		//0x01 | 用户名长度（1字节）| 用户名（长度根据用户名长度域指定） | 口令长度（1字节） | 口令（长度由口令长度域指定）
		public function login(_user:String="test", _pwd:String='test'):void
		{
			if (__status__ != PROXY_LOGIN)
				return;
			var _tmp:ByteArray=new ByteArray();
			_tmp.position=0;
			_tmp.writeByte(0x05);
			var _usr:ByteArray=new ByteArray();
			_usr.writeMultiByte(_user, "gb2312");
			
			_tmp.writeByte(_usr.length);
			_tmp.writeBytes(_usr);
			_usr.clear();
			_usr.writeMultiByte(_user, "gb2312");
			
			_tmp.writeByte(_usr.length);
			_tmp.writeBytes(_usr);
			this.writeBytes(_tmp);
			this.flush();
		}
		
	}
}
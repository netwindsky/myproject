///////////////////////////////////////////////////////////
//  CommunicationFactory.as
//  Macromedia ActionScript Implementation of the Class CommunicationFactory
//  Generated by Enterprise Architect
//  Created on:      03-八月-2010 17:44:31
//  Original author: lifeng
///////////////////////////////////////////////////////////

package org.lifeng.net
{

	
	import flash.net.Socket;
	
	import org.lifeng.net.http.HttpManager;

	/**
	 * 通信工厂，创建通讯类。
	 * @author lifeng
	 * @version 1.0
	 * @created 03-八月-2010 17:44:31
	 */
	public class CommunicationFactory
	{
		private static var http:HttpManager;
		//private static var socket:SocketManager;
	    /**
	     * 创建通讯对象。
	     * 
	     * @param name
	     */
	    public static function create(name:String): ICommunication
	    {
			switch(name){
				case "http":
					if(http){
						return http;
					}else{
						http=new HttpManager();
						return http;
					}
					break;
				/*case "socket":
					if(socket){
						return socket;
					}else{
						socket=new SocketManager();
						return socket;
					}
					break;*/
				case "rtmp":
					
					break;
				case "remoting":
					
					break;
			}
			return null;
	    }
		/*public static function getSocketManager():SocketManage{
			if(socket){
				return socket;
			}else{
				socket=new SocketManager();
				return socket;
			}
		}*/

	}//end CommunicationFactory

}
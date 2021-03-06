///////////////////////////////////////////////////////////
//  HttpManager.as
//  Macromedia ActionScript Implementation of the Class HttpManager
//  Generated by Enterprise Architect
//  Created on:      03-八月-2010 14:15:15
//  Original author: lifeng
///////////////////////////////////////////////////////////

package org.lifeng.net.http
{
	
	import flash.utils.Dictionary;
	
	import org.lifeng.net.CommunicationDataFormat;
	import org.lifeng.net.ICommunication;
	import org.lifeng.net.IRequest;
	import org.lifeng.net.http.loader.BinaryLoader;
	import org.lifeng.net.http.loader.ImageLoader;
	import org.lifeng.net.http.loader.SwfLoader;
	import org.lifeng.net.http.loader.TextLoader;

	/**
	 * <font color="#000000">Http服务管理类。</font>
	 * @author lifeng
	 * @version 1.0
	 * @updated 03-八月-2010 14:45:38
	 */
	public class HttpManager implements ICommunication
	{
	    /**
	     * 
	     * @param request    发送请求对象。
	     * @param functionHandler    处理方法
	     */
		private var loader:Dictionary=new Dictionary(true);
	    public function send(request:IRequest, functionHandler:Function):int
	    {
			var dataformat:String=(request as HttpRequest).getDataFormat();
			var id:String="id_"+Math.floor(Math.random()*10000000000);
			switch(dataformat){
				case CommunicationDataFormat.BINARY:
					loader[id]=new BinaryLoader((request as HttpRequest).getRequest(),functionHandler);
					return 1;
					break;
				case CommunicationDataFormat.SWF:
					loader[id]=new SwfLoader((request as HttpRequest).getRequest(),functionHandler);
					return 1;
					break;
				case CommunicationDataFormat.IMAGE:
					loader[id]=new ImageLoader((request as HttpRequest).getRequest(),functionHandler);
					return 1;
					break;
				case CommunicationDataFormat.TEXT:
					loader[id]=new TextLoader((request as HttpRequest).getRequest(),functionHandler);
					return 1;
					break;
			}
			dataformat=null;
			return 1;
	    }
		
	}//end HttpManager

}
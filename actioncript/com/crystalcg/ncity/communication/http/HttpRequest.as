///////////////////////////////////////////////////////////
//  HttpRequest.as
//  Macromedia ActionScript Implementation of the Class HttpRequest
//  Generated by Enterprise Architect
//  Created on:      03-八月-2010 10:59:40
//  Original author: lifeng
///////////////////////////////////////////////////////////

package  com.crystalcg.ncity.communication.http
{
	
	import com.crystalcg.ncity.communication.CommunicationDataFormat;
	import com.crystalcg.ncity.interfaces.communication.IRequest;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.osmf.media.URLResource;

	/**
	 * <font color="#000000">http请求对象。</font>
	 * @author lifeng
	 * @version 1.0
	 * @updated 03-八月-2010 16:22:57
	 */
	public class HttpRequest implements IRequest
	{
		private var request:URLRequest=new URLRequest();
		private var data:URLVariables=new URLVariables();
		private var dataformat:String=CommunicationDataFormat.BINARY;
		public function HttpRequest(){
			//var a:URLRequest;
			//request.data=data;
		}
		/**
		 * 设置访问链接。
		 * 
		 * @param value
		 */
		public function setURL(value:String):void{
			request.url=value;
		}
		/**
		 * 设置传送方式。
		 * 
		 * @param value
		 */
		public function setMethod(value:String): void{
			request.method=value;
		}
		/**
		 * 添加name-value。
		 * 
		 * @param _name    名称
		 * @param value    值。
		 */
		public function addProperty(_name:String,value:String):void{
			if(request.data==null){
				request.data=data;
			}
			
			data[_name]=value;
		}
		/**
		 * 设置返回的编码格式类型。SWF/IMAGE/TEXT/BINARY
		 */
		public function setDataFormat(value:String):void{
			
			dataformat=value;
		}

		/**
		 * 返回编码格式。
		 */
		public function getDataFormat(): String
		{
			return dataformat;
		}
		/**
		 * 获取请求对象。
		 */
		public function getRequest():URLRequest{
			return request;
		}

	}//end HttpRequest

}
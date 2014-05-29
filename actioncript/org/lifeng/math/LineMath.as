///////////////////////////////////////////////////////////
//  CommunicationDataFormat.as
//  Macromedia ActionScript Implementation of the Class CommunicationDataFormat
//  Generated by Enterprise Architect
//  Created on:      03-八月-2010 14:55:10
//  Original author: lifeng
///////////////////////////////////////////////////////////

package org.lifeng.math
{

	public class LineMath
	{
		
		private var angle:Number;
		private var b:Number;
		
		/**
		 * 直角坐标系直线函数。
		 * @author lifeng
		 * @version 1.0
		 * @updated 03-八月-2010 16:28:50
		 */
		public function LineMath(_Dangle:Number,_b:Number)
		{
			angle=_Dangle//Math.PI*_a/180;
			b=_b;
		}
		public function getX(y:Number):Number{
			if(angle%90==0&&angle%180!=0){
				return 0
			}else{
				return (y-b)/BaseMath.tgD(angle);
			}
			//return (y-b)/BaseMath.tgD(angle);s
			//.tan(angle);
		}
		public function getY(x:Number):Number{
			//trace(angle);
			//trace(x,BaseMath.tgD(angle));
			/*if(angle%180==0){
				return b;
			}else{
				return -BaseMath.tgD(angle)*x+b;
			}*/
			 
			
			return -BaseMath.tgD(angle)*x-b;
		}
	}
}
﻿/*======================================================================*//**
* 
* Utils for ActionScript 3.0
* 
* @author	Copyright (c) 2007 Spark project.
* @version	1.0.0
* 
* @see		http://utils.libspark.org/
* @see		http://www.libspark.org/
* 
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
* 
* http://www.apache.org/licenses/LICENSE-2.0
* 
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
* either express or implied. See the License for the specific language
* governing permissions and limitations under the License.
* 
*//*=======================================================================*/
package org.libspark.utils {
	import flash.errors.IllegalOperationError;
	
	/**
	 * Date クラスのためのユーティリティクラスです
	 */
	public class DateUtil {
		
		/*======================================================================*//**
		* @private
		*//*=======================================================================*/
		public function DateUtil() {
			throw new IllegalOperationError( "DateUtil クラスはインスタンスを生成できません。" );
		}
		
		
		
		
		
		/*======================================================================*//**
		* 対象となる Date オブジェクトの月の最大日数を返します。
		* @author	taka:nium
		* @param	date	最大日数を取得したい Date オブジェクトです。
		* @return			最大日数です。
		*//*=======================================================================*/
		static public function getMaxDateLength( date:Date ):int {
			var newdate:Date = new Date( date );
			newdate.setMonth( date.getMonth() + 1 );
			newdate.setDate( 0 );
			return newdate.getDate();
		}
        
        
        /**
         * 指定の月の最初の曜日を調べます。
         * 
         * @param	fullyear 西暦
         * @param	month 月
         * @author  michi at seyself.com
         */
        public static function getFirstDay(fullyear:uint,month:uint):uint
        {
            var tmp:Date = new Date(fullyear,month,1);
            return tmp.getDay();
        }
        
        /**
         * うるう年かどうかを調べます.
         * 
         * @param	fullyear 西暦
         * @return  うるう年の場合はtrueを返します。
         * @author  michi at seyself.com
         */
        public static function isLeap( fullyear:uint ):Boolean
        {
            var flag:Boolean = false;
            if(((fullyear%4==0) && (fullyear%100!=0)) || (fullyear%400==0)) flag = true;
            return flag;
        }
        
        /**
         * 西暦を和暦に変換します.
         * 対応しているのは明治以降になります（1868年以降）
         * 
         * @param	fullyear 西暦
         * @return  和暦（例：H20）
         * @author  michi at seyself.com
         */
        public static function convertJCalendar( fullyear:uint ):String
        {
            var gengou:Array = ["M", "T", "S", "H"];
            var changeYear:Array = [1868, 1912, 1926, 1989];
            var str:String = "" , reki:uint = 0;
            var len:uint = changeYear.length;
            for (var i:int = len - 1; i > 0; i--) {
                if (fullyear >= changeYear[i]) {
                    str = gengou[i]; reki = fullyear - changeYear[i] + 1;
                    break;
                }
            }
            if (str) {
                return str + reki;
            }
            return "" + fullyear;
        }
        
        /**
         * 曜日名を取得します. <br />
		 * type の指定によって得られる値<br />
         * 0 : SUNDAY, MONDAY, TUSEDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY<br />
		 * 1 : Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday<br />
		 * 2 : sunday, monday, tuesday, wednesday, thursday, friday, saturday<br />
		 * 3 : SUN, MON, TUE, WED, THU, FRI, SAT<br />
		 * 4 : Sun, Mon, Tue, Wed, Thu, Fri, Sat<br />
		 * 5 : sun, mon, tue, wed, thu, fri, sat<br />
		 * 6 : 日曜日, 月曜日, 火曜日, 水曜日, 木曜日, 金曜日, 土曜日<br />
		 * 7 : 日, 月, 火, 水, 木, 金, 土<br />
		 * 
         * @param	index 曜日インデックス値
         * @param	type 取得する曜日名のタイプ（0から7まで）
         * @return  曜日名
         * @author  michi at seyself.com
         */
        public static function getWeekName( index:uint , type:uint=0 ):String
        {
            var week:Array;
            if(type==0)      week = ["SUNDAY","MONDAY","TUSEDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY"];
            else if(type==1) week = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
            else if(type==2) week = ["sunday","monday","tuesday","wednesday","thursday","friday","saturday"];
            else if(type==3) week = ["SUN","MON","TUE","WED","THU","FRI","SAT"];
            else if(type==4) week = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"];
            else if(type==5) week = ["sun","mon","tue","wed","thu","fri","sat"];
            else if(type==6) week = ["日曜日","月曜日","火曜日","水曜日","木曜日","金曜日","土曜日"];
            else if(type==7) week = ["日","月","火","水","木","金","土"];
            else             week = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"];
            return week[index];
        }
        
        /**
         * 月を示す文字列を返します. <br />
		 * type の指定によって得られる値<br />
         * 0 : JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER<br />
         * 1 : January, February, March, April, May, June, July, August, September, October, November, December<br />
         * 2 : january, february, march, april, may, june, july, august, september, october, november, december<br />
         * 3 : JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC<br />
         * 4 : Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec<br />
         * 5 : jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec<br />
         * 6 : 1月, 2月, 3月, 4月, 5月, 6月, 7月, 8月, 9月, 10月, 11月, 12月<br />
         * 7 : 睦月, 如月, 弥生, 卯月, 皐月, 水無月, 文月, 葉月, 長月, 神無月, 霜月, 師走<br />
		 * 
         * @param	index 月
         * @param	type 取得する月名のタイプ（0から7まで）
         * @return  月名
         * @author  michi at seyself.com
         */
        public static function getMonthName( index:uint , type:uint=0 ):String
        {
            var month:Array;
            if(type==0)      month = ["JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"];
            else if(type==1) month = ["January","February","March","April","May","June","July","August","September","October","November","December"];
            else if(type==2) month = ["january","february","march","april","may","june","july","august","september","october","november","december"];
            else if(type==3) month = ["JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"];
            else if(type==4) month = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
            else if(type==5) month = ["jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec"];
            else if(type==6) month = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"];
            else if(type==7) month = ["睦月","如月","弥生","卯月","皐月","水無月","文月","葉月","長月","神無月","霜月","師走"];
            else             month = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
            return month[index];
        }
        
        
	}
}






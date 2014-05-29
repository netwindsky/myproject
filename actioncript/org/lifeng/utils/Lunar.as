package org.lifeng.utils
{
	public class Lunar
	{
		private var lunarInfo:Array=new Array(
			0x04bd8,0x04ae0,0x0a570,0x054d5,0x0d260,0x0d950,0x16554,0x056a0,0x09ad0,0x055d2,
			0x04ae0,0x0a5b6,0x0a4d0,0x0d250,0x1d255,0x0b540,0x0d6a0,0x0ada2,0x095b0,0x14977,
			0x04970,0x0a4b0,0x0b4b5,0x06a50,0x06d40,0x1ab54,0x02b60,0x09570,0x052f2,0x04970,
			0x06566,0x0d4a0,0x0ea50,0x06e95,0x05ad0,0x02b60,0x186e3,0x092e0,0x1c8d7,0x0c950,
			0x0d4a0,0x1d8a6,0x0b550,0x056a0,0x1a5b4,0x025d0,0x092d0,0x0d2b2,0x0a950,0x0b557,
			0x06ca0,0x0b550,0x15355,0x04da0,0x0a5b0,0x14573,0x052b0,0x0a9a8,0x0e950,0x06aa0,
			0x0aea6,0x0ab50,0x04b60,0x0aae4,0x0a570,0x05260,0x0f263,0x0d950,0x05b57,0x056a0,
			0x096d0,0x04dd5,0x04ad0,0x0a4d0,0x0d4d4,0x0d250,0x0d558,0x0b540,0x0b6a0,0x195a6,
			0x095b0,0x049b0,0x0a974,0x0a4b0,0x0b27a,0x06a50,0x06d40,0x0af46,0x0ab60,0x09570,
			0x04af5,0x04970,0x064b0,0x074a3,0x0ea50,0x06b58,0x055c0,0x0ab60,0x096d5,0x092e0,
			0x0c960,0x0d954,0x0d4a0,0x0da50,0x07552,0x056a0,0x0abb7,0x025d0,0x092d0,0x0cab5,
			0x0a950,0x0b4a0,0x0baa4,0x0ad50,0x055d9,0x04ba0,0x0a5b0,0x15176,0x052b0,0x0a930,
			0x07954,0x06aa0,0x0ad50,0x05b52,0x04b60,0x0a6e6,0x0a4e0,0x0d260,0x0ea65,0x0d530,
			0x05aa0,0x076a3,0x096d0,0x04bd7,0x04ad0,0x0a4d0,0x1d0b6,0x0d250,0x0d520,0x0dd45,
			0x0b5a0,0x056d0,0x055b2,0x049b0,0x0a577,0x0a4b0,0x0aa50,0x1b255,0x06d20,0x0ada0,
			0x14b63);
		
		private var solarMonth:Array=new Array(31,28,31,30,31,30,31,31,30,31,30,31);
		private var Gan:Array=new Array("甲","乙","丙","丁","戊","己","庚","辛","壬","癸");
		private var Zhi:Array=new Array("子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥");
		private var Animals:Array=new Array("鼠","牛","虎","兔","龙","蛇","马","羊","猴","鸡","狗","猪");
		private var solarTerm:Array=new Array("小寒","大寒","立春","雨水","惊蛰","春分","清明","谷雨","立夏","小满","芒种","夏至","小暑","大暑","立秋","处暑","白露","秋分","寒露","霜降","立冬","小雪","大雪","冬至");
		private var nStr1:Array=new Array('日','一','二','三','四','五','六','七','八','九','十');
		private var nStr2:Array=new Array('初','十','廿');
		private var riarr:Array=["初一","初二","初三","初四","初五","初六","初七","初八","初九","初十","十一","十二","十三","十四","十五","十六","十七","十八","十九","二十","廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十","三十一"]
		private var yuearr:Array=['一','二','三','四','五','六','七','八','九','十',"十一","十二"];
		public function Lunar()
		{
		}
		private function lYearDays(y) {
			var sum=0;
			for (var i=0x8000; i>0x8; i>>=1) {
				sum += (lunarInfo[y-1900] & i)? 30: 29;
			}
			return (sum+leapDays(y));
		}
		private function leapDays(y) {
			if (leapMonth(y)) {
				return ((lunarInfo[y-1900] & 0x10000)? 30: 29);
			} else {
				return 0;
			}
		}
		private function leapMonth(y) {
			return (lunarInfo[y-1900] & 0xf);
		}
		private function monthDays(y,m) {
			return ( (lunarInfo[y-1900] & (0x10000>>m))? 30: 29 );
		}
		private function solarDays(y,m) {
			if (m==1) {
				return (((y%4 == 0) && (y%100 != 0) || (y%400 == 0))? 29: 28);
			} else {
				return (solarMonth[m]);
			}
		}
		public function cyclical(num) {
			return (Gan[num%10]+Zhi[num%12]);
		}
		public function calElement(lYear,lMonth,lDay,isLeap,cYear):Object {
			var date:Object =new Object();
			date.lYear=lYear;
			date.lMonth=lMonth;
			date.lDay=lDay;
			date.isLeap=isLeap;
			date.cYear=cYear;
			date.color="";
			date.lunarFestival="";
			date.solarFestival='';
			date.solarTerms='';
			return date;
		}
		public function getLunar(objDate:Date):Object {
			var date:Object =new Object();
			var i,leap=0,temp=0;
			var offset=(Date.UTC(objDate.getFullYear(),objDate.getMonth(),objDate.getDate()) - Date.UTC(1900,0,31))/86400000;
			for (i=1900; i<2050 && offset>0; i++) {
				temp=lYearDays(i);
				offset-=temp;
			}
			if (offset<0) {
				offset+=temp;
				i--;
			}
			date.year=i;
			leap=leapMonth(i);
			date.isLeap=false;
			for (i=1; i<13 && offset>0; i++) {
				if (leap>0 && i==(leap+1) && date.isLeap==false) {
					--i;
					date.isLeap=true;
					temp=leapDays(date.year);
				} else {
					temp=monthDays(date.year,i);
				}
				if (date.isLeap==true && i==(leap+1)) {
					date.isLeap=false;
				}
				offset-=temp;
			}
			if (offset==0&&leap>0&&i==leap+1) {
				if (date.isLeap) {
					date.isLeap=false;
				} else {
					date.isLeap=true;
					--i;
				}
			}
			if (offset<0) {
				offset+=temp;
				--i;
			}
			
			
			
			date.day=riarr[offset];
			date.month=yuearr[i-1];
			//trace("month",i);
			//date.day=offset+1;
			return date;
		}
	}
}
package  org.lifeng.utils{//日历类



	public class ChinaCalendar{

		function Calendar(y:int=0,m:uint=0,d:uint=0,h:uint=0,mi:uint=0,s:uint=0,zone:int=8) {
			year=y;
			month=m;
			date=d;
			hour=h;
			minutes=mi;
			seconds=s;
			timeZone=zone;
			week=getDay(y,m,d);
			zodiac=getZodiac(m,d);
		}

		var year:int;
		var month:uint;
		var date:uint;
		var hour:uint;
		var minutes:uint;
		var seconds:uint;
		var timeZone:int=8;
		var week:uint;
		var zodiac:uint;

		
		//返回本时间所处的节气
		public function getLastJieQi(y:uint,m:uint,d:uint,h:uint=12,mi:uint=30,s:uint=30,zone:int=8):String {
			return getJieQi(y,m,d,h,mi,s,4,zone);
		}
		//返回本时间所处的节
		public function getLastJie(y:uint,m:uint,d:uint,h:uint=12,mi:uint=30,s:uint=30,zone:int=8):String {
			return getJieQi(y,m,d,h,mi,s,5,zone);
		}
		//返回本时间所处的气
		public function getLastQi(y:uint,m:uint,d:uint,h:uint=12,mi:uint=30,s:uint=30,zone:int=8):String {
			return getJieQi(y,m,d,h,mi,s,6,zone);
		}
		//返回本时间的下一个节气
		public function getNextJieQi(y:uint,m:uint,d:uint,h:uint=12,mi:uint=30,s:uint=30,zone:int=8):String {
			return getJieQi(y,m,d,h,mi,s,7,zone);
		}
		//返回本时间的下一个节
		public function getNextJie(y:uint,m:uint,d:uint,h:uint=12,mi:uint=30,s:uint=30,zone:int=8):String {
			return getJieQi(y,m,d,h,mi,s,8,zone);
		}
		//返回本时间的下一个气
		public function getNextQi(y:uint,m:uint,d:uint,h:uint=12,mi:uint=30,s:uint=30,zone:int=8):String {
			return getJieQi(y,m,d,h,mi,s,9,zone);
		}
		//返回当日星期几
		public function getDay(y,m,d):uint {
			return erD(y,m,d)%7;
		}
		//返回当日星座
		public function getZodiac(m,d):uint {
			return sZod(m,d);
		}
		//返回农历年
		public function getNYear(ny:uint):String{
			var tg:Array=["癸 ","甲","乙","丙","丁","戊","己","庚","辛","壬"];
			var dz:Array=["亥","子","丑","寅","卯","辰","巳","午","未","申","酉","戌" ];
			var t:String=tg[((ny-3)%60)%10];
			var d:String=dz[((ny-3)%60)%12];
			trace(t,d);
			return t+d;
		}


		var lunarInfo:Array=
		[0x04bd8,0x04ae0,0x0a570,0x054d5,0x0d260,0x0d950,0x16554,0x056a0,0x09ad0,0x055d2,
		0x04ae0,0x0a5b6,0x0a4d0,0x0d250,0x1d255,0x0b540,0x0d6a0,0x0ada2,0x095b0,0x14977,
		0x04970,0x0a4b0,0x0b4b5,0x06a50,0x06d40,0x1ab54,0x02b60,0x09570,0x052f2,0x04970,
		0x06566,0x0d4a0,0x0ea50,0x06e95,0x05ad0,0x02b60,0x186e3,0x092e0,0x1c8d7,0x0c950,
		0x0d4a0,0x1d8a6,0x0b550,0x056a0,0x1a5b4,0x025d0,0x092d0,0x0d2b2,0x0a950,0x0b557,
		0x06ca0,0x0b550,0x15355,0x04da0,0x0a5d0,0x14573,0x052d0,0x0a9a8,0x0e950,0x06aa0,
		0x0aea6,0x0ab50,0x04b60,0x0aae4,0x0a570,0x05260,0x0f263,0x0d950,0x05b57,0x056a0,
		0x096d0,0x04dd5,0x04ad0,0x0a4d0,0x0d4d4,0x0d250,0x0d558,0x0b540,0x0b5a0,0x195a6,
		0x095b0,0x049b0,0x0a974,0x0a4b0,0x0b27a,0x06a50,0x06d40,0x0af46,0x0ab60,0x09570,
		0x04af5,0x04970,0x064b0,0x074a3,0x0ea50,0x06b58,0x055c0,0x0ab60,0x096d5,0x092e0,
		0x0c960,0x0d954,0x0d4a0,0x0da50,0x07552,0x056a0,0x0abb7,0x025d0,0x092d0,0x0cab5,
		0x0a950,0x0b4a0,0x0baa4,0x0ad50,0x055d9,0x04ba0,0x0a5b0,0x15176,0x052b0,0x0a930,
		0x07954,0x06aa0,0x0ad50,0x05b52,0x04b60,0x0a6e6,0x0a4e0,0x0d260,0x0ea65,0x0d530,
		0x05aa0,0x076a3,0x096d0,0x04bd7,0x04ad0,0x0a4d0,0x1d0b6,0x0d250,0x0d520,0x0dd45,
		0x0b5a0,0x056d0,0x055b2,0x049b0,0x0a577,0x0a4b0,0x0aa50,0x1b255,0x06d20,0x0ada0];

		function lYearDays(y:int):int {//====== 传回农历 y年的总天数
			var i:int,sum:int=348;
			for (i=0x8000; i>0x8; i>>=1) {
				if ((lunarInfo[y-1900] & i)!=0) {
					sum+=1;
				}
			}
			return (sum+leapDays(y));
		}

		function leapDays(y:int):int {//====== 传回农历 y年闰月的天数
			if (leapMonth(y)!=0) {
				if ((lunarInfo[y-1900] & 0x10000)!=0) {
					return 30;
				} else {
					return 29;
				}
			} else {
				return 0;
			}
		}
		function leapMonth(y:int):int {//====== 传回农历 y年闰哪个月 1-12 , 没闰传回 0
			return (int)(lunarInfo[y-1900] & 0xf);
		}




		//判断Gregorian历还是Julian历  
		function ifGr(y:uint,m:uint,d:uint,opt:uint=1):Number {//阳历y年m月(1,2,..,12,下同)d日,opt=1,2,3分别表示标准日历,Gregorge历和Julian历

			if (opt==1) {
				if (y>1582||(y==1582&&m>10)||(y==1582&&m==10&&d>14)) {
					return (1);//Gregorian
				} else if (y==1582&&m==10&&d>=5&&d<=14) {//空
					return (-1);
				} else {//Julian
					return (0);
				}
			}

			if (opt==2) {
				return (1);
			}//Gregorian
			if (opt==3) {
				return (0);
			}//Julian
			return -2;
		}
		//日差天数 在当年走过的日数
		public function D0(y:uint,m:uint,d:uint):uint {
			var ifG:int=ifGr(y,m,d,1);
			var monL:Array=new Array(0,31,28,31,30,31,30,31,31,30,31,30,31);
			if (ifG) {
				if (y%100!=0&&y%4==0||y%400==0) {
					monL[2]+=1;
				} else {

				}
			} else if (y%4==0) {
				monL[2]+=1;
			} else {

			}
			var v:int=0;
			for (var i:int=0; i<=m-1; i++) {
				v+=monL[i];
			}
			v+=d;
			if (y==1582) {
				if (ifG==1) {
					v-=10;
				}
				if (ifG==-1) {
					v=1/0;
				}//infinity 
			}
			return v;
		}

		//反日差天數 求出在Y年过了X天以后的月和日
		function antiD0(y:uint,x:uint):uint {
			var m:uint=1;
			for (var j:uint=1; j<=12; j++) {
				var mL:int=D0(y,j+1,1)-D0(y,j,1);
				if (x<=mL||j==12) {
					m=j;
					break;
				} else {
					x-=mL;
				}
			}
			return 100*m+x;
		}

		//年差天數
		public function D(y:int):int {
			var v:Number=(y-1)*365+floor((y-1)/4);//Julian的年差天數
			if (y>1582) {
				v+=-floor((y-1)/100)+floor((y-1)/400);
			}//Gregorian的年差天數
			return v;
		}
		//等效標準天數
		function erD(y:uint,m:uint,d:uint):Number {
			var v:Number=(y-1)*365+floor((y-1)/4)+D0(y,m,d)-2;//Julian的等效標準天數
			if (y>1582) {
				v+=-floor((y-1)/100)+floor((y-1)/400)+2;
			}//Gregorian的等效標準天數
			return v;
		}
		//儒略日
		function JD(y:uint,m:uint,d:uint,h:Number,min:Number,sec:Number,zone:Number):Number {
			var ifG:Number=ifGr(y,m,d,1);
			var jt:Number=(h+(min+sec/60)/60)/24-0.5-zone/24;
			var jd:Number=(ifG)?(erD(y,m,d)+1721425+jt):(erD(y,m,d)+1721425+jt);//儒略日
			return jd;
		}



		//星座
		function sZod(m,d) {
			var zodd=new Array(1221,119,218,320,419,520,621,722,822,922,1023,1122,1221);
			var i=0;
			if ((100*m+d)>zodd[0]||(100*m+d)<=zodd[1]) {
				i=0;
			} else {
				for (i=1; i<12; i++) {
					if ((100*m+d)>zodd[i]&&(100*m+d)<=zodd[i+1]) {
						break;
					}
				}
			}
			return i;
		}



		///-----農暦節氣函數----/////
		public function getJieQi(y,m,d,h:uint=12,mi:uint=30,s:uint=30,a:uint=2,zone:int=8) {//获得节气，zone参数是时区。 a参数1、2为显示节气（假如当日是），3为当日的节气，4为当时所处的节气；5为当时所处的节，6为当时所处的气。7为下个节气，8为下个节，9为下个气,0为当月节气全部信息


			function S(y,n,pd) {//pd取值為0或1，分別表示平氣和定氣,該函數返回節氣的D0值
				var yk=365.2423112;///yk=365.2422226;0.00008894
				var jk=y-2100;
				var j=0.000088931/3400*jk;
				if (y<2200) {
					j=0;
				}
				var yk2=yk-j;
				var juD=y*(yk2-6.4e-14*(y-100)*(y-100)-3.047e-8*(y-100))+15.218427*n+1721050.71301;//儒略日
				var tht=3e-4*y-0.372781384-0.2617913325*n;//角度
				var yrD=(1.945*sin(tht)-0.01206*sin(2*tht))*(1.048994-2.583e-5*y);//年差實均數
				var shuoD=-18e-4*sin(2.313908653*y-0.439822951-3.0443*n);//朔差實均數
				var vs=(pd)?(juD+yrD+shuoD-erD(y,1,0)-1721425):(juD-erD(y,1,0)-1721425);
				return vs;
			}
			var ykche=new Array(///史實平氣擬合1
			'1640650.479938','1642476.703182','1683430.515601','1752157.640664','1807675.003759','1883627.765182','1907369.128100','1936603.140413','1939145.524180','1947180.798300','1964362.041824','1987372.340971',
			'1999653.819126','2007445.469786','2021324.917146','2047257.232342','2070282.898213','2073204.872850','2080144.500926','2086703.688963','2110033.182763','2111190.300888','2113731.271005','2120670.840263','2123973.309063',
			'2125068.997336','2136026.312633','2156099.495538','2159021.324663','2162308.575254','2178485.706538','2178759.662849','2185334.020800','2187525.481425','2188621.191481');

			var kche=new Array(///史實平氣擬合2
			'-221','-216','-104','84','236','444','509','589','596','618','665','728','761','783','821','892','955','963','982','1000','1063','1067','1074','1093','1102','1105','1135','1190','1198','1207',
			'1251','1252','1270','1276','1279');
			var jkche=new Array(////史實平氣擬合3
			'15.21842500','15.21874996',' 15.218750011','15.218749978','15.218620279','15.218612292','15.218449176','15.218425000','15.218466998',' 15.218524844','15.218533526','15.218513908','15.218530782',
			'15.218535181','15.218526248','15.218519654','15.218425000','15.218515221','15.218530782','15.218523776','15.218425000','15.218425000','15.218515671','15.218425000','15.218425000','15.218477932','15.218472436',
			'15.218425000','15.218425000','15.218461742','15.218425000','15.218445786','15.218425000','15.218425000','15.218437484');
			var jkche2=new Array(///史實平氣擬合4
			-3,-3,0,4,4,3,3,4,3,3,4,4,19,3,3,3,4,4,4,3,0,4,3,3,4,4,4,3,3,3,10,4,4,4,4);

			function S2(y,m,d,h:uint=20,mi:uint=0,s:uint=0,n:int=8) {///從-221到1645史實平氣,該函數返回史實平節氣的D0值
				var jeJD=round(JD(y,m,d,h,mi,s,n)*1000)/1000;
				var ykd=(round(JD(y,1,1,h,mi,s,n)*1000)/1000)-1;
				var jkk=0;
				if (jeJD>1642468) {
					jkk=1;
				}
				if (jeJD>=1683438) {
					jkk=2;
				}
				if (jeJD>=1752164) {
					jkk=3;
				}
				if (jeJD>=1807682) {
					jkk=4;
				}
				if (jeJD>=1883654) {
					jkk=5;
				}
				if (jeJD>=1907395) {
					jkk=6;
				}
				if (jeJD>=1936615) {
					jkk=7;
				}
				if (jeJD>=1939172) {
					jkk=8;
				}
				if (jeJD>=1947207) {
					jkk=9;
				}
				if (jeJD>=1964374) {
					jkk=10;
				}
				if (jeJD>=1987385) {
					jkk=11;
				}
				if (jeJD>=1999683) {
					jkk=12;
				}
				if (jeJD>=2007445) {
					jkk=13;
				}
				if (jeJD>=2021325) {
					jkk=14;
				}
				if (jeJD>=2047258) {
					jkk=15;
				}
				if (jeJD>=2070297) {
					jkk=16;
				}
				if (jeJD>=2073219) {
					jkk=17;
				}
				if (jeJD>=2080158) {
					jkk=18;
				}
				if (jeJD>=2086705) {
					jkk=19;
				}
				if (jeJD>=2110050) {
					jkk=20;
				}
				if (jeJD>=2111205) {
					jkk=21;
				}
				if (jeJD>=2113733) {
					jkk=22;
				}
				if (jeJD>=2120673) {
					jkk=23;
				}
				if (jeJD>=2123988) {
					jkk=24;
				}
				if (jeJD>=2125084) {
					jkk=25;
				}
				if (jeJD>=2136042) {
					jkk=26;
				}
				if (jeJD>=2156102) {
					jkk=27;
				}
				if (jeJD>=2159024) {
					jkk=28;
				}
				if (jeJD>=2162311) {
					jkk=29;
				}
				if (jeJD>=2178503) {
					jkk=30;
				}
				if (jeJD>=2178776) {
					jkk=31;
				}
				if (jeJD>=2185350) {
					jkk=32;
				}
				if (jeJD>=2187542) {
					jkk=33;
				}
				if (jeJD>=2188637) {
					jkk=34;
				}
				var yk2=ykche[jkk];///初數
				var k=kche[jkk];//年界
				var jk=jkche[jkk];////氣長
				var jk9=jkche2[jkk];///節差數
				var yk3=jk*(jk9*1);
				var yk=(yk2*1)-(yk3*1);
				var jq=jk*(n+(24*(y-k-1)));
				var vj=jq+yk-ykd+0.5;
				var yIf=(y>=-220);
				if (! yIf||y>1646||y==1646&&m>=1) {
					vj="";
				}
				return vj;
			}
			var mL=D0(y,m+1,1)-D0(y,m,1);
			if (y==1582&&m==10) {
				mL=31;
			}

			var yr2=''+y+'年';
			if (y<=0) {
				yr2='前'+(-y+1)+'年';
			}
			var sT00='';
			var sT0='';
			var sT1='';
			var sT2='';
			var sT3='';
			var sT4='';
			var qSt='';
			var sDsStr1='';
			var ifsj1='';////節氣
			var sN00=2*m-3;
			var sDt00=S(y,sN00,1);
			if (a==3) {
				sDt00=S2(y,m,d,sN00);
			}
			var sD00=antiD0(y,floor(sDt00));
			var sM00=floor(sD00/100);///節氣交接公暦月。
			var sDate00=sD00%100;
			var sN0=2*m-2;
			var sDt0=S(y,sN0,1);
			if (a==3) {
				sDt0=S2(y,m,d,sN0);
			}
			var sD0=antiD0(y,floor(sDt0));
			var sM0=floor(sD0/100);
			var sDate0=sD0%100;
			var sN1=2*m-1;
			var sDt1=S(y,sN1,1);
			if (a==3) {
				sDt1=S2(y,m,d,sN1);
			}
			var sD1=antiD0(y,floor(sDt1));
			var sM1=floor(sD1/100);
			var sDate1=sD1%100;
			var sN2=2*m;
			var sDt2=S(y,sN2,1);
			if (a==3) {
				sDt2=S2(y,m,d,sN2);
			}
			var sD2=antiD0(y,floor(sDt2));
			var sM2=floor(sD2/100);
			var sDate2=sD2%100;
			if (y==1582&&m==10) {
				sDate2=sDate2+10;
			}

			var sN3=2*m+1;
			if (sN3>24) {
				sN3=25;
			}
			var sDt3=S(y,sN3,1);
			if (a==3) {
				sDt3=S2(y,m,d,sN3);
			}
			var sD3=antiD0(y,floor(sDt3));
			var sM3=floor(sD3/100);
			var sDate3=sD3%100;

			sN00=rem(sN00-1,24)+1;
			sN0=rem(sN0-1,24)+1;
			sN1=rem(sN1-1,24)+1;
			sN2=rem(sN2-1,24)+1;
			sN3=rem(sN3-1,24)+1;
			if (sDate2>mL) {
				sDate2-=mL;
			}
			var jqk=D0(y,m,d);
			var currentTime=jqk;
			var qk00=floor(sDt00);
			var qk0=floor(sDt0);
			var qk1=floor(sDt1);
			var qk2=floor(sDt2);
			var qk3=floor(sDt3);
			if (qk00<D0(y,m,1)||qk00>D0(y,m,mL)) {
				sN00='';
			}
			if (qk0<D0(y,m,1)||qk0>D0(y,m,mL)) {
				sN0='';
			}
			if (qk1<D0(y,m,1)||qk1>D0(y,m,mL)) {
				sN1='';
			}
			if (qk2<D0(y,m,1)||qk2>D0(y,m,mL)) {
				sN2='';
			}
			if (qk3<D0(y,m,1)||qk3>D0(y,m,mL)) {
				sN3='';
			}//
			sT00='%公暦'+yr2+sM00+'月'+sDate00+'日'+'東8區'+doubleTimeTo24(tail(sDt00))+' 定'+strSolarTerm(sN00)+'<br>';

			if (sN00=='') {
				sT00='';
			}
			sT0='*公暦'+yr2+sM0+'月'+sDate0+'日'+'東8區'+doubleTimeTo24(tail(sDt0))+' 定'+strSolarTerm(sN0)+'<br>';
			if (sN0=='') {
				sT0='';
			}
			sT1='&公暦'+yr2+sM1+'月'+sDate1+'日'+'東8區'+doubleTimeTo24(tail(sDt1))+' 定'+strSolarTerm(sN1)+'<br>';
			if (sN1=='') {
				sT1='';
			}
			sT2='$公暦'+yr2+sM2+'月'+sDate2+'日'+'東8區'+doubleTimeTo24(tail(sDt2))+' 定'+strSolarTerm(sN2);
			if (sN2=='') {
				sT2='';
			}
			if (sN2=='') {
				sT2='';
			}
			sT3='<br>'+'#公暦'+yr2+sM3+'月'+sDate3+'日'+'東8區'+doubleTimeTo24(tail(sDt3))+' 定'+strSolarTerm(sN3);
			if (sN3=='') {
				sT3='';
			}
			var qSt5='';
			if (a==1) {
				qSt5='定';
			}
			if (a==2) {
				qSt5='<font color=#808000>'+'◆</font>';
			}
			if (jqk==qk00) {
				if (sT00=='') {
					sDsStr1='|';
				} else {
					sDsStr1=qSt5+strSolarTerm(sN00)+':東8區'+doubleTimeTo24(tail(sDt00));
				}
			}
			if (jqk==qk0) {
				if (sT0=='') {
					sDsStr1='|';
				} else {
					sDsStr1=qSt5+strSolarTerm(sN0)+':東8區'+doubleTimeTo24(tail(sDt0));
				}
			}
			if (jqk==qk1) {
				if (sN1=='') {
					sDsStr1='|';
				} else {
					sDsStr1=qSt5+strSolarTerm(sN1)+':東8區'+doubleTimeTo24(tail(sDt1));
				}
			}
			if (jqk==qk2) {
				if (sN2=='') {
					sDsStr1='|';
				} else {
					sDsStr1=qSt5+strSolarTerm(sN2)+':東8區'+doubleTimeTo24(tail(sDt2));
				}
			}///
			if (jqk==qk3) {
				if (sT3=='') {
					sDsStr1='|';
				} else {
					sDsStr1=qSt5+strSolarTerm(sN3)+':東8區'+doubleTimeTo24(tail(sDt3));
				}

			}
			if (jqk==qk00) {
				if (sT00=='') {
					qSt='';
				} else {
					qSt=strSolarTerm(sN00);
				}
			}
			if (jqk==qk0) {
				if (sT0=='') {
					qSt='';
				} else {
					qSt=strSolarTerm(sN0);
				}
			}
			if (jqk==qk1) {
				if (sT1=='') {
					qSt='';
				} else {
					qSt=strSolarTerm(sN1);
				}
			}
			if (jqk==qk2) {
				if (sT2=='') {
					qSt='';
				} else {
					qSt=strSolarTerm(sN2);
				}
			}
			if (jqk==qk3) {
				if (sT3=='') {
					qSt='';
				} else {
					qSt=strSolarTerm(sN3);
				}
			}
			var toDayIn:String;
			if (jqk<=qk2) {
				if (sT2=='') {
					toDayIn='';
				} else {
					toDayIn=strSolarTerm(oToTop(sN2-1,24));
				}
			}
			if (jqk<=qk1) {
				if (sT1=='') {
					toDayIn='';
				} else {
					toDayIn=strSolarTerm(oToTop(sN1-1,24));
				}
			}
			if (jqk>=qk2) {
				if (sT2=='') {
					toDayIn='';
				} else {
					toDayIn=strSolarTerm(sN2);
				}
			}
			function oToTop(num:int,top:int):int {
				if (num<=0) {
					num=top;
				}
				return num;
			}
			//定义取的两个节气和当前输入日的精确时间
			var sT1Time:Number=sM1*100+sDate1+tail(sDt1);
			var sT2Time:Number=sM2*100+sDate2+tail(sDt2);
			var sTNowTime:Number=m*100+d+turnTimeDouble(h,mi,s);
			function turnTimeDouble(h:uint,mi:uint,s:uint):Number {//取得时间在当日的小数
				h=h*60*60;
				mi=mi*60;
				var re:Number=(h+mi+s)/86400;
				return re;
			}
			//
			function lastJieQi():uint {//得到上个节气（当前所在的）

				if (sTNowTime<sT2Time) {
					return oToTop(sN2-1,24);
				}
				if (sTNowTime<sT1Time) {
					return oToTop(sN1-1,24);
				}
				if (sTNowTime>=sT2Time) {
					return sN2;
				}
				return 0;

			}
			function lastJie():uint {//得到上个节
				var nowJieQiIs:uint;
				if (sTNowTime<sT2Time) {
					nowJieQiIs=oToTop(sN2-1,24);
				}
				if (sTNowTime<sT1Time) {
					nowJieQiIs=oToTop(sN1-1,24);
				}
				if (sTNowTime>=sT2Time) {
					nowJieQiIs=sN2;
				}
				if (nowJieQiIs/2>floor(nowJieQiIs/2)) {

				} else {
					nowJieQiIs-=1;
				}
				return nowJieQiIs;
			}
			function lastQi():uint {//得到上个气

				var nowJieQiIs:uint;
				if (sTNowTime<sT2Time) {
					nowJieQiIs=oToTop(sN2-1,24);
				}
				if (sTNowTime<sT1Time) {
					nowJieQiIs=oToTop(sN1-1,24);
				}
				if (sTNowTime>=sT2Time) {
					nowJieQiIs=sN2;
				}
				if (nowJieQiIs/2>floor(nowJieQiIs/2)) {
					nowJieQiIs=(oToTop(nowJieQiIs-1,24));
				} else {

				}
				return nowJieQiIs;
			}
			function nextJieQi() {//得到下个节气

				var nowJieQiIs:uint;
				nowJieQiIs=lastJieQi()+1;
				if (nowJieQiIs>=25) {
					nowJieQiIs=1;
				}
				return nowJieQiIs;
			}
			function nextJie() {//得到下个节

				var nowJieQiIs:uint;
				nowJieQiIs=lastJie()+2;
				if (nowJieQiIs>=25) {
					nowJieQiIs=1;
				}
				return nowJieQiIs;
			}
			function nextQi() {//得到下个气

				var nowJieQiIs:uint;
				nowJieQiIs=lastQi()+2;
				if (nowJieQiIs>=25) {
					nowJieQiIs=2;
				}
				return nowJieQiIs;
			}



			if (a==1) {
				return sDsStr1;
			} else {
				if (a==2) {
					return qSt;
				} else {
					if (a==13) {
						return qSt;
					} else {
						if (a==3) {
							return toDayIn;
						} else {
							switch (a) {
								case 4 :
									return strSolarTerm(lastJieQi());
									break;
								case 5 :
									return strSolarTerm(lastJie());
									break;
								case 6 :
									return strSolarTerm(lastQi());
									break;
								case 7 :
									return strSolarTerm(nextJieQi());
									break;
								case 8 :
									return strSolarTerm(nextJie());
									break;
								case 9 :
									return strSolarTerm(nextQi());
									break;
							}
							return sT00+sT0+sT1+sT2+sT3;
						}
					}
				}
			}
			function strSolarTerm(num:Number):String {//生成字符串节气
				var str:String;
				switch (num) {
					case 1 :
						str="小寒";
						break;
					case 2 :
						str="大寒";
						break;
					case 3 :
						str="立春";
						break;
					case 4 :
						str="雨水";
						break;
					case 5 :
						str="惊蛰";
						break;
					case 6 :
						str="春分";
						break;
					case 7 :
						str="清明";
						break;
					case 8 :
						str="谷雨";
						break;
					case 9 :
						str="立夏";
						break;
					case 10 :
						str="小满";
						break;
					case 11 :
						str="芒种";
						break;
					case 12 :
						str="夏至";
						break;
					case 13 :
						str="小暑";
						break;
					case 14 :
						str="大暑";
						break;
					case 15 :
						str="立秋";
						break;
					case 16 :
						str="处暑";
						break;
					case 17 :
						str="白露";
						break;
					case 18 :
						str="秋分";
						break;
					case 19 :
						str="寒露";
						break;
					case 20 :
						str="霜降";
						break;
					case 21 :
						str="立冬";
						break;
					case 22 :
						str="小雪";
						break;
					case 23 :
						str="大雪";
						break;
					case 24 :
						str="冬至";
						break;

				}
				return String(str);
			}
		}
		/////

		function doubleTimeTo24(dTime:Number):String {//将小数转换为24小时制时间  返回字符串
			var hTime:uint=floor(24*dTime);
			var mTime:uint=floor((24*dTime-hTime)*60);
			var sTime:uint=floor(((24*dTime-hTime)*60-mTime)*60);
			return String(hTime+":"+mTime+":"+sTime);
		}




		function PI() {
			return Math.PI;
		}

		function sin(x) {
			return Math.sin(x);
		}

		function cos(x) {
			return Math.cos(x);
		}

		function abs(x) {
			return Math.abs(x);
		}

		function floor(x) {
			return Math.floor(x);
		}

		function round(x) {
			return Math.round(x);
		}

		function tail(x) {
			return x-floor(x);
		}

		function rem(x,w) {//廣義求余
			return tail(x/w)*w;
		}
		

	}
}
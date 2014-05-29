package org.lifeng.application.weather
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.flash_proxy;
	import flash.utils.setInterval;
	
	import org.lifeng.events.CustomEvent;

	public class WeatherManager extends EventDispatcher
	{
		public static const BEIJING:String="101010100";
		public static const SHANGHAI:String="101020100";
		public static const DAQING:String="101050901";
		private var _city:String=DAQING;
		public function WeatherManager()
		{
		}
		public function loadWeatherInfo(city:String):void{
			_city=city;
			var loader:URLLoader=new URLLoader();
			trace("http://m.weather.com.cn/data/"+city+".html");
			loader.load(new URLRequest("http://m.weather.com.cn/data/"+city+".html?"+Math.random()));
			loader.addEventListener(IOErrorEvent.IO_ERROR,loaderweatherinfoerror);
			loader.addEventListener(Event.COMPLETE,getWeatherHandler);
		}
		
		protected function loaderweatherinfoerror(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			//loadWeatherInfo(event.);
			trace("ioerror--->>",_city);
			loadWeatherInfo(_city);
			
		}
		private function getWeatherHandler(e:Event):void{
			trace(e.target.data);
			/*
			
			{"weatherinfo":{
			"city":"北京","city_en":"beijing","date_y":"2012年11月6日","date":"","week":"星期二","fchh":"11","cityid":"101010100",
			
			"temp1":"12℃~-1℃","temp2":"11℃~-2℃","temp3":"10℃~1℃","temp4":"8℃~2℃","temp5":"6℃~-2℃","temp6":"7℃~-3℃",
			
			"tempF1":"53.6℉~30.2℉","tempF2":"51.8℉~28.4℉","tempF3":"50℉~33.8℉","tempF4":"46.4℉~35.6℉","tempF5":"42.8℉~28.4℉","tempF6":"44.6℉~26.6℉",
			
			"weather1":"晴","weather2":"多云转晴","weather3":"晴","weather4":"多云转雨夹雪","weather5":"小雪转多云","weather6":"晴",
			
			"img1":"0","img2":"99","img3":"1","img4":"0","img5":"0","img6":"99","img7":"1","img8":"6","img9":"14","img10":"1","img11":"0","img12":"99",
			
			"img_single":"0",
			
			"img_title1":"晴","img_title2":"晴","img_title3":"多云","img_title4":"晴","img_title5":"晴","img_title6":"晴","img_title7":"多云","img_title8":"雨夹雪","img_title9":"小雪","img_title10":"多云","img_title11":"晴","img_title12":"晴",
			
			"img_title_single":"晴",
			"wind1":"微风","wind2":"���风","wind3":"微风","wind4":"微风","wind5":"微风转北风4-5级","wind6":"北风4-5级转微风",
			"fx1":"微风","fx2":"微风",
			"fl1":"小于3级","fl2":"小于3级","fl3":"小于3级","fl4":"小于3级","fl5":"小于3级转4-5级","fl6":"4-5级转小于3级",
			"index":"凉","index_d":"天气凉，建议着厚外套加毛衣等春秋服装。体弱者宜着大衣、呢外套。因昼夜温差较大，注意增减衣服。",
			"index48":"凉","index48_d":"天气凉，建议着厚外套加毛衣等春秋服装。体弱者宜着大衣、呢外套。因昼夜温差较大，注意增减衣服。",
			"index_uv":"中等","index48_uv":"弱","index_xc":"适宜","index_tr":"适宜","index_co":"较舒适","st1":"12","st2":"-1","st3":"12","st4":"0","st5":"9","st6":"2","index_cl":"适宜","index_ls":"基本适宜","index_ag":"极不易发"}}
			
			*/
			var obj:Object=JSON.parse(e.target.data);
			var weather:Object=obj.weatherinfo;
			trace("城市：",weather.city);
			trace("日期：",weather.date_y,weather.week);
			trace("温度范围：",weather.temp1);
			trace("风力：",weather.wind1);
			trace("穿衣指数：",weather.index_d);
			trace("图片：",weather.img1,weather.img2,weather.img3);
			trace(weather.date_y,weather.week,weather.city,weather.weather1,weather.temp1,weather.wind1,weather.index,"\n"+weather.index_d);
			
			var obj:Object=new Object();
			obj.city=weather.city;
			obj.wdfw=weather.temp1;
			obj.fl=weather.wind1.split("转")[0];
			obj.weather=weather.weather1//.split("转")[0];
			
			obj.fweather=weather.weather2;
			obj.sweather=weather.weather3;
			obj.tweather=weather.weather4;
			
			obj.fwdfw=weather.temp2;
			obj.swdfw=weather.temp3;
			obj.twdfw=weather.temp4;
			
			obj.weathericon=getImageID(weather.img1,weather.img2);
			obj.fweathericon=getImageID(weather.img3,weather.img4);
			obj.sweathericon=getImageID(weather.img5,weather.img6);
			obj.tweathericon=getImageID(weather.img7,weather.img8);
			/*if(weather.img3=="99"){
				obj.fweathericon=weather.img1;
			}else{
				obj.fweathericon=weather.img2;
			}
			if(weather.img3=="99"){
				obj.sweathericon=obj.fweathericon;
			}else{
				obj.sweathericon=weather.img3;
			}
			if(weather.img4=="99"){
				obj.tweathericon=obj.sweathericon;
			}else{
				obj.tweathericon=weather.img4;
			}
			*/
			
			trace("first:",obj.fweather,obj.fwdfw);
			trace("second:",obj.sweather,obj.swdfw);
			trace("thrid:",obj.tweather,obj.twdfw);
			
			
			
			dispatchEvent(new CustomEvent("wether",obj));
			
			loadRealTimeWeather(DAQING);
			
			//mb.callWeiboAPI("2/statuses/update",{status:""+weather.date_y+" "+weather.week+" "+date.hours+":"+date.minutes+" "+weather.city+" "+weather.weather1+" "+weather.temp1+" "+weather.wind1+" "+weather.index+" "+"\n"+weather.index_d+"@疯子痴语"},"POST");
			
			//var xml:XML=new XML(e.target.data);
			//var xl:XMLList=xml.city.(@pyName=="beijing");
			
			//trace("城市：",xl.@quName);
			//trace("天气：",xl.@stateDetailed);
			//trace("温度：",xl.@tem1+"~"+xl.@tem2+"℃");
			//trace(xl.@quName,xl.@stateDetailed,xl.@tem1+"~"+xl.@tem2+"℃",xl.@windState);
			
		}
		public function getImageID(day:int,night:int):int{
			if(night!=99){
				return Math.max(day,night);
			}else{
				return day;
			}
		}
		public function loadLifeExponent(city:String):void{
			//http://m.weather.com.cn/zs/101050901.html
			var loader:URLLoader=new URLLoader();
			trace("http://m.weather.com.cn/zs/"+city+".html");
			loader.load(new URLRequest("http://m.weather.com.cn/zs/"+city+".html?"+Math.random()));
			loader.addEventListener(IOErrorEvent.IO_ERROR,loadlifeexponentHandler);
			loader.addEventListener(Event.COMPLETE,getlifeExponentHandler);
		}
		
		protected function loadlifeexponentHandler(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			loadLifeExponent(_city);
		}		
		
		
		protected function getlifeExponentHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("---------->>>>>",event.target.data);
			/*{"zs":{"date":"201211101915","ac_name":"空调开启指数","ac_hint":"开启制暖空调","ac_des":"您将感到有些冷，可以适当开启制暖空调调节室内温度，以免着凉感冒。","ag_name":"息斯敏过敏指数","ag_hint":"极不易发","ag_des":"天气条件极不易诱发过敏，有降雪，出行注意保暖。","cl_name":"晨练指数","cl_hint":"不宜","cl_des":"有降水，且早晨天气寒冷，风力稍大，请尽量避免户外晨练，若坚持晨练请带上雨具并注意保暖防冻。","co_name":"舒适度指数","co_hint":"较不舒适","co_des":"有降雪，且天气较冷，感觉不很舒适，请注意添加衣物。","ct_name":"穿衣指数","ct_hint":"冷","ct_des":"天气冷，建议着棉衣、皮夹克加羊毛衫等冬季服装。年老体弱者宜着厚棉衣或冬大衣。","dy_name":"钓鱼指数","d*/
			try{
				var obj:Object=JSON.parse(event.target.data);
				var zs:Object=obj.zs;
				//ct_des: "天气冷，建议着棉衣、皮夹克加羊毛衫等冬季服装。年老体弱者宜着厚棉衣或冬大衣。"
				//ct_hint: "冷"
				//ct_name: "穿衣指数"
				//pl_des: "气象条件有利于空气污染物稀释、扩散和清除，可在室外正常活动。"
				//pl_hint: "良"
				//pl_name: "空气污染扩散条件指数"
				//trace(zs.ct_name,zs.ct_hint,zs.ct_des);
				//trace(zs.pl_name,zs.pl_hint,zs.pl_des);
				//"uv_name":"紫外线强度指数",
				//"uv_hint":"弱",
				//"uv_des":"紫外线强度较弱，建议出门前涂擦SPF在12-15之间、PA+的防晒护肤品。",
				//"gm_name":"感冒指数",
				//"gm_hint":"极易发",
				//"gm_des":"天气寒冷，昼夜温差大且风力较强，易发生感冒，请注意适当增减衣服，加强自我防护避免感冒。",
				var zsobj:Object=new Object();
				zsobj.ctname=zs.ct_name;
				zsobj.cthint=zs.ct_hint;
				zsobj.ctdes=zs.ct_des;
				
				zsobj.plname=zs.pl_name;
				zsobj.plhint=zs.pl_hint;
				zsobj.pldes=zs.pl_des;
				
				zsobj.uvname=zs.uv_name;
				zsobj.uvhint=zs.uv_hint;
				zsobj.uvdes=zs.uv_des;
				
				zsobj.gmname=zs.gm_name;
				zsobj.gmhint=zs.gm_hint;
				zsobj.gmdes=zs.gm_des;
				dispatchEvent(new CustomEvent("zs",zsobj));
			}catch(e:Error){
				setInterval(function ():void{
				loadLifeExponent(WeatherManager.DAQING);
				},1000);
			}
			
			
		}
		public function loadRealTimeWeather(city:String):void{
			
			/*
			<sktq id="101010100" ptime="12-11-06 14:00" city="北京_南郊观象台">
			<qw h="14" wd="11" fx="245" fl="2" js="0" sd="42"/>
			<qw h="13" wd="11" fx="200" fl="2" js="0" sd="42"/>
			<qw h="12" wd="10" fx="247" fl="2" js="0" sd="43"/>
			<qw h="11" wd="9" fx="278" fl="2" js="0" sd="44"/>
			<qw h="10" wd="8" fx="47" fl="2" js="0" sd="49"/>
			<qw h="09" wd="6" fx="347" fl="1" js="0" sd="56"/>
			<qw h="08" wd="3" fx="47" fl="1" js="0" sd="69"/>
			<qw h="07" wd="1" fx="65" fl="1" js="0" sd="82"/>
			<qw h="06" wd="2" fx="80" fl="1" js="0" sd="77"/>
			<qw h="05" wd="2" fx="27" fl="2" js="0" sd="80"/>
			<qw h="04" wd="3" fx="87" fl="1" js="0" sd="72"/>
			<qw h="03" wd="3" fx="77" fl="1" js="0" sd="66"/>
			<qw h="02" wd="5" fx="23" fl="2" js="0" sd="54"/>
			<qw h="01" wd="5" fx="343" fl="2" js="0" sd="52"/>
			<qw h="00" wd="6" fx="337" fl="2" js="0" sd="50"/>
			<qw h="23" wd="6" fx="338" fl="2" js="0" sd="52"/>
			<qw h="22" wd="6" fx="334" fl="2" js="0" sd="49"/>
			<qw h="21" wd="6" fx="315" fl="1" js="0" sd="48"/>
			<qw h="20" wd="7" fx="331" fl="2" js="0" sd="46"/>
			<qw h="19" wd="7" fx="350" fl="2" js="0" sd="44"/>
			<qw h="18" wd="8" fx="347" fl="2" js="0" sd="43"/>
			<qw h="17" wd="8" fx="349" fl="3" js="0" sd="41"/>
			<qw h="16" wd="10" fx="314" fl="2" js="0" sd="37"/>
			<qw h="15" wd="10" fx="329" fl="4" js="0" sd="36"/>
			<qw h="14" wd="10" fx="345" fl="4" js="0" sd="36"/>
			</sktq>
			*/
			
			//http://flash.weather.com.cn/sk2/101010100.xml
			
			
			var loader:URLLoader=new URLLoader();
			trace("http://flash.weather.com.cn/sk2/"+city+".xml");
			loader.load(new URLRequest("http://flash.weather.com.cn/sk2/"+city+".xml?"+Math.random()));
			loader.addEventListener(IOErrorEvent.IO_ERROR,realtimeerrorHandler);
			loader.addEventListener(Event.COMPLETE,getRealTimeHandler);
		}
		
		protected function realtimeerrorHandler(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			loadRealTimeWeather(_city);
		}
		
		protected function getRealTimeHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			trace(event.target.data);
			var xml:XML=new XML(event.target.data);
			var xl:XMLList=xml.qw;
			for(var i:int=0;i<xl.length();i++){
				trace(xl[i].@h,xl[i].@wd);
				if(String(xl[i].@wd)!=""){
					dispatchEvent(new CustomEvent('realtimewd',Number(xl[i].@wd)));
					break;
				}
			}
			//trace(xml.qw[0].@h);
		}
	}
}
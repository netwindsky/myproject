package org.lifeng.application.SmartScreen
{
	import org.lifeng.db.DataBaseManager;

	public class DatabaseServer
	{
		private var db:DataBaseManager=new DataBaseManager();
		private static var _instance:DatabaseServer;
		public function DatabaseServer()
		{
			db.openDB("database.db");
		}
		public static function getInstance():DatabaseServer{
			if(!_instance){
				_instance=new DatabaseServer();
			}
			return _instance;
		}
		public function LogTime():void{
			//var userarr:Array=db.executeNow("select x from info");
			//trace(userarr[0].x);
			//return userarr[0].x;
			var date:Date=new Date();
			//trace(date.fullYear+"-"+(date.month+1)+"-"+date.date);
			var nyr:String=date.fullYear+"-"+(date.month+1)+"-"+date.date;

			var array:Array=db.executeNow("select * from loginfo where date='"+nyr+"'");
			if(array!=null){
				//trace("tiaomu",array.length);
				var all:int=array[0].alltime;
				all++;
				db.executeNow("update loginfo set alltime="+all+" where date='"+nyr+"'");
				
			}else{
				//trace("aaaa","insert into loginfo ('date') values('"+nyr+"') ");
				var time:String=date.hours+":"+date.minutes;
				db.executeNow("insert into loginfo ('date','starttime') values('"+nyr+"','"+time+"') ");
				db.executeNow("update loginfo set alltime="+1);
			}
		}
		public function getLogTimer():int{
			var date:Date=new Date();
			var nyr:String=date.fullYear+"-"+(date.month+1)+"-"+date.date;
			var userarr:Array=db.executeNow("select * from loginfo where date='"+nyr+"'");
			trace("fuck you _______",userarr);
			return userarr[0].alltime;
		}
		public function startup():void{
			var date:Date=new Date();
			//trace(date.fullYear+"-"+(date.month+1)+"-"+date.date);
			var nyr:String=date.fullYear+"-"+(date.month+1)+"-"+date.date;
			var array:Array=db.executeNow("select * from loginfo where date='"+nyr+"'");
			if(array!=null){
				
			}else{
				//trace("aaaa","insert into loginfo ('date') values('"+nyr+"') ");
				var time:String=date.hours+":"+date.minutes;
				db.executeNow("insert into loginfo ('date','starttime') values('"+nyr+"','"+time+"') ");
			}
		}
		/*
		public function getStartTimer(date:String):String{
			var userarr:Array=db.executeNow("select startrun from info where date="+date);
			return userarr[0].startrun;
		}
		public function setY(y:Number):void{
			var sql:String="update info set y="+y;
			db.executeNow(sql);
		}
		public function setStyle(sty:String):void{
			var sql:String="update info set style='"+sty+"'";
			db.executeNow(sql);
		}
		public function setScale(scale:Number):void{
			var sql:String="update info set scale="+scale;
			db.executeNow(sql);
		}
		public function setStartrun(start:String):void{
			var sql:String="update info set startrun="+start;
			db.executeNow(sql);
		}
		public function setBarSite(value:String):void{
			var sql:String="update info set barsite='"+value+"'";
			db.executeNow(sql);
		}*/
	}
}
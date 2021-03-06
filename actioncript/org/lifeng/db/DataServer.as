///////////////////////////////////////////////////////////
//  DataServer.as
//  Macromedia ActionScript Implementation of the Class DataServer
//  Generated by Enterprise Architect
//  Created on:      23-十二月-2011 18:23:34
//  Original author: lifeng
///////////////////////////////////////////////////////////

package  org.lifeng.db
{
	import com.crystalcg.mvc.model.UserSystemData;
	
	import flash.text.StaticText;

	/**
	 * 提供数据服务
	 * @author lifeng
	 * @version 1.0
	 * @created 23-十二月-2011 18:23:34
	 */
	public class DataServer
	{
		private var db:DataBaseManager=new DataBaseManager();
		private static var _instance:DataServer;
		
		public function DataServer(){
			db.openDB("city");
		}
		public static function getInstance():DataServer{
			if(!_instance){
				_instance=new DataServer();
			}
			
			return _instance;
		}
		public function getUser():UserSystemData{
			var obj:UserSystemData;
			var userarr:Array=db.executeNow("select * from users");
			
			if(userarr==null)return obj;
			var uid:int=userarr[0].uid;
			var sex:String=userarr[0].sex;
			var arr:Array=db.executeNow("select * from cityinfo where uid='"+uid+"' ");
			if(arr!=null){
				obj=new UserSystemData();
				obj.username=arr[0].username;
				obj.level=arr[0].level;
				obj.experence=arr[0].exp;
				obj.money=arr[0].golden;
				obj.id=uid;
				obj.sex=sex;
			}
			return obj;
		}
		public function addUser(name:String,sex:int):void
		{
			db.executeNow("insert into users (username,sex) values ('"+name+"',"+sex+")");
			var uid:int=db.executeNow("select uid from users where username='"+name+"'")[0].uid;
			db.executeNow("insert into cityinfo (uid,username,golden,money,exp) values ("+uid+",'"+name+"',200,20,0)");
		}
		public function getTask(userid:int):Object{
			//var sql:String="select a.name aname,b.type btype,b.status bstatus,b.roleid broleid from taskbase a,tasktarget b where a.id=b.taskid";
			//return ;
			/*
			var arr:Array=db.executeNow("select taskid from tasking where userid='"+userid+"'");
			var obj:Object;
			if(arr!=null){
				var taskid:int=arr[0].taskid;
				
				var taskArr:Array=db.executeNow("select * from taskbase where id='"+taskid+"'");
				if(taskArr){
					obj=taskArr[0];
					var target_arr:Array=obj.targetid.split(",");
					var str:String="";
					while(target_arr.length>1){
						var id:String=target_arr.pop();
						str+=" id="+id+" or";
					}
					str+=" id="+target_arr.pop();
					var sq:String="select * from tasktarget where "+str;
					var targetA:Array=db.executeNow(sq);
					obj["targetarr"]=targetA;
				}
				
			}*/
			
			/*var sql:String="select a.id,a.startgoldnum,b.name,b.discription,c.type,c.status,d.name as tname,c.resourcnumber from tasking as a,taskbase as b,tasktarget as c,resourcs as d where a.taskid=b.id  and  c.resourcid=d.id and a.userid="+userid;
			trace(sql);
			var obj:Object;
			var arr:Array=null//db.executeNow(sql);
			trace(arr);*/
			/*for(var i:int=0;i<arr.length;i++){
				trace("-----------------------------------------")
				for( var j:* in arr[i]){
					trace(j,arr[i][j]);
				}
				trace("-----------------------------------------")
			}*/
			/*
			if(arr){
				obj=arr[0];
			}*/
			
			trace("get task "+userid);
			var sql:String="select * from tasking where userid="+userid;
			trace(sql);
			var obj:Object;
			var arr:Array=db.executeNow(sql);
			if(arr){
				obj=arr[0];
			}
			
			
			return obj;
						
		}
		public function getTaskByTaskid(taskid:String):Object{
			var sql:String="select * from tasking where taskid="+taskid;
			trace(sql);
			var obj:Object;
			var arr:Array=db.executeNow(sql);
			if(arr){
				obj=arr[0];
			}
			
			
			return obj;
		}
		public function addGold(gold:int=0,uid:int=0):Number{
			var sql:String="select golden from cityinfo where uid="+uid;
			var mygold:Number
			var array:Array=db.executeNow(sql);
			if(array){
				var obj:Object=array[0];
				mygold=Number(obj.golden);
				mygold+=gold;
				
				var upsql:String="update cityinfo set golden="+mygold+" where uid="+uid;
				db.execute(upsql);
			}
			return mygold;
		}
		public function setGold(gold:int=0,uid:int=0):void{
			var sql:String="update cityinfo set golden="+gold+" where uid="+uid;
			db.executeNow(sql);
		}
		public function addExp(exp:int=0,uid:int=0):Number{
			var sql:String="select exp from cityinfo where uid="+uid+"";
			var array:Array=db.executeNow(sql);
			var myexp:Number
			if(array){
				var obj:Object=array[0];
				myexp=Number(obj.exp);
				myexp+=exp;
				var upsql:String="update cityinfo set exp="+myexp+" where uid="+uid+"";
				db.execute(upsql);
			}
			return myexp;
		}
		
		public function updateLevelAndExp(uid:int,level:int,exp:int):void{
			var upsql:String="update cityinfo set exp="+exp+", level="+level+" where uid="+uid+"";
			db.execute(upsql);
		}
		public function getBuilds():Array{
			//var sql:String="select a.id,a.level,a.position,b.housename, b.uptime,b.resource ,b.othername,b.type,b.rule from  house as a, houselist as b where a.hid=b.id and a.uid="+uid;
			var sql:String="select * from houselist";
			return db.executeNow(sql);
			
		}
		public function updateBuild(bid:String,level:String):void{
			var sql:String="update houselist set level='"+level+"' where otherid='"+bid+"'";
			db.executeNow(sql);
		}
		public function addSomeing(pid:String,count:int):void{
			//var sql:String="update resourcs set number='"+count;
			var sql:String="select number from resourcs where otherid='"+pid+"'";
			var arr:Array=db.executeNow(sql);
			if(arr){
				var num:int=arr[0].number;
				var s:String="update resourcs set number="+(count+num)+" where otherid='"+pid+"'";
				db.executeNow(s);
			}
		}
		public function subSomeing(pid:String,count:int):void{
			var sql:String="select number from resourcs where otherid='"+pid+"'";
			var arr:Array=db.executeNow(sql);
			if(arr){
				var num:int=arr[0].number;
				var s:String="update resourcs set number="+(num-count)+" where otherid='"+pid+"'";
				db.executeNow(s);
			}
		}
		public function getRole(id:String):Array{
			var sql:String="select * from roles where otherid='"+id+"'";
			return db.executeNow(sql);
		}
		
		public function addTask(uid:int,taskid:String,status:String):void{
			var sql:String="insert into tasking (taskid,userid,status) values ("+taskid+","+uid+","+status+")";
			db.executeNow(sql);
		}
		
		public function updateTaskStatus(tid:String,status):void{
			var sql:String="update tasking set status="+status+" where taskid='"+tid+"'";
			db.executeNow(sql);
		}
		
		public function deleteTask(tid:String):void{
			var sql:String="delete from tasking where taskid="+tid;
			db.executeNow(sql);
		}
		public function changeBuilderStatus(tid:String,status:String):void{
			var sql:String="update houselist set status="+status+" where otherid='"+tid+"'";
			db.executeNow(sql);
		}
		public function getGameList():Array{
			var sql:String="select gameid from houselist where gameid!='0' and status=='2'";
			return db.executeNow(sql);
		}
		public function getHeroList():Array{
			var sql:String="select * from roles";
			return db.executeNow(sql);
		}
		public function getresourcs():Array{
			var sql:String="select * from resourcs where number!=0";
			return db.executeNow(sql);
		}
		public function getFitGameStatus(id:String):String{
			var sql:String="select status from gamefire where targetid='"+id+"'";
			var arr:Array=db.executeNow(sql);
			if(arr){
				return arr[0].status;
			}else{
				return null;
			}
		}
		public function setFitGameStatus(id:String,status:String):void{
			var sql:String="update gamefire set status='"+status+"' where targetid='"+id+"'";
			trace(sql);
			db.executeNow(sql);
		}
		public function getresourcsCount(id:String):int{
			var sql:String="select number from resourcs where otherid='"+id+"'";
			var arr:Array=db.executeNow(sql);
			if(arr){
				return arr[0].number;
			}else{
				return null;
			}
		}
		public function getuserStatus(id:String):Boolean{
			var sql:String="select status from users where uid='"+id+"'";
			var arr:Array=db.executeNow(sql);
			if(arr){
				trace(arr[0].status);;
				return arr[0].status;
			}else{
				return null;
			}
		}
		public function setUserStatus(id:String,status:Boolean):void{
			var sql:String="update users set status='"+status+"' where uid='"+id+"'";
			db.executeNow(sql);
		}
	}//end DataServer
}
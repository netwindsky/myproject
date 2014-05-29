package org.lifeng.test
{
	import flash.utils.getTimer;
	
	public class RunTimeManager
	{
		private var start:Number;
		private var name:String="测试1";
		public function RunTimeManager()
		{
		}
		public function setName(_name:String="测试"):void{
			name=_name;
		}
		public function getName():String{
			return name;
		}
		public function startTime():void{
			start=getTimer();
		}
		public function endTime():int{
			trace(name+"->运行时间："+(getTimer()-start));
			return getTimer()-start;
		}
	}
}
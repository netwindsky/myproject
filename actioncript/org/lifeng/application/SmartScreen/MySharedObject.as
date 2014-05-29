package org.lifeng.application.SmartScreen
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.SharedObject;
	
	public class MySharedObject extends EventDispatcher
	{
		private static var _instance:MySharedObject;
		
		/**
		 * 声音大小   0-100;
		 * */
		private var _sound:int = 0;
		
		/**
		 * 当着播放状态. 0 顺序  1 单循环
		 * */
		private var _state:int = 0;
		
		private var myShare:SharedObject;
		
		public function MySharedObject(singletonEnforcer:SingletonEnforer)
		{
			if(singletonEnforcer == null){
				throw new Error("singletonEnforcer error");
			}
		}
		
		public function get state():int
		{
			return _state;
		}

		public function set state(value:int):void
		{
			_state = value;
			myShare.data.state = _state;
			myShare.flush();
		}

		public function get sound():int
		{
			return _sound;
		}

		public function set sound(value:int):void
		{
			
			trace("fuck--->>>",value);
			_sound = value;
			myShare.data.sound = _sound;
			myShare.flush();
		}

		public function initData():void{
			myShare = SharedObject.getLocal("HRBSmarVideo-Sahred");
			
			_sound = myShare.data.sound;
			_state = myShare.data.state;
			
			
			trace("初始化",_sound,_state);
		}
		
		public static function getInstance():MySharedObject{
			if(MySharedObject._instance == null){
				MySharedObject._instance = new MySharedObject(new SingletonEnforer());
			}
			
			return MySharedObject._instance;
		}
		
		
	}
}

class SingletonEnforer{}
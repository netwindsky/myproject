package org.lifeng.ui
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.core.ButtonAsset;
	
	import org.lifeng.events.CustomEvent;

	public class LFButtonGroup extends Sprite
	{
		public static const LANDSCAPE:String="landscape";
		public static const PORTRAIT:String="portrait";
		private var buttonContainer:Sprite=new Sprite();
		private var _interval:int=0;
		private var _direction:String=PORTRAIT;//landscape,portrait
		public function LFButtonGroup()
		{
			addChild(buttonContainer);
			addEventListener(MouseEvent.CLICK,clickHandler);
		}
		public function addButtomItem(btn:LFButton):void{
			btn.addEventListener(CustomEvent.EVENT_NAME,handler);
			buttonContainer.addChild(btn);
			layout();
		}
		public function layout():void{
			trace(buttonContainer.numChildren)
			var num:int=buttonContainer.numChildren;
			var currentXY:int=0;
			if(_direction==LANDSCAPE){
				for(var i:int=0;i<num;i++){
					var btn:LFButton=buttonContainer.getChildAt(i) as LFButton;
					btn.x=currentXY;
					currentXY+=(_interval+btn.width);
				}
			}else{
				for(var i:int=0;i<num;i++){
					var btn:LFButton=buttonContainer.getChildAt(i) as LFButton;
					btn.y=currentXY;
					currentXY+=(_interval+btn.height);
				}
			}
		}
		public function set interval(num:int):void{
			_interval=num;
		}
		public function set direction(value:String):void{
			_direction=value;
			trace(_direction);
			layout();
		}
		private function clickHandler(e:MouseEvent):void{
			//trace(e.target.id);
			var num:int=buttonContainer.numChildren;
			for(var i:int=0;i<num;i++){
				var btn:LFButton=buttonContainer.getChildAt(i) as LFButton;
				if(btn.id!=e.target.id){
					btn.resite();
				}	
			}
			
			trace("AAAAAAAAAAAAAAAAAAaa")
			dispatchEvent(new CustomEvent("selected",e.target.id));
		}
		private function handler(e:CustomEvent):void{
			switch(e.command){
				case "upover":
					layout();
					break;
				case "downover":
					layout();
					break;
			}
		}
	}
}
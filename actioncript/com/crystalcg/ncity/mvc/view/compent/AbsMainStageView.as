package com.crystalcg.ncity.mvc.view.compent
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class AbsMainStageView extends Sprite
	{
		private var window:Sprite=new Sprite();
		private var control:Sprite=new Sprite();
		private var content:Sprite=new Sprite();
		private var guide:Sprite=new Sprite();
		private var background:Sprite=new Sprite();
		private static  var _instance:AbsMainStageView;
		public function AbsMainStageView()
		{
			super();
			
			addChild(background);
			addChild(content);
			addChild(control);
			addChild(guide);
			addChild(window);

		}
		public function getContainerByType(type:String):Sprite{
			switch(type){
				case AbsMainLayerType.TYPE_BACKGROUND:
					return background
					break;
				case AbsMainLayerType.TYPE_CONTENT:
					return content;
					break;
				case AbsMainLayerType.TYPE_CONTROL:
					return control;
					break;
				case AbsMainLayerType.TYPE_WINDOW:
					return window;
					break;
				case AbsMainLayerType.TYPE_GUIDE:
					return guide;
					break;
				default:
					return null;
					break;
			}
		}
		public function clear(containerType:String):void{
			var sp:Sprite=getContainerByType(containerType);
			if(sp!=null){
				while(sp.numChildren>0){
					sp.removeChildAt(0);
				}
			}
		}
		public static  function getInstance():AbsMainStageView{
			if(_instance){
				return _instance;
			}else{
				_instance=new AbsMainStageView();
				return _instance;
			}
		}
		
	}
}
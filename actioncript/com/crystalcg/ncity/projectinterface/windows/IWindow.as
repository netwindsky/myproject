package com.crystalcg.ncity.projectinterface.windows
{
	import flash.display.BitmapData;

	public interface IWindow
	{
		 function updata(_config:String,_draw:Boolean):void;
		 function start():void;
		 function stop():void;
		 function dispose():void;
		 function getImage():BitmapData;
	}
}
package org.lifeng.application.titletext
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import flashx.textLayout.formats.TextAlign;
	
	import org.lifeng.text.FontCNNameToEN;
	
	public class TitleText extends Sprite
	{
		private var txt:TextField;
		private var timer:Timer=new Timer(500);
		private var result:Array=[];
		private var p:int=0;
		public function TitleText()
		{
			super();
			
			txt=new TextField();
			txt.selectable=false;
			txt.autoSize=TextFieldAutoSize.LEFT;
			txt.width=400;
			txt.height=300;
			txt.text="1234*($%^&欢迎胡主席来我院视察工作！";
			txt.antiAliasType=AntiAliasType.ADVANCED;
			addChild(txt);
			
			
			var arr : Array = Font.enumerateFonts(true);
			for(var i : uint = 0 ; i < arr.length ; i++)
			{
				var child : Font = arr[i] as Font;
				result.push(child.fontName);
				//trace(child.fontName);
			}
			timer.addEventListener(TimerEvent.TIMER,handler);
			timer.start();
		}
		
		protected function handler(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			
			var cnf:FontCNNameToEN=new FontCNNameToEN();
			var name:String=result[p];
			trace(result[p],cnf.getFontENName(result[p]));
			if(cnf.getFontENName(result[p])){
				name=cnf.getFontENName(result[p]);
			}
			
			setTextFormat(TextFormatFactory.createTextFormat(name,16,0xff6600));
			p++;
		}
		public function setTextFormat(format:TextFormat):void{
			txt.defaultTextFormat=format;
			txt.text=txt.text;
		}
	}
}
package org.lifeng.display.components
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import flashx.textLayout.elements.ListElement;

	public class ListItem extends Sprite
	{
		private var _titlename:String;
		private var _id:String;
		
		private var text:TextField=new TextField();
		
		public function ListItem(title:String,id:String)
		{
			text.selectable=false;
			text.multiline=true;
			text.autoSize=TextFieldAutoSize.LEFT;
			addChild(text);
			_titlename=title;
			_id=id;
			addChild(text);
		}
		public function setTextFormat(font:String,size:int,color:uint,bold:Boolean):void{
			var textF:TextFormat=new TextFormat(font,size,color,bold);
			text.defaultTextFormat=textF;
			
		}
		public function render():void{
			text.text=_titlename;
			
		}
	}
}
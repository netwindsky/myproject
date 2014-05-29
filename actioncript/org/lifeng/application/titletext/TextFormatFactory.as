package org.lifeng.application.titletext
{
	import flash.text.TextFormat;
	
	import flashx.textLayout.formats.TextLayoutFormat;

	public class TextFormatFactory
	{
		public function TextFormatFactory()
		{
		}
		public static function createTextFormat(fontname:String,size:int,color:uint):TextFormat{
			var textFormat:TextFormat=new TextFormat(fontname,size,color);
			return textFormat;
			
		}
		public static function createTextLayoutFormat(fontname:String,size:int,color:uint):TextLayoutFormat{
			//var textFormat:TextFormat=new TextFormat(fontname,size,color);
			
			
			//var format1:TextLayoutFormat = new TextLayoutFormat();
			//format1.color = 0x660000;
			//format1.fontFamily = "Arial, Helvetica, _sans";
			//format1.fontSize = 14;
			//format1.paragraphSpaceBefore=0;
			//format1.paragraphSpaceAfter=20;
			var format2:TextLayoutFormat = new TextLayoutFormat();
			format2.color = color;
			format2.fontFamily = fontname+", Helvetica, _sans";
			format2.fontSize = size;
			//format2.fontWeight = FontWeight.BOLD;
			
			return format2;
		}
	}
}
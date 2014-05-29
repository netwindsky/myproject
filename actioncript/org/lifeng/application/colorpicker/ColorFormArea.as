package org.lifeng.application.colorpicker
{
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	
	
	public class ColorFormArea extends Sprite {
		
		private var colorArr:Array = ["00", "33", "66", "99", "CC", "FF"];
		
		//color text
		private var txt:TextField = new TextField;
		/**
		 * 颜色块数组
		 */
		private const RECTS_ARR:Array = new Array;
		
		/**
		 * 颜色改变时的处理函数
		 */
		private var theHandler:Function;
		
		/**
		 * 颜色块区域
		 */
		private var colorRects:Sprite = new Sprite;
		
		/**
		 * 构造一个新的ColorFormArea实例
		 */
		
		public function ColorFormArea(colorChangeHandler:Function = null):void {
			theHandler = colorChangeHandler;
			
			var bg:Sprite = new Sprite;
			with(bg){
				graphics.beginFill(0xFFFFFF);
				graphics.drawRect(0, 0, 308, 230);
				graphics.endFill();
				//CapsStyle.SQUARE;
				//----------netwindsky
				graphics.lineStyle(1, 0xCCCCCC, 1, true, "normal", CapsStyle.NONE, JointStyle.BEVEL);
				graphics.moveTo(1, 1);
				graphics.lineTo(1, 229);
				graphics.moveTo(308, 1);
				graphics.lineTo(308, 229);
			}
			//添加滤镜
			var bevel:BevelFilter = new BevelFilter(1.5, 90, 0xFFFFFF, 1, 0x666666, 1, 0, 4, 1, BitmapFilterQuality.LOW, BitmapFilterType.INNER, false);
			bg.filters = [bevel];
			addChild(bg);
			
			//add text
			txt.width = 60;
			txt.height = 20;
			txt.border = true;
			txt.type = TextFieldType.INPUT;
			txt.x = 10;
			txt.y = 5;
			txt.maxChars = 7;
			txt.restrict = "0-9a-f#";
			txt.text = "0x000000";
			txt.addEventListener(Event.CHANGE, txtChange);
			addChild(txt);
			
			//add color rects bg
			var colorBG:Sprite = new Sprite;
			colorBG.graphics.lineStyle(1);
			colorBG.graphics.beginFill(0);
			colorBG.graphics.drawRect(0, 0, 300, 300);
			colorBG.graphics.endFill();
			addChild(colorBG);
			
			//add color rects
			colorRects.x = txt.x + 1;
			colorRects.y = txt.y + txt.height + 5;
			addChild(colorRects);
			for (var i:int = 0; i < 18; i++) {
				for (var j:int = 0; j < 12; j++) {
					var color:String = "";
					color = "0x" + colorArr[Math.floor(i / 6) + Math.floor(j / 6) * 3] + colorArr[i % 6] + colorArr[j % 6];
					var colorForm:ColorForm = new ColorForm(color, selectColorHandler);
					colorForm.x = i * (colorForm.width);
					colorForm.y = j * (colorForm.height);
					colorRects.addChild(colorForm);
					RECTS_ARR.push(colorForm);
				}
			}
			colorBG.width = colorRects.width + 1;
			colorBG.height = colorRects.height + 1;
			colorBG.x = colorRects.x - 1;
			colorBG.y = colorRects.y - 1;
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, removeThis);
		}
		
		/**
		 * 移除侦听器
		 * @param    event
		 */
		private function removeThis(event:Event):void {
			txt.removeEventListener(Event.CHANGE, txtChange);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removeThis);
		}
		
		private function selectColorHandler(color:String):void {
			txt.text = "#" + color.slice(2, 8);
			txtChange();
			
			callHandler(color);
		}
		
		/**
		 * 最近一次选中的方块
		 */
		private var latestIndex:int = 0;
		
		private function txtChange(event:Event = null):void {
			var txtValue:String = txt.text;
			var txtColor:String = "";
			
			if (txtValue.slice(0, 1) == "#") {
				txt.maxChars = 7;
				txtColor = "0x" + txtValue.slice(1, 7);
			}else {
				txt.maxChars = 6;
				txtColor = "0x" + txtValue.slice(0, 6);
			}
			callHandler(txtColor);
			
			RECTS_ARR[latestIndex].select = false;
			for (var i:int = 0; i < RECTS_ARR.length; i++) {
				var colorForm:ColorForm = RECTS_ARR[i] as ColorForm;
				if (uint(colorForm.color) == uint(txtColor)) {
					colorForm.select = true;
					latestIndex = i;
					break;
				}
			}
		}
		
		/**
		 * 颜色改变时调用此函数
		 * @param    color
		 */
		private function callHandler(color:String):void {
			if (Boolean(theHandler)) {
				theHandler(color);
			}
		}
	}
	
}
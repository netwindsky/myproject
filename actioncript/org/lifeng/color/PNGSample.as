/**
 * Copyright ferv ( http://wonderfl.net/user/ferv )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/wXb8
 */

package org.lifeng.color 
{
	import com.adobe.images.PNGEncoder;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GraphicsBitmapFill;
	import flash.display.IGraphicsData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	/**
	 * 解説 http://ferv.jp/blog/2010/01/07/optimized-pngencoder/
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0
	 * 
	 * @author dsk
	 * @since 2009/12/16
	 * 
	 * 颜色拾取器
	 */
	[SWF(backgroundColor = '0xFFFFFF', width = '465', height = '465', frameRate = '30')]
	public class PNGSample extends Sprite 
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		private const WIDTH:int = 220;
		private const HEIGHT:int = 140;
		private const LENGTH:int = 10;
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		private var _opaque:BitmapData;
		private var _transparent:BitmapData;
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function PNGSample() 
		{
			
			addEventListener(Event.ADDED_TO_STAGE,addtostage);
			
		}
		
		protected function addtostage(event:Event):void
		{
			// TODO Auto-generated method stub
			var stageWidth:int = stage.stageWidth;
			var stageHeight:int = stage.stageHeight;
			
			var background:BitmapData = new BitmapData(2, 2, false, 0xFFFFFF);
			background.lock();
			background.setPixel(0, 0, 0xEEEEEE);
			background.setPixel(1, 1, 0xEEEEEE);
			background.unlock();
			var matrix:Matrix = new Matrix();
			matrix.scale(10, 10);
			graphics.drawGraphicsData(Vector.<IGraphicsData>([
				new GraphicsBitmapFill(background, matrix, true, false), 
				GraphicsPathUtil.createRect(0, 0, stage.stageWidth, stage.stageHeight)
			]));
			
			var bitmap:Bitmap, label:Label;
			var x:int, y:int;
			var hsv:HSV = new HSV();
			
			_opaque = new BitmapData(WIDTH, HEIGHT, false, 0x000000);
			_opaque.lock();
			for (y = 0; y < HEIGHT; y ++) {
				hsv.saturation = 1 - 1 / HEIGHT * y;
				hsv.value = 1 - 1 / HEIGHT * y;
				for (x = 0; x < WIDTH; x ++) {
					hsv.hue = x * 360 / WIDTH;
					_opaque.setPixel(x, y, hsv.color);
				}
			}
			_opaque.unlock();
			label = new Label('source (opaque)');
			bitmap = new Bitmap(_opaque, 'auto', true);
			bitmap.x = label.x = stageWidth / 2 - 5 - WIDTH;
			bitmap.y = label.y = stageHeight / 2 - HEIGHT * 1.5 - 10;
			addChild(bitmap);
			addChild(label);
			
			_transparent = new BitmapData(WIDTH, HEIGHT, true, 0xFF000000);
			_transparent.lock();
			for (x = 0; x < WIDTH; x ++) {
				hsv.hue = x * 360 / WIDTH;
				hsv.saturation = 1;
				hsv.value = 1;
				for (y = 0; y < HEIGHT; y ++) {
					_transparent.setPixel32(x, y, (0xFF * (HEIGHT - y) / HEIGHT) << 24 | hsv.color);
				}
			}
			_transparent.unlock();
			label = new Label('source (transparent)');
			bitmap = new Bitmap(_transparent, 'auto', true);
			bitmap.x = label.x = stageWidth / 2 + 5;
			bitmap.y = label.y = stageHeight / 2 - HEIGHT * 1.5 - 10;
			addChild(bitmap);
			addChild(label);
			
			
			
			
			var i:int, time:int, 
			originalOpaque:ByteArray, originalTransparent:ByteArray, optimizedOpaque:ByteArray, optimizedTransparent:ByteArray;
			var originalOpaqueTime:int = 0;
			var originalTransparentTime:int = 0;
			var optimizedOpaqueTime:int = 0;
			var optimizedTransparentTime:int = 0;
			for (i = 0; i < LENGTH; i ++) {
				time = getTimer();
				originalOpaque = com.adobe.images.PNGEncoder.encode(_opaque);
				originalOpaqueTime += getTimer() - time;
				
				time = getTimer();
				originalTransparent = com.adobe.images.PNGEncoder.encode(_transparent);
				originalTransparentTime += getTimer() - time;
				
				time = getTimer();
				optimizedOpaque = PNGEncoder.encode(_opaque);
				optimizedOpaqueTime += getTimer() - time;
				
				time = getTimer();
				optimizedTransparent = PNGEncoder.encode(_transparent);
				optimizedTransparentTime += getTimer() - time;
			}
			
			var loader:Loader;
			
			label = new Label('original (opaque)\n' + (originalOpaqueTime / LENGTH).toString() + ' ms/execution');
			loader = new Loader();
			loader.loadBytes(originalOpaque);
			loader.x = label.x = stageWidth / 2 - 5 - WIDTH;
			loader.y = label.y = stageHeight / 2 - HEIGHT * 0.5;
			addChild(loader);
			addChild(label);
			
			label = new Label('original (transparent)\n' + (originalTransparentTime / LENGTH).toString() + ' ms/execution');
			loader = new Loader();
			loader.loadBytes(originalTransparent);
			loader.x = label.x = stageWidth / 2 + 5;
			loader.y = label.y = stageHeight / 2 - HEIGHT * 0.5;
			addChild(loader);
			addChild(label);
			
			label = new Label('optimized (opaque)\n' + (optimizedOpaqueTime / LENGTH).toString() + ' ms/execution');
			loader = new Loader();
			loader.loadBytes(optimizedOpaque);
			loader.x = label.x = stageWidth / 2 - 5 - WIDTH;
			loader.y = label.y = stageHeight / 2 + HEIGHT * 0.5 + 10;
			addChild(loader);
			addChild(label);
			
			label = new Label('optimized (transparent)\n' + (optimizedTransparentTime / LENGTH).toString() + ' ms/execution');
			loader = new Loader();
			loader.loadBytes(optimizedTransparent);
			loader.x = label.x = stageWidth / 2 + 5;
			loader.y = label.y = stageHeight / 2 + HEIGHT * 0.5 + 10;
			addChild(loader);
			addChild(label);
		}		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		
	}
	
	
}



	import flash.display.BitmapData;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	/**
	 * Class that converts BitmapData into a valid PNG.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0
	 * 
	 * @author dsk
	 * @since 2009/12/16
	 */
	internal class PNGEncoder 
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		private static const SIGNATURE:ByteArray = _createSignature();
	    private static const CRC_TABLE:Vector.<uint> = Vector.<uint>([
			0x000000000, 0x077073096, 0x0EE0E612C, 0x0990951BA, 0x0076DC419, 0x0706AF48F, 0x0E963A535, 0x09E6495A3, 
			0x00EDB8832, 0x079DCB8A4, 0x0E0D5E91E, 0x097D2D988, 0x009B64C2B, 0x07EB17CBD, 0x0E7B82D07, 0x090BF1D91, 
			0x01DB71064, 0x06AB020F2, 0x0F3B97148, 0x084BE41DE, 0x01ADAD47D, 0x06DDDE4EB, 0x0F4D4B551, 0x083D385C7, 
			0x0136C9856, 0x0646BA8C0, 0x0FD62F97A, 0x08A65C9EC, 0x014015C4F, 0x063066CD9, 0x0FA0F3D63, 0x08D080DF5, 
			0x03B6E20C8, 0x04C69105E, 0x0D56041E4, 0x0A2677172, 0x03C03E4D1, 0x04B04D447, 0x0D20D85FD, 0x0A50AB56B, 
			0x035B5A8FA, 0x042B2986C, 0x0DBBBC9D6, 0x0ACBCF940, 0x032D86CE3, 0x045DF5C75, 0x0DCD60DCF, 0x0ABD13D59, 
			0x026D930AC, 0x051DE003A, 0x0C8D75180, 0x0BFD06116, 0x021B4F4B5, 0x056B3C423, 0x0CFBA9599, 0x0B8BDA50F, 
			0x02802B89E, 0x05F058808, 0x0C60CD9B2, 0x0B10BE924, 0x02F6F7C87, 0x058684C11, 0x0C1611DAB, 0x0B6662D3D, 
			0x076DC4190, 0x001DB7106, 0x098D220BC, 0x0EFD5102A, 0x071B18589, 0x006B6B51F, 0x09FBFE4A5, 0x0E8B8D433, 
			0x07807C9A2, 0x00F00F934, 0x09609A88E, 0x0E10E9818, 0x07F6A0DBB, 0x0086D3D2D, 0x091646C97, 0x0E6635C01, 
			0x06B6B51F4, 0x01C6C6162, 0x0856530D8, 0x0F262004E, 0x06C0695ED, 0x01B01A57B, 0x08208F4C1, 0x0F50FC457, 
			0x065B0D9C6, 0x012B7E950, 0x08BBEB8EA, 0x0FCB9887C, 0x062DD1DDF, 0x015DA2D49, 0x08CD37CF3, 0x0FBD44C65, 
			0x04DB26158, 0x03AB551CE, 0x0A3BC0074, 0x0D4BB30E2, 0x04ADFA541, 0x03DD895D7, 0x0A4D1C46D, 0x0D3D6F4FB, 
			0x04369E96A, 0x0346ED9FC, 0x0AD678846, 0x0DA60B8D0, 0x044042D73, 0x033031DE5, 0x0AA0A4C5F, 0x0DD0D7CC9, 
			0x05005713C, 0x0270241AA, 0x0BE0B1010, 0x0C90C2086, 0x05768B525, 0x0206F85B3, 0x0B966D409, 0x0CE61E49F, 
			0x05EDEF90E, 0x029D9C998, 0x0B0D09822, 0x0C7D7A8B4, 0x059B33D17, 0x02EB40D81, 0x0B7BD5C3B, 0x0C0BA6CAD, 
			0x0EDB88320, 0x09ABFB3B6, 0x003B6E20C, 0x074B1D29A, 0x0EAD54739, 0x09DD277AF, 0x004DB2615, 0x073DC1683, 
			0x0E3630B12, 0x094643B84, 0x00D6D6A3E, 0x07A6A5AA8, 0x0E40ECF0B, 0x09309FF9D, 0x00A00AE27, 0x07D079EB1, 
			0x0F00F9344, 0x08708A3D2, 0x01E01F268, 0x06906C2FE, 0x0F762575D, 0x0806567CB, 0x0196C3671, 0x06E6B06E7, 
			0x0FED41B76, 0x089D32BE0, 0x010DA7A5A, 0x067DD4ACC, 0x0F9B9DF6F, 0x08EBEEFF9, 0x017B7BE43, 0x060B08ED5, 
			0x0D6D6A3E8, 0x0A1D1937E, 0x038D8C2C4, 0x04FDFF252, 0x0D1BB67F1, 0x0A6BC5767, 0x03FB506DD, 0x048B2364B, 
			0x0D80D2BDA, 0x0AF0A1B4C, 0x036034AF6, 0x041047A60, 0x0DF60EFC3, 0x0A867DF55, 0x0316E8EEF, 0x04669BE79, 
			0x0CB61B38C, 0x0BC66831A, 0x0256FD2A0, 0x05268E236, 0x0CC0C7795, 0x0BB0B4703, 0x0220216B9, 0x05505262F, 
			0x0C5BA3BBE, 0x0B2BD0B28, 0x02BB45A92, 0x05CB36A04, 0x0C2D7FFA7, 0x0B5D0CF31, 0x02CD99E8B, 0x05BDEAE1D, 
			0x09B64C2B0, 0x0EC63F226, 0x0756AA39C, 0x0026D930A, 0x09C0906A9, 0x0EB0E363F, 0x072076785, 0x005005713, 
			0x095BF4A82, 0x0E2B87A14, 0x07BB12BAE, 0x00CB61B38, 0x092D28E9B, 0x0E5D5BE0D, 0x07CDCEFB7, 0x00BDBDF21, 
			0x086D3D2D4, 0x0F1D4E242, 0x068DDB3F8, 0x01FDA836E, 0x081BE16CD, 0x0F6B9265B, 0x06FB077E1, 0x018B74777, 
			0x088085AE6, 0x0FF0F6A70, 0x066063BCA, 0x011010B5C, 0x08F659EFF, 0x0F862AE69, 0x0616BFFD3, 0x0166CCF45, 
			0x0A00AE278, 0x0D70DD2EE, 0x04E048354, 0x03903B3C2, 0x0A7672661, 0x0D06016F7, 0x04969474D, 0x03E6E77DB, 
			0x0AED16A4A, 0x0D9D65ADC, 0x040DF0B66, 0x037D83BF0, 0x0A9BCAE53, 0x0DEBB9EC5, 0x047B2CF7F, 0x030B5FFE9, 
			0x0BDBDF21C, 0x0CABAC28A, 0x053B39330, 0x024B4A3A6, 0x0BAD03605, 0x0CDD70693, 0x054DE5729, 0x023D967BF, 
			0x0B3667A2E, 0x0C4614AB8, 0x05D681B02, 0x02A6F2B94, 0x0B40BBE37, 0x0C30C8EA1, 0x05A05DF1B, 0x02D02EF8D
		]);
		private static const IEND_CHUNK:ByteArray = _createChunk(0x49454E44, null);
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * Created a PNG image from the specified BitmapData.
		 * 
		 * PNG file signature   (8 bytes)
		 * - 0x89 0x50 0x 4E 0x47 0x0D 0x0A 0x1A 0x0A
		 * IHDR Image header
		 * - Width              (4 bytes)
		 * - Height             (4 bytes)
		 * - Bit depth          (1 byte)  8 (1,2,4,8,16=grayscale, 8,16=palette, 1,2,4,8=grayscale+alpha, 8,16 8,16=RGB+alpha)
		 * - Color type         (1 byte)  2,6 (0=grayscale, 2=RGB, 3=palette, 4=grayscale+alpha, 6=RGB+alpha)
		 * - Compression method (1 byte)  0 (0=deflate/inflate compression with a sliding window of at most 32768 bytes)
		 * - Filter method      (1 byte)  0 (0=adaptive filtering with five basic filter types)
		 * - Interlace method   (1 byte)  0 (0=no interlace, 1=Adam7 interlace)
		 * IDAT Image data
		 * - Scanlines          ((4*Width+1)*Height bytes)
		 *   - Scanline         ((4*Width+1) bytes)
		 *     - Filter type    (1 byte)  added to the beginning of every scanline
		 *     - Pixels         (4*Width bytes)
		 *       - Pixel        (4 bytes) RGBA
		 * IEND Image trailer
		 * - empty
		 * 
		 * @param	source  The BitmapData that will be converted into the PNG format.
		 * @return          ByteArray representing the PNG encoded image data.
		 */
		public static function encode(source:BitmapData):ByteArray 
		{
			CRC_TABLE.fixed = true
			
			// Create output byte array.
			var png:ByteArray = new ByteArray();
			
			// Keep source image properties.
			var width:int = source.width;
			var height:int = source.height;
			var transparent:Boolean = source.transparent;
			
			// Write PNG file signature.
			png.writeBytes(SIGNATURE);
			
			// Write IHDR chunk.
			var header:ByteArray = new ByteArray();
			header.writeInt(width);
			header.writeInt(height);
			header.writeUnsignedInt((transparent)? 0x08060000: 0x08020000);
			header.writeByte(0);
			png.writeBytes(_createChunk(0x49484452, header));
			
			// Write IDAT chunk.
			var data:ByteArray = new ByteArray();
			var x:int, y:int, color:uint;
			if (transparent) {
				for (y = 0; y < height; y ++) {
					data.writeByte(0);
					for (x = 0; x < width; x ++) {
						color = source.getPixel32(x, y);
						data.writeUnsignedInt(((color & 0xFFFFFF) << 8) | (color >>> 24));
					}
				}
			} else {
				for (y = 0; y < height; y ++) {
					data.writeByte(0);
					for (x = 0; x < width; x ++) {
						color = source.getPixel(x, y);
						data.writeShort(color >>> 8);
						data.writeByte(color & 0xFF);
					}
				}
			}
			data.compress();
			png.writeBytes(_createChunk(0x49444154, data));
			
			// Write IEND chunk.
			png.writeBytes(IEND_CHUNK);
			
			return png;
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		private static function _createSignature():ByteArray 
		{
			var signature:ByteArray = new ByteArray();
			
			signature.writeUnsignedInt(0x89504E47);
			signature.writeUnsignedInt(0x0D0A1A0A);
			
			return signature;
		}
		
		private static function _createChunk(type:uint, data:ByteArray):ByteArray
		{
			var chunk:ByteArray = new ByteArray();
			
			// Write data length.(4 bytes)
			chunk.writeUnsignedInt((data)? data.length: 0);
			
			// Keep CRC start position.
			//var crcStart:uint = chunk.position;
			
			// Write chunk type.(4 bytes)
			chunk.writeUnsignedInt(type);
			
			// Write chunk data.(data.length bytes)
			if (data) chunk.writeBytes(data);
			
			// Keep CRC end position and calculate CRC length.
			var crcEnd:uint = chunk.position;
			var crcLength:int = crcEnd - 4;
			
			// Write CRC.(4 bytes)
			var c:uint = 0xFFFFFFFF;
			var i:int;
			chunk.position = 4;
			for (i = 0; i < crcLength; i ++) {
				c = CRC_TABLE[(c ^ chunk.readUnsignedByte()) & 0xFF] ^ (c >>> 8);
			}
			c ^= 0xFFFFFFFF;
			chunk.position = crcEnd;
			chunk.writeUnsignedInt(c);
			
			return chunk;
		}
		
		
	}
	
	internal class Label extends TextField 
	{
		public function Label(str:String) 
		{
			super();
			defaultTextFormat = new TextFormat('_sans', 12, 0x000000, true);
			autoSize = TextFieldAutoSize.LEFT;
			text = str;
		}
	}
	
	internal class HSV 
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		private var _color:uint;
		private var _hue:Number;
		private var _saturation:Number;
		private var _value:Number;
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		public function get color():uint { return _color; }
		public function set color(value:uint):void 
		{
			_color = value;
			_updateHSV();
		}
		
		public function get hue():Number { return _hue; }
		public function set hue(value:Number):void 
		{
			_hue = value;
			_updateColor();
		}
		
		public function get saturation():Number { return _saturation; }
		public function set saturation(value:Number):void 
		{
			_saturation = value;
			_updateColor();
		}
		
		public function get value():Number { return _value; }
		public function set value(value:Number):void 
		{
			_value = value;
			_updateColor();
		}
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function HSV(color:uint = 0x000000) 
		{
			_color = color;
			_updateHSV();
		}
		
		public static function constructWithRGB(rgb:RGB):HSV 
		{
			return new HSV(rgb.color);
		}
		
		public function clone():HSV 
		{
			return new HSV(_color);
		}
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		public function toString():String 
		{
			return '[HSV' + 
				   ' color=' + _color.toString(16) + 
				   ' hue=' + _hue.toString() + 
				   ' saturation=' + _saturation.toString() + 
				   ' value=' + _value.toString() + ']';
		}
		
		public function hex(length:int = 6):String 
		{
			var hex:String = _color.toString(16);
			while (hex.length < length) hex = '0' + hex;
			return '0x' + hex;
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		private function _updateHSV():void
		{
			var rgb:RGB = new RGB(_color);
			var ratioR:Number = rgb.red / 0xFF;
			var ratioG:Number = rgb.green / 0xFF;
			var ratioB:Number = rgb.blue / 0xFF;
			
			var h:Number, s:Number, v:Number;
			var max:Number = Math.max(ratioR, ratioG, ratioB);
			var min:Number = Math.min(ratioR, ratioG, ratioB);
			var difference:Number = max - min;
			if (max == ratioR) {
				h = 60 * (ratioG - ratioB) / difference;
			} else if (max == ratioG) {
				h = 60 * ((ratioB - ratioR) / difference + 2);
			} else {
				h = 60 * ((ratioR - ratioG) / difference + 4);
			}
			if (h < 0) {
				h += 360;
			}
			s = difference / max;
			v = max;
			
			_hue = h;
			_saturation = s;
			_value = v;
		}
		
		private function _updateColor():void
		{
			var h:Number = _hue;
			var s:Number = _saturation;
			var v:Number = _value;
			
			var ratioR:Number, ratioG:Number, ratioB:Number;
			h %= 360;
			h += (h < 0)? 360: 0;
			if (s != 0) {
				var hi:Number = Math.floor(h / 60) % 6;
				var f:Number = h / 60 - hi;
				var p:Number = v * (1 - s);
				var q:Number = v * (1 - f * s);
				var t:Number = v * (1 - (1 - f) * s);
				switch (hi) {
					case 0: ratioR = v; ratioG = t; ratioB = p; break;
					case 1: ratioR = q; ratioG = v; ratioB = p; break;
					case 2: ratioR = p; ratioG = v; ratioB = t; break;
					case 3: ratioR = p; ratioG = q; ratioB = v; break;
					case 4: ratioR = t; ratioG = p; ratioB = v; break;
					case 5: ratioR = v; ratioG = p; ratioB = q; break;
				}
			} else {
				ratioR = ratioG = ratioB = v;
			}
			
			_color = Math.round(0xFF * ratioR) << 16 | Math.round(0xFF * ratioG) << 8 | Math.round(0xFF * ratioB);
		}
		
		
	}
	
	internal class RGB 
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		private var _color:uint;
		private var _red:uint;
		private var _green:uint;
		private var _blue:uint;
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		public function get color():uint { return _color; }
		public function set color(value:uint):void 
		{
			_color = value;
			_updateRGB();
		}
		
		public function get red():uint { return _red; }
		public function set red(value:uint):void 
		{
			_red = value;
			_updateColor();
		}
		
		public function get green():uint { return _green; }
		public function set green(value:uint):void 
		{
			_green = value;
			_updateColor();
		}
		
		public function get blue():uint { return _blue; }
		public function set blue(value:uint):void 
		{
			_blue = value;
			_updateColor();
		}
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function RGB(color:uint = 0x000000) 
		{
			_color = color;
			_updateRGB();
		}
		
		public static function constructWithRGB(hsv:HSV):RGB 
		{
			return new RGB(hsv.color);
		}
		
		public function clone():RGB 
		{
			return new RGB(_color);
		}
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		public function toString():String 
		{
			return '[RGB' + 
				   ' color=' + _color.toString(16) + 
				   ' red=' + _red.toString() + 
				   ' green=' + _green.toString() + 
				   ' blue=' + _blue.toString() + ']';
		}
		
		public function toHex(length:int = 6):String 
		{
			var hex:String = _color.toString(16);
			while (hex.length < length) hex = '0' + hex;
			return '0x' + hex;
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		private function _updateRGB():void
		{
			_red = (_color & 0xFF0000) >> 16;
			_green = (_color & 0xFF00) >> 8;
			_blue = _color & 0xFF;
		}
		
		private function _updateColor():void
		{
			_color = _red << 16 | _green << 8 | _blue;
		}
		
		
	}
	
	internal class GraphicsPathUtil 
	{
		public static function createRect(x:Number, y:Number, width:Number, height:Number):GraphicsPath 
		{
			return createPolygon(Vector.<Point>([new Point(x, y), new Point(x + width, y), new Point(x + width, y + height), new Point(x, y + height)]));
		}
		
		public static function createPolygon(points:Vector.<Point>):GraphicsPath 
		{
			var commands:Vector.<int> = new Vector.<int>();
			var data:Vector.<Number> = new Vector.<Number>();
			
			var i:int, point:Point;
			var length:int = points.length;
			for (i = 0; i < length + 1; i ++) {
				point = points[i % length];
				
				commands.push(GraphicsPathCommand.LINE_TO);
				data.push(point.x, point.y);
			}
			commands[0] = GraphicsPathCommand.MOVE_TO;
			
			return new GraphicsPath(commands, data);
		}
	}










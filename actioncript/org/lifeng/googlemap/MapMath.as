package org.lifeng.googlemap
{
	public class MapMath
	{
		public function MapMath()
		{
		}
		public static function lngToPixel(value:Number,zoom:int):Number{
			var longitude:Number=180+value;
			var longTileSize:Number=360/Math.pow(2,(19-zoom));
			return longitude/longTileSize;
		}
		public static function latToPixel(value:Number,zoom:int):Number{
			var phi:Number=Math.PI*value/180;
			var siny:Number=Math.sin(phi);
			var res:Number=.5*Math.log((1+siny)/(1-siny));
			var maxTileY:Number=Math.pow(2,19-zoom);
			trace((1-res/Math.PI)*.5*maxTileY);
			return (1-res/Math.PI)*.5*maxTileY;
		}
		public static function pixelToLng(value:Number,zoom:int):Number{
			return value*(360/Math.pow(2,(19-zoom)))-180;
		}
		public static function pixelToLat(value:Number,zoom:int):Number{
			var maxTileY:Number=Math.pow(2,19-zoom);
			trace(maxTileY);
			var res:Number=(1-2*value/maxTileY)*Math.PI;
			trace(res);
			var z:Number=Math.pow(Math.E,2*res);
			trace(z);
			var siny:Number=(z-1)/(z+1);
			return Math.asin(siny)*180/Math.PI
		}
		/*public static function test(lat:Number):void{
			trace("["+lat+"]");
			if(lat>90){
				lat=lat-180;
			}
			
			if(lat<-90){
				lat=lat+180;
			}
			
			trace(lat)
		}*/
		
	}
}
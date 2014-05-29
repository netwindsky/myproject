package org.lifeng.math
{
	import flash.geom.Point;

	public class BaseMath
	{
		public static function getTweenDistance(x1:Number,y1:Number,x2:Number,y2:Number):Number{
			var dx:Number=x2-x1;
			var dy:Number=y2-y1;
			return Math.sqrt(dx*dx+dy*dy);
		}
		public static function degressToRadians(angle:Number):Number{
			return angle*(Math.PI)/180;
		}
		public static function radiansToDegrees(radians:Number):Number{
			return radians*(180/Math.PI);
		}
		public static function sinD(angle:Number):Number{
			return Math.sin(degressToRadians(angle));
		}
		public static function cosD(angle:Number):Number{
			return Math.cos(degressToRadians(angle));
		}
		public static function tgD(angle:Number):Number{
			return Math.tan(degressToRadians(angle));
		}
		public static function ctgD(angle:Number):Number{
			return 1/tgD(angle)
		}
		public static function atg2D(y:Number,x:Number):Number{
			return Math.atan2(y,x)*(180/Math.PI);
		}
		public static function acosD(ratio:Number):Number{
			return Math.acos(ratio)*(180/Math.PI);
		}
		public static function asin(ratio:Number):Number{
			return Math.asin(ratio)*(180/Math.PI);
		}
		public static function angleOfLine(x1:Number,y1:Number,x2:Number,y2:Number):Number{
			return atg2D(y2-y1,x2-x1);
		}
		public static function fixAngle(angle:Number):Number{
			angle%=360;
			return (angle<0)?angle+360:angle;
		}
		public static function getAngleForThreePoint(p1:Point,p2:Point,p3:Point):Number{
			var fa:Number=angleOfLine(p1.x,p1.y,p2.x,p2.y);
			var na:Number=angleOfLine(p3.x,p3.y,p2.x,p2.y);
			
			//trace("---->>>",fa,na,na-fa);
			
			return na-fa;
		}
		public static function compareLarge(a:Number,b:Number):Number{
			if(a>b){
				return a;
			}else{
				return b;
			}
		}
	}
}
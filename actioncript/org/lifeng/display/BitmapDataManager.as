package org.lifeng.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.lifeng.test.RunTimeManager;
	/**
	 * 
	 * 
	 * 图像裁剪
	 * 
	 * 
	 * 
	 * */
	public class BitmapDataManager
	{
		public function BitmapDataManager()
		{
		}
		
		
		public static function getImage(sourceDisplayobject:DisplayObject,_x:Number,_y:Number,_width:int,_height:int):Sprite{
			var sprite:Sprite=new Sprite();
			var step:int=2500
			var xnum:int=_width/step+1;
			var ynum:int=_height/step+1;
			
			var xoffset:int=_width%step;
			var yoffset:int=_height%step;
			
			sourceDisplayobject.x=-_x;
			sourceDisplayobject.y=-_y;
			
			var x:int=0;
			var y:int=0;
			
			var rt:RunTimeManager=new RunTimeManager();
			rt.setName("测试画图时间");
			rt.startTime();
			for(var j:int=0;j<ynum;j++){
				for(var i:int=0;i<xnum;i++){
					if(i!=xnum-1){
						var bd:BitmapData=new BitmapData(step,step,true,0);
						bd.draw(sourceDisplayobject);
						var bmp:Bitmap=new Bitmap(bd);
					
						bmp.x=i*step;
						bmp.y=j*step;
						
						sprite.addChild(bmp)
	
					}else{
						if(xoffset==0) continue;
						var bda:BitmapData=new BitmapData(xoffset,step,true,0);
						bda.draw(sourceDisplayobject);
						var bmpa:Bitmap=new Bitmap(bda);
					
						bmpa.x=i*step;
						bmpa.y=j*step;
						sprite.addChild(bmp);
					}
					
				}
				
			}
			rt.endTime();
			trace(xnum,ynum,xoffset,yoffset)
			
			
			return sprite;
		}
	}
}
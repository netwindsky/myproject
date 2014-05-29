package org.lifeng.v3d
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class V3DScene extends Sprite
	{
		//private var points:Vector=new Vector();
		public var camera:VCamera=new VCamera();
		public function V3DScene()
		{
			
		}
		
		
		public function render():void{
			
			
			
			
		}
		public function isRemove(vertex:Vertex3D):Boolean{
			
			//trace(1/Math.tan((camera.pan+90)*Math.PI/180));
			var b:Number=camera.z-(1/Math.tan((camera.pan+90)*Math.PI/180))*camera.x;
			//trace(b,camera.z);
			var ny:Number=(1/Math.tan((camera.pan+90)*Math.PI/180))*vertex.x+b;
			if(ny>vertex.z){
				return true;
			}else{
				return false;
			}
		}
		public function getPoint2D(vertex:Vertex3D):Point{
			
			
			var x_distance:Number = vertex.x - camera.x;         // first we determine x distance ball to camera
			var y:Number=0;
			
			//trace(x_distance,vertex.x,camera.x);
			/*if(obj.type=="sky"){
				y=800;
			}else{
				y=0;
			}*/
			//var y_distance:Number = y-sd.vscene.height*.5;     // y
			var y_distance:Number = vertex.y-camera.y//camera.height*.5;     // y
			var z_distance:Number =vertex.z-camera.z;        // z distance
			var tempx:Number, tempy:Number, tempz:Number;                        // some temporary variables
			
			var angle:Number=(360-camera.pan+90)*Math.PI/180;
			
			tempx = Math.cos(angle)*x_distance - Math.sin(angle)*z_distance;
			tempz = Math.sin(angle)*x_distance + Math.cos(angle)*z_distance;
			x_distance = tempx;
			z_distance = tempz;
			
			angle =  camera.tilt//Math.PI*.02; //Math.PI/10//_camera.angle;                    // the same thing we have for pitch angle
			tempy = Math.cos(angle)*y_distance - Math.sin(angle)*z_distance;
			tempz = Math.sin(angle)*y_distance + Math.cos(angle)*z_distance;
			y_distance = tempy;
			z_distance = tempz;
			
			angle =0;                         // and tilt angle
			tempx = Math.cos(angle)*x_distance - Math.sin(angle)*y_distance;
			tempy = Math.sin(angle)*x_distance + Math.cos(angle)*y_distance;
			x_distance = tempx;
			y_distance = tempy;
			
			//trace("z_distance--->>>",z_distance);
			
			
			var scale:Number=camera.width/(camera.width+z_distance);
			
			var x2d:Number=x_distance*scale+camera.width*.5;
			var y2d:Number=-y_distance*scale+camera.height*.5;
			
			if(z_distance>0){
				return new Point(x2d,y2d);
			}else{
				return null;
			}
			
			
		}
		public function getScale(vertex:Vertex3D):Number{
			var z_distance:Number =vertex.z-camera.z; 
			var scale:Number=camera.width/(camera.width+z_distance);
			return scale;
		}
		
	}
}
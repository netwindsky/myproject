/*

SkyBox example in Away3d

Demonstrates:

How to use a CubeTexture to create a SkyBox object.
How to apply a CubeTexture to a material as an environment map.

Code by Rob Bateman
rob@infiniteturtles.co.uk
http://www.infiniteturtles.co.uk

This code is distributed under the MIT License

Copyright (c)  

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

package org.lifeng.display
{
	import away3d.cameras.lenses.*;
	import away3d.containers.*;
	import away3d.controllers.HoverController;
	import away3d.entities.*;
	import away3d.materials.*;
	import away3d.materials.methods.*;
	import away3d.primitives.*;
	import away3d.textures.*;
	import away3d.utils.*;
	
	import org.lifeng.bulkloader.BulkLoader;
	import org.lifeng.bulkloader.BulkProgressEvent;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.ByteArray;
	
	import org.lifeng.lang.ArrayExt;
	import org.lifeng.math.BaseMath;

	//[SWF(backgroundColor="#000000", frameRate="60", quality="LOW")]
	
	public class Basic_SkyBox extends Sprite
	{
		// Environment map.
		
		//---------
		//--------右 right
		/*[Embed(source="../embeds/box/b_r.jpg")]
		private var EnvPosX:Class;
		//---------顶 top
		[Embed(source="../embeds/box/b_u.jpg")]
		private var EnvPosY:Class;
		
		//-----------前面front
		[Embed(source="../embeds/box/b_f.jpg")]
		private var EnvPosZ:Class;
		
		//----------左面 left
		[Embed(source="../embeds/box/b_l.jpg")]
		private var EnvNegX:Class;
		
		//---------底 bomb
		[Embed(source="../embeds/box/b_d.jpg")]
		private var EnvNegY:Class;
		//--------背面 black
		[Embed(source="../embeds/box/b_b.jpg")]
		private var EnvNegZ:Class;
		*/
		//engine variables
		private var _view:View3D;
		private var _cameraController:HoverController;
		private var cubeTexture:BitmapCubeTexture
		
		//scene objects
		private var _skyBox:SkyBox; 
		private var _torus:Mesh;
		//
		private var _move:Boolean = false;
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastMouseX:Number;
		private var _lastMouseY:Number;
		//
		var loader:BulkLoader=new BulkLoader("pano3d");
		
		
		
		private var _len:int=80;
		private var touchArr:ArrayExt=new ArrayExt();
		/**
		 * Constructor
		 */
		public function Basic_SkyBox()
		{
			addEventListener(Event.ADDED_TO_STAGE,addtoStage);
			loader.addEventListener(BulkProgressEvent.COMPLETE,completeH);
			
		}
		public function update(id:String):void{
			
			loader.add("360/"+id+"/b.jpg",{id:"back"});
			loader.add("360/"+id+"/d.jpg",{id:"down"});
			loader.add("360/"+id+"/f.jpg",{id:"front"});
			loader.add("360/"+id+"/l.jpg",{id:"left"});
			loader.add("360/"+id+"/r.jpg",{id:"right"});
			loader.add("360/"+id+"/u.jpg",{id:"up"});
			loader.start();
		}
		
		protected function completeH(event:BulkProgressEvent):void
		{
			
			//if(_skyBox.parent)
				//_view.scene.removeChild(_skyBox);
			// TODO Auto-generated method stub
			var loader:BulkLoader=BulkLoader.getLoader("pano3d");
			/*var backbytearr:ByteArray=loader.getBitmapData("back").getPixels(new Rectangle(0,0,1024,1024));
			trace(backbytearr.length);
			var frontbytearr:ByteArray=loader.getBitmapData("front").getPixels(new Rectangle(0,0,1024,1024));
			var downbytearr:ByteArray=loader.getBitmapData("down").getPixels(new Rectangle(0,0,1024,1024));
			var upbytearr:ByteArray=loader.getBitmapData("up").getPixels(new Rectangle(0,0,1024,1024));
			var leftbytearr:ByteArray=loader.getBitmapData("left").getPixels(new Rectangle(0,0,1024,1024));
			var rightbytearr:ByteArray=loader.getBitmapData("right").getPixels(new Rectangle(0,0,1024,1024));
			backbytearr.position=0;
			frontbytearr.position=0;
			downbytearr.position=0;
			upbytearr.position=0;
			leftbytearr.position=0;
			rightbytearr.position=0;*/
			//trace(cubeTexture.negativeZ)
			//cubeTexture.dispose();
			//cubeTexture=new BitmapCubeTexture(new BitmapData(1024,1024,true,0),new BitmapData(1024,1024,true,0),new BitmapData(1024,1024,true,0),new BitmapData(1024,1024,true,0),new BitmapData(1024,1024,true,0),new BitmapData(1024,1024,true,0))
			cubeTexture.dispose();
			cubeTexture.positiveX=loader.getBitmapData("right");
			cubeTexture.positiveY=loader.getBitmapData("up");
			cubeTexture.positiveZ=loader.getBitmapData("front");
			cubeTexture.negativeX=loader.getBitmapData("left");
			cubeTexture.negativeY=loader.getBitmapData("down");
			cubeTexture.negativeZ=loader.getBitmapData("back");
			
			
			/*cubeTexture.positiveX=loader.getBitmapData("right",true);
			cubeTexture.positiveY=loader.getBitmapData("up",true);
			cubeTexture.negativeZ=loader.getBitmapData("front",true);
			cubeTexture.negativeX=loader.getBitmapData("left",true);
			cubeTexture.negativeY=loader.getBitmapData("down",true);
			cubeTexture.negativeZ=loader.getBitmapData("back",true);*/
			//cubeTexture.
			//cubeTexture.positiveX.setPixels(new Rectangle(0,0,1024,1024),rightbytearr);
			//cubeTexture.positiveY.setPixels(new Rectangle(0,0,1024,1024),upbytearr);
			//cubeTexture.positiveZ.setPixels(new Rectangle(0,0,1024,1024),frontbytearr);
			//cubeTexture.negativeX.setPixels(new Rectangle(0,0,1024,1024),leftbytearr);
			//cubeTexture.negativeY.setPixels(new Rectangle(0,0,1024,1024),downbytearr);
			//cubeTexture.negativeZ.setPixels(new Rectangle(0,0,1024,1024),backbytearr);
			//cubeTexture.negativeZ=loader.getBitmapData("back");
			loader.removeAll();
			
		}
		protected function addtoStage(event:Event):void
		{
			// TODO Auto-generated method stub
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			//setup the view
			_view = new View3D();
			addChild(_view);
			
			//setup the camera
			_view.camera.z = -600;
			_view.camera.y = 0;
			_view.camera.lookAt(new Vector3D());
			_view.camera.lens = new PerspectiveLens(_len);
			
			
			_cameraController = new HoverController(_view.camera, null, 0, 0, 5000, -90);
			
			//setup the cube texture
			//var cubeTexture:BitmapCubeTexture = new BitmapCubeTexture(Cast.bitmapData(EnvPosX), Cast.bitmapData(EnvNegX), Cast.bitmapData(EnvPosY), Cast.bitmapData(EnvNegY), Cast.bitmapData(EnvPosZ), Cast.bitmapData(EnvNegZ));
			cubeTexture=new BitmapCubeTexture(new BitmapData(1024,1024,true,0),new BitmapData(1024,1024,true,0),new BitmapData(1024,1024,true,0),new BitmapData(1024,1024,true,0),new BitmapData(1024,1024,true,0),new BitmapData(1024,1024,true,0))
			
			//var cubeTexture:BitmapCubeTexture = new BitmapCubeTexture();
			//cubeTexture.positiveX=Cast.bitmapData(EnvNegX);
			//cubeTexture.positiveX.
			_skyBox = new SkyBox(cubeTexture);
			_skyBox.material.smooth=true;
			_view.scene.addChild(_skyBox);
			
			//setup the render loop
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
			
			
			if(Multitouch.supportsTouchEvents){
				trace("super");
				Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT;
				this.stage.addEventListener(TouchEvent.TOUCH_BEGIN,beginH);
				this.stage.addEventListener(TouchEvent.TOUCH_MOVE,moveH);
				this.stage.addEventListener(TouchEvent.TOUCH_END,endH);
				
			}else{
				
			}
		}
		
		protected function endH(event:TouchEvent):void
		{
			// TODO Auto-generated method stub
			//                                                      trace(event.touchPointID);
			if(touchArr.length==1){
				_move = false;
				event.updateAfterEvent();
				stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
			}
			
			touchArr.removeElement("id",event.touchPointID);
		}
		protected function moveH(event:TouchEvent):void
		{
			// TODO Auto-generated method stub
			var cobj:Object=touchArr.getElementByKeyAndValue("id",event.touchPointID);
			if(cobj==null)return;

			if(touchArr.length>1){
				if(cobj.id==touchArr.getElementByIndex(0).id||cobj.id==touchArr.getElementByIndex(1)){
					var obj:Object=touchArr.getElementByIndex(0);
					var obj1:Object=touchArr.getElementByIndex(1);
					var length:Number=BaseMath.getTweenDistance(obj.x,obj.y,obj1.x,obj1.y);
					var length1:Number;
					if(cobj.id==touchArr.getElementByIndex(0).id){
						obj.x=event.stageX;
						obj.y=event.stageY;
						length1=BaseMath.getTweenDistance(obj.x,obj.y,obj1.x,obj1.y);
					}else{
						obj1.x=event.stageX;
						obj1.y=event.stageY;
						length1=BaseMath.getTweenDistance(obj.x,obj.y,obj1.x,obj1.y);
					}

					if(length1>length){
						if(_len>20){
							_len-=1;
						}
						_view.camera.lens = new PerspectiveLens(_len);
					}else{
						if(_len<120){
							_len+=1;
						}
						_view.camera.lens = new PerspectiveLens(_len);
					}
				}
			}
			event.updateAfterEvent();
			
		}
		protected function beginH(event:TouchEvent):void
		{
			// TODO Auto-generated method stub
			touchArr.addElement({id:event.touchPointID,x:event.stageX,y:event.stageY});
			
			if(touchArr.length==1){
				_lastPanAngle = _cameraController.panAngle;
				_lastTiltAngle = _cameraController.tiltAngle;
				_lastMouseX = stage.mouseX;
				_lastMouseY = stage.mouseY;
				_move = true;
				stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
			}else{
				_move=false;
			}
		}
		
		/**
		 * render loop
		 */
		private function onEnterFrame(event:Event):void
		{
			if (_move) {
				_cameraController.panAngle = -(_len)/360*(stage.mouseX - _lastMouseX) + _lastPanAngle;
				_cameraController.tiltAngle = -(_len*.5)/360*(stage.mouseY - _lastMouseY) + _lastTiltAngle;
			}
			
			_view.render();
		}
		private function onMouseDown(event:MouseEvent):void
		{
			_lastPanAngle = _cameraController.panAngle;
			_lastTiltAngle = _cameraController.tiltAngle;
			_lastMouseX = stage.mouseX;
			_lastMouseY = stage.mouseY;
			_move = true;
			stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
			event.updateAfterEvent();
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			_move = false;
			event.updateAfterEvent();
			stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function onStageMouseLeave(event:Event):void
		{
			_move = false;
			stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		/**
		 * stage listener for resize events
		 */
		private function onResize(event:Event = null):void
		{
			_view.width = stage.stageWidth;
			_view.height = stage.stageHeight;
		}
	}
}

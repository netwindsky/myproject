/*
 * AbstractUI
 * 
 * Licensed under the MIT License
 * 
 * Copyright (c) 2008 cellfusion (www.cellfusion.jp), supported by Spark project (www.libspark.org).
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 */
package org.libspark.abstractUI.scrollbar.impl 
{
	import flash.display.DisplayObjectContainer;	
	import flash.display.InteractiveObject;	
	
	import org.libspark.abstractUI.AbstractUI;
	import org.libspark.abstractUI.events.ScrollbarEvent;
	import org.libspark.abstractUI.scrollbar.IScrollRepeat;
	import org.libspark.abstractUI.scrollbar.IScrollTween;
	import org.libspark.abstractUI.scrollbar.IScrollbar;
	import org.libspark.abstractUI.scrollbar.impl.SimpleScrollTween;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;	
	/**
	 * @author Mk-10:cellfusion
	 */
	public class SimpleScrollbar extends EventDispatcher implements IScrollbar 
	{
		private var _view:DisplayObject;
		private var _scrollPos:Number = 0;
		private var _maxScrollPos:Number;
		private var _minScrollPos:Number;
		private var _scrollSize:Number = 20;
		private var _pageSize:Number;
		private var _scrollRepeat:IScrollRepeat;
		private var _scrollTween:IScrollTween;
		
		private var _track:Sprite;
		private var _thumb:Sprite;
		private var _upButton:Sprite;
		private var _downButton:Sprite;

		public function get scrollPos():Number { return _scrollPos; }
		public function set scrollPos(value:Number):void
		{
			_scrollPos = value;
			dispatchEvent(new ScrollbarEvent(ScrollbarEvent.SCROLL_CHANGED));
			
			// 更新
			thumb.y = scrollPos;
		}
		
		public function get scrollPercent():Number { return (scrollPos - minScrollPos) / (maxScrollPos - minScrollPos) }
		
		public function get maxScrollPos():Number { return _maxScrollPos; }
		public function set maxScrollPos(value:Number):void
		{
			_maxScrollPos = Math.ceil(value);
		}
		
		public function get minScrollPos():Number { return _minScrollPos; }
		public function set minScrollPos(value:Number):void
		{
			_minScrollPos = Math.ceil(value);
		}

		public function get scrollSize():Number { return _scrollSize; }
		public function set scrollSize(value:Number):void
		{
			_scrollSize = value;
		}

		public function get pageSize():Number { return _pageSize; }
		public function set pageSize(value:Number):void
		{
			_pageSize = value;
			
			thumb.y = track.y;
			_scrollPos = minScrollPos;
			
			// ページのサイズに合わせて Thumb のサイズを変更する
			thumb.height = track.height * value;
			
			// Math.ceilしないと、ドラッグ可能加減とmaxScrollPosが違う
			_maxScrollPos = Math.ceil( track.y + track.height - thumb.height );
		}

		public function get scrollTween():IScrollTween { return _scrollTween; }
		public function get scrollRepeat():IScrollRepeat 
		{ 
			return _scrollRepeat; 
		}
		
		public function get thumb():Sprite { return _thumb; }
		public function set thumb(value:Sprite):void
		{
			value.mouseEnabled = true;
			_thumb = value;
		}
		
		public function get track():Sprite { return _track; }
		public function set track(value:Sprite):void
		{
			value.mouseEnabled = true;
			_track = value;
		}
		
		public function get upButton():Sprite { return _upButton; }
		public function set upButton(value:Sprite):void
		{
			value.mouseEnabled = true;
			_upButton = value;
		}
		
		public function get downButton():Sprite { return _downButton; }
		public function set downButton(value:Sprite):void
		{
			value.mouseEnabled = true;
			_downButton = value;
		}

		public function SimpleScrollbar(view:DisplayObjectContainer)
		{
			_view = view;
			_scrollTween = new SimpleScrollTween();
			_scrollRepeat = new SimpleScrollRepeat();
			
			try {
				_track = _view["track"];
			} catch(e:Event) {
				
			}
			
			try {
				_thumb = _view["thumb"];
			} catch(e:Event) {
				
			}
			
			try {
				_upButton = _view["upButton"];
			} catch(e:Event) {
				
			}
			
			try {
				_downButton = _view["downButton"];
			} catch(e:Event) {
				
			}
			_scrollPos = track.y;
			_minScrollPos = track.y;
			_maxScrollPos = track.y + track.height - thumb.height;
			
			_scrollSize = 20;
			
			if (thumb) thumb.addEventListener(MouseEvent.MOUSE_DOWN, dragStartHandler);
			
			if (track) track.addEventListener(MouseEvent.MOUSE_DOWN, scrollHandler);
			
			if (upButton) {
				upButton.addEventListener(MouseEvent.CLICK, scrollUpHandler);
				upButton.addEventListener(MouseEvent.MOUSE_DOWN, upButtonMouseDownHandler);
			}
			
			if (downButton) {
				downButton.addEventListener(MouseEvent.CLICK, scrollDownHandler);
				downButton.addEventListener(MouseEvent.MOUSE_DOWN, downButtonMouseDownHandler);
			}
		}
		
		private function dragStartHandler(event:MouseEvent):void
		{
			// スクロールを停止する
			_scrollTween.interrupt();
			
			// ドラッグできる範囲の Rectangle インスタンスを作成
			var bounds:Rectangle = new Rectangle(track.x, Math.ceil(track.y));
			bounds.right = track.width - thumb.width;
			bounds.height = Math.ceil(track.height - thumb.height);
			
			thumb.startDrag(false, bounds);
			AbstractUI._stage.addEventListener(MouseEvent.MOUSE_UP, dragEndHandler);
			AbstractUI._stage.addEventListener(Event.ENTER_FRAME, dragProgressHandler);
		}
		
		private function dragProgressHandler(event:Event):void
		{
			scrollPos = thumb.y;
		}
		
		private function dragEndHandler(event:MouseEvent):void
		{
			scrollPos = thumb.y;
			
			thumb.stopDrag();
			AbstractUI._stage.removeEventListener(MouseEvent.MOUSE_UP, dragEndHandler);
			AbstractUI._stage.removeEventListener(Event.ENTER_FRAME, dragProgressHandler);
		}

		public function scrollUp():void
		{
			var target:Number = _scrollPos - _scrollSize;
			
			scroll(target);
		}

		public function scrollDown():void
		{
			var target:Number = _scrollPos + _scrollSize;
			
			scroll(target);
		}

		public function scroll(target:Number):void
		{
			// ターゲットがはみ出してないか確認
			if (target < _minScrollPos) target = _minScrollPos;
			if (target > _maxScrollPos) target = _maxScrollPos;
			_scrollTween.scroll(this, target);
		}
		
		private function scrollHandler(event:MouseEvent):void
		{
			var target:Number = track.mouseY;
			
			scroll(target);
		}

		private function scrollDownHandler(event:MouseEvent):void
		{
			scrollDown();
		}

		private function scrollUpHandler(event:MouseEvent):void
		{
			scrollUp();
		}
		
		private function downButtonMouseDownHandler(event:MouseEvent):void
		{
			_scrollRepeat.repeatedClick(downButton, 2);
		}

		private function upButtonMouseDownHandler(event:MouseEvent):void
		{
			_scrollRepeat.repeatedClick(upButton, 2);
		}
	}
}

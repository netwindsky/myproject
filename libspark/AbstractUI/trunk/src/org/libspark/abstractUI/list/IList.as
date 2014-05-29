﻿/* * AbstractUI *  * Licensed under the MIT License *  * Copyright (c) 2008 cellfusion (www.cellfusion.jp), supported by Spark project (www.libspark.org). *  * Permission is hereby granted, free of charge, to any person obtaining a copy * of this software and associated documentation files (the "Software"), to deal * in the Software without restriction, including without limitation the rights * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell * copies of the Software, and to permit persons to whom the Software is * furnished to do so, subject to the following conditions: *  * The above copyright notice and this permission notice shall be included in * all copies or substantial portions of the Software. *  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN * THE SOFTWARE. *  */package org.libspark.abstractUI.list {	import flash.events.IEventDispatcher;		/**	 * @author Mk-10:cellfusion	 * リストボックスのロジッククラス	 * 	 * var list:IList = new ListImpl(myListSprice, new ScrollbarImpl(myScrollbarSprice));	 */	public interface IList extends IEventDispatcher 	{		/**		 * アイテムの数を取得します		 */		function get length():uint;				/**		 * 複数のアイテムを一度に選択できるかどうか		 */		function get allowMultipleSelection():Boolean;		function set allowMultipleSelection(value:Boolean):void;				/**		 * リストに表示される行数を返します		 */		function get rowCount():uint;		function set rowCount(value:uint):void;				/**		 * アイテムを選択できるかどうか		 */		function get selectable():Boolean;		function set selectable(value:Boolean):void;				/**		 * 選択されたアイテムのインデックスを取得します		 */		function get selectedIndex():int;		function set selectedIndex(value:int):void;				/**		 * 選択されたアイテムを含む配列を取得します		 */		function get selectedIndices():Array;		function set selectedIndices(value:Array):void;				/**		 * 選択されたアイテムを取得します		 */		function get selectedItem():*;		function set selectedItem(value:*):void;				/**		 * 選択されたアイテムのオブジェクトを含む配列を取得します		 */		function get selectedItems():Array;		function set selectedItems(value:Array):void;				/**		 * 指定されたインデックス位置のアイテムを取得します		 */		function getItemAt(index:uint):*;				/**		 * 指定されたアイテムがリストで選択されているかどうかを確認する		 */		function isItemSelected(item:*):Boolean;				/**		 * アイテムを追加する		 */		function addItem(item:*):*;				/**		 * アイテムを追加する		 */		function addItemAt(item:*, index:uint):*;				/**		 * アイテムを削除する		 */		function removeItem(item:*):*;				/**		 * 指定したインデックス位置のアイテムを削除します		 */		function removeItemAt(index:uint):*;				/**		 * アイテムを全て削除する		 */		function removeAll():void;				/**		 * 指定したインデックス位置にあるアイテムを別のアイテムで置き換えます		 */		function replaceItemAt(item:*, index:uint):*;				/**		 * 指定されたインデックス位置にあるアイテムまでスクロールします		 */		function scrollToIndex(index:int):void;				/**		 * selectedIndex プロパティの現在の値で示される位置にあるアイテムまでスクロールします		 */		function scrollToSelected():void;	}}
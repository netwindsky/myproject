﻿package org.libspark.abstractUI.events {	import flash.events.Event;	/**	 * @author Mk-10:cellfusion	 */	public class DialogboxEvent extends Event 	{		static public const CLOSE_BUTTON_CLICK:String = "closeButtonClick";		static public const YES_BUTTON_CLICK:String = "yesButtonClick";		static public const NO_BUTTON_CLICK:String = "noButtonClick";				public function DialogboxEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)		{			super(type, bubbles, cancelable);		}	}}
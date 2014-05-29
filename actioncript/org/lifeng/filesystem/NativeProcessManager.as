package org.lifeng.filesystem
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;

	public class NativeProcessManager
	{
		public static var nsp:NativeProcess;
		public function NativeProcessManager()
		{
		}
		public static function startupApp(path:String):NativeProcess{
			var pros:NativeProcessStartupInfo=new NativeProcessStartupInfo();
			var nativeprocess:NativeProcess;
			var file:File = new File(path);
			var args:Vector.<String> = new Vector.<String>();
			pros.arguments=args;
			pros.executable=file;
			nativeprocess=new NativeProcess();
			nativeprocess.addEventListener(NativeProcessExitEvent.EXIT,packageOverHandler);
			nativeprocess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,outputHandler);
			nativeprocess.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR,ioerrorHandler);
			nativeprocess.start(pros);
			
			return nativeprocess;
		}
		
		protected static function ioerrorHandler(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			trace("ioerror");
		}
		
		protected static function outputHandler(event:ProgressEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected static function packageOverHandler(event:NativeProcessExitEvent):void
		{
			// TODO Auto-generated method stub
			trace("exit");
		}
		public static function launchExec(file:File,argument:String):void{
			nsp=new NativeProcess();
			//nsp.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,onStandardOutputData);
			//nsp.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onError);
			
			trace(file.nativePath)
			var nspi:NativeProcessStartupInfo=new NativeProcessStartupInfo();
			var args:Vector.<String>=new Vector.<String>();
			/*args.push("d:\images\DSC00795.JPG");
			args.push("-resize");
			args.push("240x135 ");
			args.push("d:\images\small\DSC00795.JPG");
				*/
				// d:\images\DSC00795.JPG -resize 240x135  d:\images\small\DSC00795.JPG
			nspi.arguments=args;
			nspi.executable=file;
			nsp.start(nspi);
			
			trace("AAAAAAAAAAAAAAAAAAAA",nsp.toString())
		}
		
		
	}
}
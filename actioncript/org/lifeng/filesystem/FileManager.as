package org.lifeng.filesystem
{
	import flash.filesystem.File;

	public class FileManager
	{
		private var folderlist:Array=new Array();
		
		private var filelist:Array=new Array();
		private var filterext:Array;
		
		private var folders:Array=new Array();
		public function FileManager()
		{
			
		}
		/**
		 * 
		 * 
		 * 根据扩展名 查找文件。
		 * 
		 * 
		 * */
		public function getFilesScanFolder(_file:File,_filterext:Array=null,hassubfolder:Boolean=true):Array{
			filterext=_filterext;
			if(filterext){
				for(var i:int=0;i<filterext.length;i++){
					filterext[i]=String(filterext[i]).toLowerCase();
				}
			}
			if(hassubfolder){
				divideFolder(_file);
				while(true){
					if(folderlist.length>0){
						var file:File=folderlist.shift();
						
						divideFolder(file);
					}else{
						break;
					}
				}
			}else{
				var list:Array=_file.getDirectoryListing();
				while(list.length>0){
					var file:File=list.shift();
					if(!file.isDirectory){
						if(filterext){
							if(filterext.indexOf(file.extension.toLowerCase())!=-1){
								filelist.push(file);
							}
						}else{
							filelist.push(file);
						}	
					}
				}
			}

			return filelist;
		}
		public function getFoldersScanFolder(_file:File,hassubfolder:Boolean=true):Array{
			if(hassubfolder){
				divideForFolder(_file);
				while(true){
					if(folderlist.length>0){
						var file:File=folderlist.shift();
						divideForFolder(file);
					}else{
						break;
					}
				}
			}else{
				var list:Array=_file.getDirectoryListing();
				while(list.length>0){
					var file:File=list.shift();
					if(file.isDirectory){
						//folderlist.push(file);
						folders.push(file);
					}
				}
			}
			return folders;
		}
		
		private function divideForFolder(_file:File):void{
			var list:Array=_file.getDirectoryListing();
			while(list.length>0){
				var file:File=list.shift();
				if(file.isDirectory){
					folderlist.push(file);
					folders.push(file);
				}
			}
		}
		/**
		 * 
		 * 根据定义的扩展名，遍历文件夹，找到相应文件。
		 * 
		 * 
		 * */
		private function divideFolder(_file:File):void{
			
			trace(_file.nativePath)
			var list:Array=_file.getDirectoryListing();
			while(list.length>0){
				var file:File=list.shift();
				if(file.isDirectory){
					folderlist.push(file);
				}else{
					//trace(filterext,file.extension);
					if(filterext){
						if(filterext.indexOf(file.extension.toLowerCase())!=-1){
							filelist.push(file);
						}
					}else{
						filelist.push(file);
					}
				}
			}
		}
	}
}
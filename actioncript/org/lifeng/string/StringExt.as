package org.lifeng.string
{
	public class StringExt
	{
		private var _value:String="";
		
		private var _lines:Array;
		private var _linep:int=0;
		public function StringExt(str:String)
		{
			_value=str;
			_lines=_value.split("\r\n");
		}
		public function compareTo(a:String):Boolean{
			return _value==a;
		}
		public function compareToIgnoreCase():String{
			return _value.toLowerCase();
		}
		public function startsWith(startStr:String):Boolean{
			return _value.indexOf(startStr)==0;
		}
		public function endsWith(endStr:String):Boolean{
			return _value.lastIndexOf(endStr)==(_value.length-endStr.length);
		}
		public function replace(olds:String,news:String):String{
			var a:Array=olds.split("");
			var res:String="";
			for(var i:int=0;i<a.length;i++){
				var num:int=a[i].toString().charCodeAt(0);
				if((33<=num&&num<=47) || (58<=num&&num<=64) || (91<=num&&num<=96) || (123<=num&&num<=126)){
					res+="\\"+a[i];
				}else{
					res+=a[i];
				}
			}
			if(_value.indexOf(olds)!=-1){
				var reg:RegExp=new RegExp(res);
				var s:String=_value;
				while(true){
					if(reg.test(s)){
						s=s.replace(reg,news);	
					}else{
						break;
					}
				}
				return s;
			}else{
				return _value;
			}
		}
		public static function trim(s:String):String{
			/*for(var i:int=0;i<_value.length;i++){
				if(_value.charAt(i)!=" "){
					_value=_value.substr(i);
					break;
				}
			}
			for(var j:int=_value.length-1;j>0;j--){
				if(_value.charAt(j)!=" "){
					_value=_value.substr(0,j+1);
					break;
				}
			}*/
			return s.replace(/([ ]{1})/g,"");
			//return s.replace();
		}
		public function get string():String{
			return _value;
		}
		public function readLine():String{
			var str:String=_lines[_linep];
			_linep++
			return str;
		}
		public function hasNext():Boolean{
			if(_linep<_lines.length){
				return true;
			}else{
				return false;
			}
		}
	}
}
package org.lifeng.html
{
	public class ParseHTML
	{
		public static function parseImageURL(str:String):String{
			var s:String;
			var p:RegExp;
			p=/\bhttp\S*\bjpg\b/;
			s=p.exec(str);
			if(s==null){
				p=/\bhttp\S*\bgif\b/
				s=p.exec(str);
				if(s==null){
					p=/\bhttp\S*\bpng\b/
					s=p.exec(str);
					if(s==null){
						p=/\bhttp\S*\bbmp\b/
						s=p.exec(str);
						if(s==null){
							p=/src=\"\S*\"/;
							s=p.exec(str);
							trace("------>>"+s)
							p=/\bhttp\S*\"/
							s=p.exec(s);
							trace(s);
							if(s==null) return null;
							s=s.split("\"")[0];
						}
					}
					
				}
			}
			return s;
		}
	}
}
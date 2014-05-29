package org.lifeng.utils
{
	public class NameCreator
	{
		private var dc:Array=["cloudy","windy","sunny","rainy","snowy","moon","star","hurricane","earthquake","sky","river","sea","lake","hill","mountain"];
		private var year:Array=["1900","1901","1902","1903","1904","1905","1906","1907","1908","1909","1910","1911","1912","1913","1914","1915","1916","1917","1918","1919","1920","1921","1922","1923","1924","1925","1926","1927","1928","1929","1930","1931","1932","1933","1934","1935","1936","1937","1938","1939","1940","1941","1942","1943","1944","1945","1946","1947","1948","1949","1950","1951","1952","1953","1954","1955","1956","1957","1958","1959","1960","1961","1962","1963","1964","1965","1966","1967","1968","1969","1970","1971","1972","1973","1974","1975","1976","1977","1978","1979","1980","1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","1012"];
		private var monty:Array=["01","02","03","04","05","06","07","08","09","10","11","12"];
		private var day:Array=["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"];
		private var dw:Array=["cat","rabbit","horse","elephant","ant","fish","bird","eagle","beaver","snake","mouse","squirrel","kangaroo","monkey","panda","bear","lion","tiger","fox","zebra","deer","giraffe","goose","hen","turkey","lamb","sheep","goat","cow","","donkey","squid","lobster","shark","seal","sperm","whale","killerwhale","bee","chicken","frog","orangutan","wolf","parrot","dragon","owl","camel","spider","goldfish","manatee","polarbear","turtle","octopus","penguin"];
		public function NameCreator()
		{
			/*var str:String="cat,dog,pig,duck,rabbit,horse,elephant,ant,fish,bird,eagle,beaver,snake,mouse,squirrel,kangaroo,monkey,panda,bear,lion,tiger,fox,zebra,deer,giraffe,goose,hen,turkey,lamb,sheep,goat,cow,,donkey,squid,lobster,shark,seal,sperm,whale,killerwhale,bee,chicken,frog,orangutan,wolf,parrot,dragon,owl,camel,spider,goldfish,manatee,polarbear,turtle,octopus,penguin";
			var arr:Array=str.split(",");
			var s:String="";
			for(var i:int=0;i<arr.length;i++){
				s+='"'+arr[i]+'",';
			}
			trace(s);*/
		}
		public function getNames():Array{
			var array:Array=new Array();
			for(var a:int=0;a<dc.length;a++){
				for(var e:int=0;e<dw.length;e++){
					for(var b:int=0;b<year.length;b++){
						for(var c:int=0;c<monty.length;c++){
							//for(var d:int=0;d<day.length;d++){
								array.push(dc[a]+dw[e]+year[b]+monty[c]);
							//}
								trace(dc[a]+dw[e]+year[b]+monty[c]);
						}
					}
				}
			}
			return array;
		}
	}
}
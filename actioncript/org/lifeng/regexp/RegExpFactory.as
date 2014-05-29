package org.lifeng.regexp
{
	import flash.text.StaticText;

	/**
	 * 
	 * 
	 * g -- 使用 String 类的 replace() 方法时，指定此修饰符可替换所有匹配项，而不只替换第一个匹配项。 此修饰符对应于 RegExp 实例的 global 属性。
	 * i -- 计算正则表达式时不 区分大小写。 此修饰符对应于 RegExp 实例的 ignoreCase 属性。
	 * s -- 点 (.) 字符与换行符相匹配。 请注意，此修饰符对应于 RegExp 实例的 dotall 属性。
	 * m -- 尖号 (^) 字符和美元符号 ($) 在换行符之前和之后匹配。 此修饰符对应于 RegExp 实例的 multiline 属性。
	 * x -- 忽略 re 字符串中的空白字符，所以您可以编写更加易读的构造函数。 此修饰符对应于 RegExp 实例的 extended 属性。
	 * 
	 */
	
	/**
		.（小圆点）
	　　匹配除换行符号外的任意字符
	　　\w
	　　匹配字母、数字、下划线
	　　\s
	　　匹配任意空白字符
	　　\d
	　　匹配数字
	　　\b
	　　匹配单词的开始或结束
	　　^
	　　匹配字符串的开始，或排除
	　　$
	　　匹配字符串的结束
	　　以上都是单个字符匹配
	　　如果要求匹配元字符中的符号，则需要加反斜杠。例如\+表示匹配加号
	　　wqe.eew.rt和wqe\.eew\.rt*
	　　重复零次或多次
	　　+
	　　重复一次或多次
	　　？
	　　重复零次或一次
	　　{n}
	　　重复n次
	　　{n,}
	　　至少重复n次
	　　{n,m}
	　　重复n到m次
	　　\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}
	　　^w{3}\..+\.\w+$
	　　[]
	　　表示匹配中括号中的任一字符
	　　()
	　　小括号内的为一个整体
	　　|
	　　前后两者任意匹配一种
 	*/

	public class RegExpFactory
	{
		public function RegExpFactory()
		{
		}
		/**
		 *获取给定两个符号间的字符串。 
		 * 
		 */
		public static function getStringByAandB(a:String,b:String):RegExp{
			var regexp:RegExp=new RegExp(a+".*"+b,"igs");
			return regexp;
		}
		/**
		 * 
		 * 过滤字符。
		 */
		public static function getFilterByA(a:String):RegExp{
			var regexp:RegExp=new RegExp("[^"+a+"]","g");
			return regexp;
		}
	}
}
package org.lifeng.text
{
	import flash.utils.Dictionary;

	public class FontCNNameToEN
	{
		public var namedic:Dictionary=new Dictionary();
		public var FontNameList:Array=['Arial','Times New Roman','Verdana','微软雅黑','宋体','新宋体','仿宋','仿宋_GB2312','隶书','黑体','楷体','楷体_GB2312','幼圆','华文仿宋','华文琥珀','华文彩云','华文细黑','华文宋体','华文行楷','华文新魏','华文隶书','华文中宋','华文楷体','方正姚体','方正舒体']
		public function FontCNNameToEN()
		{

			
			
			
			
			
			namedic["华文中宋"]="STZhongsong"
			namedic["华文仿宋"]="STFangsong"
			namedic["华文宋体"]="STSong"
			
			namedic["华文彩云"]="STCaiyun"
			namedic["华文新魏"]="STXinwei"
			namedic["华文楷体"]="STKaiti"
			namedic["华文琥珀"]="STHupo"
			namedic["华文细黑"]="STXihei"
			namedic["华文行楷"]="STXingkai"
			namedic["华文隶书"]="STLiti"
			namedic["幼圆"]="YouYuan"
			namedic["方正姚体"]="FZYaoti"
			namedic["方正舒体"]="FZShuTi"
			namedic["隶书"]="LiSu"
			namedic["黑体"]="SimHei";
			namedic["宋体"]="SimSun";
			namedic["新宋体"]="NSimSun";
			namedic["仿宋"]="FangSong";
			namedic["楷体"]="KaiTi";
			namedic["仿宋_GB2312"]="FangSong_GB2312";
			namedic["楷体_GB2312"]="KaiTi_GB2312";
			namedic["微软雅黑"]="Microsoft YaHei";
			namedic["Arial"]="Arial";
			namedic["Verdana"]="Verdana";
			namedic["Times New Roman"]="Times New Roman";
			/*华文中宋 STZhongsong
			华文仿宋 STFangsong
			华文宋体 STSong
			华文彩云 STCaiyun
			华文新魏 STXinwei
			华文楷体 STKaiti
			华文琥珀 STHupo
			华文细黑 STXihei
			华文行楷 STXingkai
			华文隶书 STLiti
			幼圆 YouYuan
			
			
			方正姚体 FZYaoti
			方正舒体 FZShuTi
			
			隶书 LiSu
				*/
		}
		public function getFontENName(cn:String):String{
			return namedic[cn];	
		}
	}
}
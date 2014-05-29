///////////////////////////////////////////////////////////
//  AbsMediator.as
//  Macromedia ActionScript Implementation of the Class AbsMediator
//  Generated by Enterprise Architect
//  Created on:      22-十二月-2011 14:13:59
//  Original author: lifeng
///////////////////////////////////////////////////////////

package org.lifeng.puremvc
{

	
	
	import flash.display.Sprite;
	
	import org.lifeng.puremvc.compent.AbsComponent;
	import org.lifeng.puremvc.compent.AbsMainStageView;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	

	/**
	 * 抽象类。
	 * @author lifeng
	 * @version 1.0
	 * @updated 04-一月-2012 11:37:13
	 */
	public class AbsMediator extends Mediator implements IMediator
	{
		
		public function AbsMediator(name:String,viewComponent:*):void{
			super(name, viewComponent);
		}

	    /**
		 * 添加到显示列表。
		 */
	    public function addToView(): void
	    {
			//var mainapp:AbsMainLayerType=facade.retrieveMediator(MainStageVeiwMediator.NAME).getViewComponent() as MainStageView;
			//trace("----------------->>>>>",getView().TYPE);
			var layer:AbsMainStageView=AbsMainStageView.getInstance();
			var container:Sprite=layer.getContainerByType(getView().TYPE);
			if(container){
				if(getView()!=null){
					container.addChild(getView());
				}else{
					//throw(new Error("ABSMainLayerType.as"))

				}
			}else{
				throw(new Error("请检查您所写的View是的TYPE变量是否定义！Type类型参考ABSMainLayerType.as"))
			}

	    }

		/**
		 * 显示对象从显示列表移除，并且销毁。
		 */
	    public function removeView(): void
	    {
			if(getView()){
				if(getView().parent!=null){
					getView().parent.removeChild(getView());
				}
			}
	    }
		/**
		 * 获取显示对象。
		 */
		public function getView():AbsComponent
		{
			return getViewComponent() as AbsComponent;
		}
		

	}//end AbsMediator

}
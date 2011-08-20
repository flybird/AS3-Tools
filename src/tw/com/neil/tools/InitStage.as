package tw.com.neil.tools 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	
	/**
	 * this class is set Stage param, like align、scal、menu...etc
	 * @author Neil
	 */
	public class InitStage 
	{
		// -----------------------------------------//
		// Const Variables
		// -----------------------------------------//
		
		/** scale mode */
		public static const SCALE_EXACT_FIT:String = StageScaleMode.EXACT_FIT;
		public static const SCALE_NO_BORDER:String = StageScaleMode.NO_BORDER;
		public static const SCALE_NO_SCALE:String = StageScaleMode.NO_SCALE;
		public static const SCALE_SHOW_ALL:String = StageScaleMode.SHOW_ALL;		
		
		// align
		public static const ALIGN_BOTTOM:String = StageAlign.BOTTOM;
		public static const ALIGN_BOTTOM_LEFT:String = StageAlign.BOTTOM_LEFT;
		public static const ALIGN_BOTTOM_RIGHT:String = StageAlign.BOTTOM_RIGHT;
		public static const ALIGN_LEFT:String = StageAlign.LEFT;
		public static const ALIGN_RIGHT:String = StageAlign.RIGHT;
		public static const ALIGN_TOP:String = StageAlign.TOP;
		public static const ALIGN_TOP_LEFT:String = StageAlign.TOP_LEFT;
		public static const ALIGN_TOP_RIGHT:String = StageAlign.TOP_RIGHT;
		
		// quality
		public static const QUALITY_BEST:String = StageQuality.BEST;
		public static const QUALITY_HIGH:String = StageQuality.HIGH;
		public static const QUALITY_LOW:String = StageQuality.LOW;
		public static const QUALITY_MEDIUM:String = StageQuality.MEDIUM;
		
		//
		
		/** initialzation param
		 * @param	e  trigger THIS already add to stage.
		 * 
		 */
		public static function setStage(stage:Stage, 
										scale:String,
										quality:String,
										align:String, 
										menu:Boolean):void
		{		
			// set stage params
			stage.scaleMode = scale;
			stage.quality = quality;
			stage.align = align;
			stage.showDefaultContextMenu = menu? true:false;
		}
		
	}
	
}
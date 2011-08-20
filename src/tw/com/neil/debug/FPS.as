package tw.com.neil.debug 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
                
	public class FPS extends Sprite
	{
		private var txt:TextField;
		private var count:int=0
		private var rate:uint = 0;
		private var bgH:uint = 20;
		
		public function FPS()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
	
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			rate = stage.frameRate;
			
			txt = new TextField();
			txt.textColor = 0xffffff;	
			addChild(txt)			
			
			var myTimer:Timer = new Timer(1000);				
			myTimer.addEventListener(TimerEvent.TIMER, timerHandler);	
			this.addEventListener(Event.ENTER_FRAME, countHandler);
			myTimer.start();	
		}
		
		private function timerHandler(event:TimerEvent):void
		{	
			var bgW:Number = count / rate * stage.stageWidth;
			drawsBg(bgW);
			
			txt.text=" FPS :" + count + " / " + rate;
			count = 0;
		}
				
		private function countHandler(event:Event):void
		{
			count++;
			if (count > rate) count = rate;			
		}
		
		private function drawsBg(bgW:Number):void
		{
			graphics.clear();
			graphics.beginFill(0x990000, .8);
			graphics.drawRect(0, 0, bgW , bgH);
			graphics.endFill();
		}
	}
}
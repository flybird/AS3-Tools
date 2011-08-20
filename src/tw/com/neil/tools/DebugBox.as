package tw.com.neil.tools 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/** 
	 * This is a debug tool, you can use this to print message
	 * @author Neil
	 */
	public class DebugBox extends Sprite
	{
		public static const TOP:String = "top";
		public static const BUTTON:String = "button";
		private const DISPLAY_HEIGHT:Number = 50;
		
		private var _position:String = "button";
		private var _fontcolor:Number = 0xffffff;
		private var _backgroundColor:Number = 0x000000;
		private var _alpha:Number = .6;
		private var _background:Sprite;
		private var _container:Sprite;
		
		private var _textfield:TextField;
		
		
		// ----------------------------------------------
		// Construct
		// ----------------------------------------------
		
		public function DebugBox() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE , init);
		}
		
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_container = new Sprite();			
			_background = new Sprite();
			
			visible = false;
			
			drawBackground();
			createTextField();
			
			_container.addChild(_background);
			_container.addChild(_textfield);
			addChild(_container);
			addEvent();
			
			stage.dispatchEvent(new Event(Event.RESIZE));
		}
		
		// ----------------------------------------------
		// public function 
		// ----------------------------------------------
		private static var _instance:DebugBox;
		public static function getInstance():DebugBox {
			if (DebugBox._instance == null)
			{
				DebugBox._instance = new DebugBox();
			}
			
			return DebugBox._instance;
		}
		
		public function setPosition(position:String):void {
			_position = position;
			
		}
		
		public function setMessage(message:String):void	{
			_textfield.text = message;
		}
		
		public function addMessage(message:String, newline:Boolean = false):void {
			if (newline) _textfield.appendText("\n");
			_textfield.appendText(message);
			_textfield.scrollV = _textfield.maxScrollV -1;
			
			trace("add msg: " + message);
		}
		
		
		public function print(message:String):void {
			_textfield.text = message;
		}
		
		
		// ----------------------------------------------
		// Private function 
		// ----------------------------------------------
		private function addEvent():void
		{
			stage.addEventListener(Event.RESIZE, stageResize);
		}
		
		private function createTextField():void
		{
			_textfield = new TextField();
			_textfield.x = _textfield.y = 10
			_textfield.width = stage.stageWidth - 50;
			_textfield.height = DISPLAY_HEIGHT - 10;
			_textfield.multiline = true;
			_textfield.selectable = true;
			_textfield.autoSize = TextFieldAutoSize.LEFT;
			_textfield.wordWrap = true;
			_textfield.textColor = _fontcolor;
			_textfield.text = "initial debuge box...";
		
		}
		
		private function stageResize(e:Event):void
		{
			drawBackground();
			
			var ty:Number;
			switch (_position)
			{
				case DebugBox.BUTTON:
					ty = stage.stageHeight - DISPLAY_HEIGHT;
					break;
				case DebugBox.TOP:
					ty = 0;
					break;
			}
			_container.x =0;
			_container.y = ty;
		}
		
		private function drawBackground():void {
			_background.graphics.clear();
			_background.graphics.beginFill(_backgroundColor, _alpha);
			_background.graphics.drawRect(0, 0, stage.stageWidth, DISPLAY_HEIGHT);
			_background.graphics.endFill();
			
		}	
		
	}
	
}
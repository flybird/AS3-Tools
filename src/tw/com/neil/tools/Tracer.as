package tw.com.neil.tools {	
	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;
	public class Tracer {
		private static const DEFAULT_SPACE:String = "   ";	
		private static var oldTime		:Number = 0;
		private static var firstTime	:Number = 0;
		private static var _enabled		:Boolean = true;
		private static var ignoreList	:Array = [];		
		public static function log(pScope:*, pMessage:* , ...arg):void {				
			var _className:String;	
			
			if (!_enabled) return;
			
			if (pScope is String) _className = pScope;
			else 				  _className = "[" + getQualifiedClassName(pScope).split('::').pop() + "]";				
			
			// ignored classes don't get logged		
			for each (var o:String in ignoreList) {
				if (_className.indexOf(o) > -1 ) return;				
			}
			
				
			var _actTime	:Number =  new Date().getTime();
			var _startDiff	:Number = 0.00;
			var _lastDiff	:Number = 0.00;
			if(firstTime == 0){
				firstTime = _actTime;
			}else{
				_startDiff = Math.round((_actTime-firstTime) / 1000);				
				_lastDiff = _actTime-oldTime;
			}
			oldTime = _actTime;
			var _traceStr:String = _startDiff + "\t" + (_lastDiff > 999?_lastDiff:_lastDiff + "\t") + "\t" + _className + "\t" + pMessage.toString();
			
			for (var i:int = 0; i < arg.length; i++) {
				_traceStr += ", " +arg[i].toString() + ", ";
			}
			trace (_traceStr);							
		}				
		/*
		public static function resetIgnoredClasses():void {
			ignoreList.splice(0);
		}		
		public static function addIgnoredClass(pTarget:*):void {
			var _className:String;
			if (pTarget is String)	_className = pTarget;
			else 					_className = getQualifiedClassName(pTarget).split('::').join('.');			
			ignoreList.push(_className);
		}*/
		/**
		 * 得知物件裡的屬性。
		 * @param	pObj 物件。
		 * @param	pDescription 說明：
		 * @return 字串。
		 */
		public static function echo(pObj:*, pDescription:* = null):String {								
			if (pObj == null) throw new Error("object is null");				
			
			var _sb					:StringBuilder = new StringBuilder();			
			var _qualifiedClassName	:String = getQualifiedClassName(pObj)
			_sb.appendText("-----------------------------");			
			_sb.appendText("( " + _qualifiedClassName + " " + ((pDescription == null) ? "" : pDescription.toString()) + " ){");										
			switch (_qualifiedClassName) {
				case "Boolean" :
				case "int" :
				case "Number" :
				case "String" :
					_sb.appendText(pObj.toString());
					break;		
				case "Array" :
				case "Object":
				case "flash.utils::ByteArray" :
				case "Object" :
				case "flash.utils::Dictionary":				
					for (var a:* in pObj) {				
						traceEval(pObj[a], a, 1 ,_sb);				
					}						
					break;
				default :						
					echoVariable(pObj, 1, _sb);	
			}			
			_sb.appendText("}");
			_sb.appendText("-----------------------------");
			if (_enabled) trace(_sb.toString());									
			return _sb.toString();
		}				

		private static function traceEval(pValue:*, pObj:*, pLevel:int , _sb:StringBuilder):void {				
			var _space:String = "";			
			for (var i:int = 0; pLevel > i; i++) {
				_space += DEFAULT_SPACE;
			}			
			var _qualifiedClassName		:String = getQualifiedClassName(pValue);						
			switch (_qualifiedClassName) {
				case "Boolean" :
				case "int" :
				case "Number" :
				case "String" :
				case "uint" :
				case "Function" :					
					_sb.appendText(_space + "[" + pObj + "] : " + _qualifiedClassName + " = " + pValue);						
					break;				
				case "Array" :
				case "flash.utils::ByteArray" :
				case "Object" :
				case "flash.utils::Dictionary":
					_sb.appendText(_space + "[" + pObj + "] : " + _qualifiedClassName +" {");					
					for (var a:* in pValue) {
						traceEval(pValue[a], a, pLevel + 1, _sb);												
					}
					_sb.appendText(_space+"}");
					break;								
				default:									
					_sb.appendText(_space + "[" + pObj + "] : [" + _qualifiedClassName.toString() + "]");										
					echoVariable(pValue, pLevel + 1, _sb);					
					//_sb.appendText(_space+"}");					
					break;				
			}
		}
		private static function echoVariable(pObj:Object , pLevel:int, _sb:StringBuilder):void {						
			var _space:String = "";			
			for (var i:int = 0; pLevel > i; i++) {
				_space += DEFAULT_SPACE;
			}	
			var _description:XML = describeType(pObj);						
			var _length:uint = _description.variable.length();			
			if (_length == 0) return ;							
			for each (var xx:XML in _description.variable) {								
				traceEval(pObj[xx.@name] , xx.@name, pLevel + 1 , _sb);
				//_sb.appendText(_space + "[" + xx.@name + "] : " + xx.@type + " = " +  pObj[xx.@name]);							
			}			
			var pMethod:Boolean = false;
			if (pMethod) {				
				_length = _description.method.length();				
				if (_length > 0) {					
					for each ( xx in _description.method) {						
						_sb.appendText(_space + "[" + xx.@name + "] : Function return " +  xx.@returnType);	
					}					
				}				
			}		
		}
	}
}
internal class StringBuilder {
	private var _str:String = "";
	public function StringBuilder() {  }
	public function appendText(pNewText:String):void {		_str += pNewText + "\n";	}
	public function clear():void {	_str = ""	};
	public function toString():String {		return _str;	}
}
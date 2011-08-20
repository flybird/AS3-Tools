/*
 *
 * 可以使用SendAndLoadVariables來傳輸資料給伺服器，並回傳得到資料
 *
 * 使用方法：
 *
 * // 建立一欲傳資料內容的陣列
 * var datas:Array = new Array();
 *	   datas['name'] = "Neil";
 *	   datas['birthday'] = "720617";
 *
 * //建立SendAndLoadVariables物件
 * var load:SendAndLoadVariables = new SendAndLoadVariables();
 *	   load.sendAndLoad(URL:String, datas:Array, loaded:Fundion);
 *
 */

package tw.com.neil.web {
	import flash.display.Loader;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.net.sendToURL;

	public class SendAndLoadVariables extends EventDispatcher {
		private var _loadedFunction:Function;
		
		public static const POST_METHOD:String = "POST";
		public static const GET_METHOD:String = "GET";

		public static const RETURN_TYPE_BINARY:String = "BINARY";
		public static const RETURN_TYPE_TEXT:String = "TEXT";
		public static const RETURN_TYPE_VARIABLES:String = "VARIABLES";
		
		public static const WINDOW_BLANK:String = "window_blank";
		public static const WINDOW_SELF:String = "window_self";


		public function SendAndLoadVariables(){}

		public function sendAndLoad(url:String, datas:Array, method:String, returnType:String, loadedFunction:Function, isXML:Boolean = false):void {
			_loadedFunction = loadedFunction;

			var request:URLRequest = new URLRequest(url);
			var variables:URLVariables = new URLVariables();

			for (var str:*in datas){
				variables[str] = datas[str];
			}

			if (isXML){
				request.contentType = "text/xml";
			}
			request.data = variables;
			//trace("save data:\n" + request.data['xmldata']);

			switch (method){
				case SendAndLoadVariables.GET_METHOD:
					request.method = URLRequestMethod.GET;
					break;
				case SendAndLoadVariables.POST_METHOD:
					request.method = URLRequestMethod.POST;
					break;
			}

			var loader:URLLoader = new URLLoader();
			switch (returnType){
				case RETURN_TYPE_BINARY:
					loader.dataFormat = URLLoaderDataFormat.BINARY;
					break;
				case RETURN_TYPE_TEXT:
					loader.dataFormat = URLLoaderDataFormat.TEXT;
					break;
				case RETURN_TYPE_VARIABLES:
					loader.dataFormat = URLLoaderDataFormat.VARIABLES;
					break;

			}
			loader.addEventListener(Event.COMPLETE, loadedComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onioerror);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onhttpstatus);
			loader.load(request);
		}

		private function onioerror(et:IOErrorEvent):void {
			dispatchEvent(et);
		}
		
		private function onhttpstatus(et:HTTPStatusEvent):void {
			dispatchEvent(et);
		}
		
		public function sendData(url:String, datas:Array,method:String):void {
			var request:URLRequest = new URLRequest(url);
			var variables:URLVariables = new URLVariables();
			for (var str:*in datas){
				variables[str] = datas[str];
			}
			request.data = variables;
			switch (method){
				case SendAndLoadVariables.GET_METHOD:
					request.method = URLRequestMethod.GET;
					break;
				case SendAndLoadVariables.POST_METHOD:
					request.method = URLRequestMethod.POST;
					break;
			}
			
			sendToURL(request);
		}
		
		
		
		
		private function loadedComplete(e:Event):void {
			var loader:URLLoader = URLLoader(e.target);
			_loadedFunction(loader);
		}
		

		
		public function myNavigateToURL(url:String, datas:Array, method:String,window:String="_blank"):void {

			var request:URLRequest = new URLRequest(url);
			
			switch (method){
				case SendAndLoadVariables.GET_METHOD:
					request.method = URLRequestMethod.GET;
					break;
				case SendAndLoadVariables.POST_METHOD:
					request.method = URLRequestMethod.POST;
					break;
			}
			
			var variables:URLVariables = new URLVariables();

			for (var str:*in datas){
				variables[str] = datas[str];
			}
			
			request.data = variables;
			navigateToURL(request, window);
		}
		

	}
}
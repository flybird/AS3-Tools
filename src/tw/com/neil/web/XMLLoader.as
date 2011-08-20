﻿/** * * @author Neil Chan * * 分析xml的基底類別 * * * */package tw.com.neil.web {	import flash.errors.IOError;	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.events.ProgressEvent;	import flash.events.SecurityErrorEvent;	import flash.events.HTTPStatusEvent;	import flash.events.IOErrorEvent;	import flash.events.IEventDispatcher;	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.net.URLLoaderDataFormat;	import flash.system.System;	//import gogotdi.ebook.Debug;	/*	 *	 *	 *	 */	public class XMLLoader extends EventDispatcher{		private var _loader:URLLoader;		private var _xml:XML;		private var _loaded:Function;		/**		 * 建構式		 *		 * @param	url		 * @param	xmlLoaded		 */		public function XMLLoader(){			init();		}		private function init():void {			_loader = new URLLoader();			_loader.dataFormat = URLLoaderDataFormat.TEXT;			configureListeners(_loader);		}		/**		 * 初始化載入事件		 *		 * @param	dispatcher		 */				private function configureListeners(dispatcher:IEventDispatcher):void {			dispatcher.addEventListener(Event.COMPLETE, loadComplete);			dispatcher.addEventListener(Event.OPEN, open);			dispatcher.addEventListener(ProgressEvent.PROGRESS, progress);			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatus);			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioError);		}		/**		 * 載入xml方法		 *		 * @param	url			載入xml的位置		 * @param	xmlLoaded	載入完成後執行的 function		 */		private var _url:String;		public function load(url:String, loaded:Function):void {			_url = url;			_loaded = loaded;			_loader.load(new URLRequest(url));		}						/**		 * 開始載入xml時發生的事件		 *		 * @param	event	Event.OPEN事件		 */		private function open(event:Event):void {			//trace("XML Open: " + event);		}		/**		 * 載入的過程發生的事件		 *		 * @param	event 	ProgressEvent.PROGRESS事件		 */		private function progress(event:ProgressEvent):void {						//trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);		}		/**		 * 載入XML完成的動作		 *		 * @param	event	Event.COMPLETE事件		 */		private function loadComplete(event:Event):void {			//System.useCodePage = true;			//trace("event.target.data:" + event.target.data);			_xml = new XML(event.target.data); //將下載的文字轉成xml實體			//trace(stage.getChildByName("info_txt"));			//trace("url: " + _url + "has loaded.");			//Debug.printLine(_url + " has loaded.");			//trace("載入完成");			//trace("將下載的文字轉成xml實體 +\n" + _xml);						_loaded();			//loadedFuncion(); //載入完成		}		/**		 * 載入時發生安全性問題		 *		 * @param	event	SecurityErrorEvent.SECURITY_ERROR 事件		 */		private function securityError(event:SecurityErrorEvent):void {			//trace("Security Error: " + event);		}		/**		 * 載入時發生網路的連線問題		 *		 * @param	event	HTTPStatusEvent.HTTP_STATUS 事件		 */		private function httpStatus(event:HTTPStatusEvent):void {			//trace("Security Error: " + event);		}		/**		 * IO不可使用或無法存取時執行		 *		 * @param	event	IOErrorEvent.IO_ERROR事件		 */		private function ioError(event:IOErrorEvent):void {			trace("ioErrorHandler: " + event.toString);			dispatchEvent(event);			//trace("error");		}		public function getXML():XML {			return _xml;		}		//protected function loadedFuncion():void {			//trace("loaded Function");			//_loaded(); //執行載入後的動作		//}	}}
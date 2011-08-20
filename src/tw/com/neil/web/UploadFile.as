package tw.com.neil.web
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class UploadFile extends Sprite
	{
		private const LOCAL_PREVIEW:String = "local_preview";
		private const UPLOAD_COMPLETE:String = "start_upload";
		
		private var fileReference:FileReference;
		private var _status:String = LOCAL_PREVIEW;
		
		private var _anime:MovieClip;
		
		public function UploadFile()
		{
			trace("init");
			fileReference = new FileReference();
			addEvent()
		}
		
		private function addEvent():void
		{			
			fileReference.addEventListener(Event.SELECT, fileHandler);
			fileReference.addEventListener(Event.CANCEL, fileHandler);
			fileReference.addEventListener(Event.OPEN, fileHandler);
			fileReference.addEventListener(Event.SELECT, fileHandler);
			fileReference.addEventListener(Event.COMPLETE, fileHandler);
            
			fileReference.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadCompleteHandler);
			fileReference.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			fileReference.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            fileReference.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            fileReference.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			
		}
		
		public function browseFile():void
		{	
			fileReference.browse([new FileFilter("mp3 files","*.*")]);
		}
		
		public function cancel():void
		{
			fileReference.cancel();
			dispatchEvent(new Event(Event.CANCEL));
		}
		
		
		private var uploadURL:URLRequest;
		// 上傳後的名字
		private var _tempFileName:String = "music";
		public function upload(url:String):void
		{
			uploadURL = new URLRequest(url);
			
			// 傳入上傳資訊
			//var newName = escape(fileReference.name);
			var newName:String = _tempFileName;
			var vars:URLVariables = new URLVariables();
				vars.file_name = newName;
				
			uploadURL.data = vars;
			uploadURL.method = URLRequestMethod.POST;
			fileReference.upload(uploadURL);
		}
		
		
		
		private function fileHandler(event:Event):void 
		{
			switch(event.type) {  
                case Event.COMPLETE:
					if (_status == UPLOAD_COMPLETE) {
						trace("sound has uploaded.");						
						_tempFileName = escape(event.target.name);
					}
					break;  
                case Event.SELECT:
					trace("select");
					_status = LOCAL_PREVIEW;
					dispatchEvent(new Event(Event.SELECT));
					//loader.getSound(fileReference);
                    break;  
                case Event.OPEN:
					//trace("open");
                    break; 
				case Event.CANCEL:
					//trace("cancel");	
					break;
			}
        }
		
		private function uploadCompleteHandler(event:DataEvent):void {
            // trace("upload_complete_data");
			_status = UPLOAD_COMPLETE;
			dispatchEvent(new Event(Event.COMPLETE));
        }
		
		private function httpStatusHandler(event:HTTPStatusEvent):void {
            // trace("httpStatusHandler: " + event + " ,status" + event.status);
        }
        
        private function ioErrorHandler(event:IOErrorEvent):void {
            // trace("ioErrorHandler: " + event);
        }
		private function securityErrorHandler(event:SecurityErrorEvent):void {
           // trace("securityErrorHandler: " + event);
        }

		private function progressHandler(event:ProgressEvent):void {
			trace("sound is uploading now.");
			if (hasAnimeMovie){
				var percentage:Number = (Math.floor((event.bytesLoaded / event.bytesTotal) * 100));
				//_anime.info_txt.text = "File is uploading now, wait a moment please.\nLoading..." + percentage + "%";
				_anime.bar_mc.scaleX = percentage / 100;
				_anime.info_txt.text = "上傳中，請稍等一會..." + percentage + "%";
			}
        }
		
		

		
		public function getTempSoundName():String
		{
			return _tempFileName;
		}
		
		private var hasAnimeMovie:Boolean = false;
		public function setAnime(mc:MovieClip):void
		{
			hasAnimeMovie = true;
			_anime = mc;
		}
		public function getInfo():String
		{
			var creator:String = (fileReference.creator == null)? "無名氏":fileReference.creator;
			var time:Date  = fileReference.modificationDate;
			var year:String  = String(time.fullYear);
			var month:String = String(time.month +1);
			var day:String   = String(time.day);
			var size:String  = (fileReference.size > 1024 * 1024)? Math.round(fileReference.size * 100 / (1024 * 1024)) / 100 + "MB":Math.round(fileReference.size * 10 / 1024) / 10 + "KB";
			//":);
			var str:String = "創建者： " + creator;
				//str += "" + fileReference.data;
				str += "\n時　間： " + year + "." + month + "." + day;
				str += "\n名　稱： " + fileReference.name;
				str += "\n大　小： " + size;
			
			return str;
		}
		
		
		
	}
}

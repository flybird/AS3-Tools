package tw.com.neil.sound {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.ID3Info;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;


	public class LoadSound extends Sprite {
		public var _sound:Sound;
		private var _buffer:SoundLoaderContext; // 音效緩衝區 5000->5秒
		private var _channel:SoundChannel;
		private var _loop:Number;

		private var _anime:MovieClip;


		public function LoadSound():void {
			_channel = new SoundChannel();
		}

		/*
		 * playSound(聲音路徑, 緩衝區, 是否載入URL原則檔案,循環幾次,中斷點,第幾個)
		 *
		 */

		public function toLoad(url:String = "", burrer:uint = 1000):void {
			_sound = new Sound();
			_buffer = new SoundLoaderContext(burrer);
			_sound.load(new URLRequest(url), _buffer);

			_sound.addEventListener(Event.COMPLETE, completeHandler);
			_sound.addEventListener(Event.ID3, id3Handler);
			_sound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_sound.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_sound.addEventListener(Event.OPEN, openHandler);
			
			//addEventListener(re
		}
		
		public function onPlayPause():void 
		{
			
			trace("position : " + _channel.position);
			if(_playing){
				_position = _channel.position;
				_channel.stop();
			}
			else{
				_channel = _sound.play(_position);
			}
			_channel.addEventListener(Event.SOUND_COMPLETE, soundcomplete);
			_playing = !_playing;
			trace("_playing : "+_playing);
		}

		// 播放聲音
		public function toPlay(useCutPoint:Boolean = false, loop:int = 0, cutPoint:Array = null, index:int = 0):void {
			toStop();
			_loop = loop;
			if (useCutPoint){
				_channel = _sound.play(cutPoint[index], _loop);
			} else {
				_channel = _sound.play(_position, _loop);
			}

			_channel.addEventListener(Event.SOUND_COMPLETE, soundcomplete);
			
			_playing = true;
		}

		// 暫停聲音
		private var _position:Number = 0;
		private var _playing:Boolean = false;

		public function playAndPause():void {
			//trace("_position: " + _position);
			if (_playing){
				_position = _channel.position;
				_channel.stop();
				trace("stop");
			} else {
				trace("play");
				_channel = _sound.play(_position, _loop);

			}
			_playing = !_playing;
		}



		// 停止聲音
		public function toStop():void {
			_playing = false;
			_channel.stop();
			_position = 0;
		}

		// 設定聲音大小
		public function setPen(vol:Number):void {

		}

		// 設定動畫
		public function setAnime(mc:MovieClip):void {
			_anime = mc;
		}


		private var _message:String = "";

		public function setMessage(msg:String):void {
			_message = msg;
		}

		/**
		 * There are several different events of sound.
		 */
		private function completeHandler(event:Event):void {
			trace("sound has loaded.");
			dispatchEvent(new Event(Event.COMPLETE));
		}

		private function id3Handler(event:Event):void {
			trace("id3Handler: " + event);
		}

		private function ioErrorHandler(event:Event):void {
			trace("ioErrorHandler: " + event);
			dispatchEvent(new Event(IOErrorEvent.IO_ERROR));
		}

		private function progressHandler(event:ProgressEvent):void {
			//trace("progressHandler: " + event);
			//trace("sound is loading now.");
			if (_anime && _anime.info_txt){
				var percentage:Number = (Math.floor((event.bytesLoaded / event.bytesTotal) * 100));
				//_anime.info_txt.text = "File is loading now, wait a moment please.\nLoading..." + percentage + "%";
				_anime.bar_mc.scaleX = percentage / 100;
				_anime.info_txt.text = _message + percentage + "%";
			}
			dispatchEvent(event);
		}



		private function soundcomplete(event:Event):void{
			trace("soundcomplete()");
			//_channel = _sound.play(_position,_loop);
			dispatchEvent(event);
		}

		private function openHandler(event:Event):void {
			dispatchEvent(event);
		}

	}
}
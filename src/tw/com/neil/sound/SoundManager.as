package tw.com.neil.sound {
	
	import flash.display.DisplayObject;
	import flash.errors.IOError;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	public class SoundManager {
		private static var _instance:SoundManager = null;
		private var _volume:Number = 1;
		private var _soundMute:Boolean = false;
		private var sounds:Array = [];
		private var channels:Array = [];
		
		public function SoundManager() {}
		
		public static function getInstance():SoundManager {
			if (SoundManager._instance == null) {
				SoundManager._instance = new SoundManager();
			}
			return SoundManager._instance;
		}
		
		// 加入聲音
		public function addSound(soundName:String, url:String):void {
			var sound:Sound = new Sound();
				sound.load(new URLRequest(url));
			sounds[soundName] = sound;			
		}
		
		// 播放聲音
		public function playSound(soundName:String, startTime:Number = 0, loops:int = 1, volume:Number = 1 , isSoundTrack:Boolean = false):void {
			if (!sounds[soundName]) { 
				trace("Class SoundManager::playSound(): \nThere isn't a sound like this name:" + soundName + " ,please check the name or use function addSound() first.");
				return; 
			}
			var tempSoundTransform:SoundTransform = new SoundTransform();
				tempSoundTransform.volume = volume;
			
			channels[soundName] = sounds[soundName].play(startTime, loops);
			channels[soundName].soundTransform = tempSoundTransform;
			
			sounds[soundName].addEventListener(Event.OPEN, onSoundOpen);
			sounds[soundName].addEventListener(ProgressEvent.PROGRESS, onSoundProgress);
			sounds[soundName].addEventListener(IOErrorEvent.IO_ERROR, onIOErrorOpen);
		}
		
		// 停止聲音
		public function stopSound(soundName:String):void {
			channels[soundName].stop();
		}
		
		// 設定聲音大小
		public function setVolume(value:Number):void {
			_volume = value;
			
			var tempMuteSoundTransform:SoundTransform = new SoundTransform(); 
				tempMuteSoundTransform.volume = _volume;
			SoundMixer.soundTransform = tempMuteSoundTransform;
		}
		
		// 關閉、開啟聲音	
		public function muteSound():void {
			var tempMuteSoundTransform:SoundTransform = new SoundTransform(); 
			if (_soundMute) {
				_soundMute = false;
				tempMuteSoundTransform.volume = 0;
				SoundMixer.soundTransform = tempMuteSoundTransform;
			}else{
				_soundMute = true;
				tempMuteSoundTransform.volume = _volume;
				SoundMixer.soundTransform = tempMuteSoundTransform;
			}
		}
		
		
		// 事件處理函數
		private function onSoundOpen(et:Event):void {
			trace("Class SoundManager::onSoundOpen(): " + et);
		}
		private function onSoundProgress(et:ProgressEvent):void {
			trace("Class SoundManager::onSoundProgress(): " + et);
		}
		private function onIOErrorOpen(et:IOError):void {
			trace("Class SoundManager::onIOErrorOpen(): " + et);
		}
	}
}
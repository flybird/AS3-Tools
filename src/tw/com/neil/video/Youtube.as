package tw.com.neil.video {
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.system.Security;
	import flash.net.URLRequest;
	
	//import timber.demo.*;
	//import choppingblock.video.*;

	/**
	 * ...
	 * @author Neil
	 */
	public class Youtube extends Sprite {
		public static var PLAY:String = "play";
		public static var PAUSE:String = "pause";
		public static var STOP:String = "stop";
		
		
		private var player:Object;
		private var loader:Loader;
		private var movieURL:String;
		
		public function Youtube():void {
			if (stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
				addEventListener(Event.REMOVED_FROM_STAGE, onremoved);
			}
		}
		
		private function onremoved(et:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onremoved);
			player.destroy();
			
		}
		
		public function setMovieURL(url:String):void {
			
			var URL:String= url.replace("watch?v=", "v/");
			movieURL = URL;
			//trace("movieURL:　" + movieURL);
		}
		
		public function loadMovie():void {
			//var URL:String = "http://www.youtube.com/watch?v=Ke2QKx26iNc";
			//trace("loadMovie");
			//player.loadVideoByUrl("http://www.youtube.com/v/vHURiTjidrI&hl=zh_TW&fs=1&");
			player.loadVideoByUrl(movieURL);
			player.pauseVideo();
			//player.seekTo(0);
		}
		
		public function setSize(w:Number, h:Number):void {
			player.setSize(w, h);
		}
		
		
		public function playVideo():Number {
			return player.playVideo();
		}
		public function pauseVideo():Number {
			return player.pauseVideo();
		}
		public function stopVideo():Number {
			return player.stopVideo();
		}
		public function seekTo(seconds:Number, allowSeekAhead:Boolean):Number {
			return player.seekTo(seconds,allowSeekAhead);
		}
		
		public function getPlayerState():Number {
			return player.getPlayerState();
		}
		
		public function mute():Number {
			return player.mute();
		}
		public function unMute():Number {
			return player.unMute();
		}
		public function isMuted():Boolean {
			return player.isMuted();
		}
		public function setVolume(num:Number):Number {
			return player.setVolume(num);
		}
		public function getVolume():Number {
			return player.getVolume();
		}
		
		
		public function getCurrentTime():Number {
			return player.getCurrentTime();
		}
		public function getDuration():Number {
			return player.getDuration();
		}
		public function getVideoBytesLoaded():Number {
			return player.getVideoBytesLoaded();
		}
		public function getVideoBytesTotal():Number {
			return player.getVideoBytesTotal();
		}
		
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Security.allowDomain("www.youtube.com");
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
			loader.load(new URLRequest("http://www.youtube.com/apiplayer?version=3"));
			//loader.load(new URLRequest("http://www.youtube.com/v/VIDEO_ID?version=3"));
			
			addEvents();
		}

		private function onLoaderInit(event:Event):void {
			addChild(loader);
			
			loader.content.addEventListener("onReady", onPlayerReady);
			loader.content.addEventListener("onError", onPlayerError);
			loader.content.addEventListener("onStateChange", onPlayerStateChange);
			loader.content.addEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
			//loader.x = loader.y = 80;
			
		}
		
		private function onPlayerReady(event:Event):void {
			// Event.data contains the event parameter, which is the Player API ID 
			//trace("player ready:", Object(event).data);

			// Once this event has been dispatched by the player, we can use
			// cueVideoById, loadVideoById, cueVideoByUrl and loadVideoByUrl
			// to load a particular YouTube video.
			player = loader.content;
			// Set appropriate player dimensions for your application
			
			//player.loadVideoById("D2gqThOfHu4");
			//player.loadVideoByUrl("http://www.youtube.com/v/vHURiTjidrI&hl=zh_TW&fs=1&");
			dispatchEvent(event);
		}

		private function onPlayerError(event:Event):void {
			// Event.data contains the event parameter, which is the error code
			//trace("player error:", Object(event).data);
		}

		private function onPlayerStateChange(event:Event):void {
			// Event.data contains the event parameter, which is the new player state
			//trace("player state:", Object(event).data);
			switch (Object(event).data) {
				case 1:
					//trace("111");
					//addEventListener(Event.ENTER_FRAME, enterframe);
					break;
				case 2:
					//trace("222");
					//removeEventListener(Event.ENTER_FRAME, enterframe);
					break;
			}
			dispatchEvent(event);
		}
		
		
		
		private function onVideoPlaybackQualityChange(event:Event):void {
			// Event.data contains the event parameter, which is the new video quality
			//trace("video quality:", Object(event).data);
		}


		private function addEvents():void {
			addEventListener(Event.REMOVED_FROM_STAGE, removefromestage);
		}
		
		public function removefromestage(e:Event):void {
			stopVideo();
			loader.contentLoaderInfo.removeEventListener(Event.INIT, onLoaderInit);
			loader.content.removeEventListener("onReady", onPlayerReady);
			loader.content.removeEventListener("onError", onPlayerError);
			loader.content.removeEventListener("onStateChange", onPlayerStateChange);
			loader.content.removeEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
		}
	}
}
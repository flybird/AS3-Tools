/**
 * author: shinder.lin@gmail.com
 */
package tw.com.neil.web {
	
	import flash.display.DisplayObject;

	public class HttpDomain {
		public var defaultDomain:String = "http://localhost";
		private var displayObj:DisplayObject;

		
		public function HttpDomain(displayObj:DisplayObject){
			this.displayObj = displayObj;
		}

		public function get domain():String{
			var url_str:String = displayObj['stage'].loaderInfo.loaderURL;

			if (url_str.indexOf("http://") == 0 || url_str.indexOf("https://") == 0){
				var s_index:int = url_str.indexOf("/", 10);
				return url_str.substring(0, s_index);
			} else {
				return defaultDomain;
			}
		}
	}
}
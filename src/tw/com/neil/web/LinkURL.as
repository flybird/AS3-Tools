/**
* 使用簡單方法連結網址
* 
* @author Neil Chan
* 
*/

package tw.com.neil.web 
{
	import flash.net.URLLoader;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class LinkURL 
	{
		
		public function LinkURL() 
		{
		}
		
		/**
		 * 連結網址
		 * 
		 * @param	url			連結的網址
		 * @param	window		開啟於那一個視窗
		 */
		public static function link(url:String,window:String="_self"):void
		{
			navigateToURL(new URLRequest(url),window);
		}
	}
	
}
/**
* ...
* @author Neil Chan
*/

package tw.com.neil.tools 
{
	import flash.net.URLLoader;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class LinkURL 
	{
		
		public function LinkURL(url:String) 
		{
			var request:URLRequest = new URLRequest(url);
			navigateToURL(request);
		}
	}
	
}
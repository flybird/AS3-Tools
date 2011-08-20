package tw.com.neil.tools 
{

	public class CheckData 
	{
		private var _data:String;
		
		
		public function CheckData() 
		{
		}
		
		public static function checkEmail(_data:String):Boolean
		{			
			var emailPattern:RegExp = /[a-z0-9]@/;
			return (emailPattern.test(_data))? true:false;
		}
		
		public function checkLink(_data:String):Boolean
		{
			var linkPattern:RegExp = /http:\/\//;
			return (linkPattern.test(_data))? true:false;
		}
	}
	
}
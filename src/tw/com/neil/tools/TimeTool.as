package tw.com.neil.tools
{
	public class TimeTool
	{
		private var currentTime:Date = new Date();
		private var nowTime:String="";
		
		public function TimeTool()
		{
		}
		
		public function getNowTime():String
		{
			var year:uint = currentTime.getFullYear();
			var mouth:uint = currentTime.getMonth()+1;// 0-一??
			var date:uint = currentTime.getDate();//1-31
		
			var hours:uint = currentTime.getHours();
			var minutes:uint = currentTime.getMinutes();
			
			//
			var mStr:String=mouth.toString();
			if (mStr.length == 1)  mStr="0"+mStr;
			
			//
			var dStr:String=date.toString();
			if (dStr.length == 1)  dStr="0"+dStr;
			
			//
			var apm:String="AM";
			if (hours>=12) 
			{
				apm="PM";
				hours = hours - 12 ;
			}
		
			nowTime = "Date: " + year+"/"+mStr+"/"+dStr+"  "+hours+":"+minutes+" "+ apm;
			return nowTime;
		}
	}
}
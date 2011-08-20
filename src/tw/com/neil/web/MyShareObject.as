package tw.com.neil.web 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import flash.text.TextField;
	
	//import tw.com.neil.tools.DebugBox;
	
	public class MyShareObject 
	{
		private var mySo:SharedObject;
		
		public function MyShareObject(soName:String,domain:String = "/"):void {
			
			//trace("soName: " + soName);
			mySo = SharedObject.getLocal(soName, domain);
			//DebugBox.getInstance().addMessage("MyShareObject init()", true);
			
			if (!mySo.data.info)
			{
				//trace("new shara object");
				mySo.data.info = new Array();
			}else {
				//trace(mySo.data.info[0].isloaded);
			}
			
			//mySo.data.info = new Object();
			//trace("\nSharedObject loaded...: " + mySo);
			//output.appendText("loaded value: " + mySo.data.savedValue + "\n\n");
		}
		
		public function getLen():int {
			return mySo.data.info.length;
		}
		
		public function getData(index:int = 0):Object {
			if (!mySo.data.info[index]) {
				return new Object();
			}
			return mySo.data.info[index];
		}
		
		public function deleteData(index:int):void {
			mySo.data.info.splice(index, 1);
		}
		
		public function setData(info:Object, index:int = 0):void{
			mySo.data.info[index] = info;
			//trace("info length: " + mySo.data.info.length);
			//DebugBox.getInstance().print("setData(): " + index + "index: " + info);
			
			
			var flushStatus:String = null;
			
            try {
                flushStatus = mySo.flush(10000);
            } catch (error:Error) {
			   //DebugBox.getInstance().print("Error...Could not write SharedObject to disk");
               trace("Error...Could not write SharedObject to disk\n");
            }
			
            if (flushStatus != null) {
                switch (flushStatus) {
                    case SharedObjectFlushStatus.PENDING:
                        //trace("Requesting permission to save object...\n");
						//DebugBox.getInstance().addMessage("::Requesting permission to save object...");
                        mySo.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
                        break;
                    case SharedObjectFlushStatus.FLUSHED:
                       // trace("Value flushed to disk.\n");
					  // DebugBox.getInstance().addMessage("Value flushed to disk. len: "  + getLen());
                       break;
                }
            }
			
		}
		
		public function resortData():void {
			mySo.data.info.sort(compare);
		}
		
		private function compare(a:Object, b:Object):int {
			if (a.jumppage > b.jumppage) return 1;
			if (b.jumppage > a.jumppage) return -1;
			return 0;
		}
		
		public function clearAllData():void {
			mySo.data.info = new Array();
		}
		
		private function onFlushStatus(event:NetStatusEvent):void {
           trace("User closed permission dialog...\n");
            switch (event.info.code) {
                case "SharedObject.Flush.Success":
                    trace("User granted permission -- value saved.\n");
					//DebugBox.getInstance().print("User granted permission -- value saved.");
                    break;
                case "SharedObject.Flush.Failed":
                    trace("User denied permission -- value not saved.\n");
					//DebugBox.getInstance().print("User denied permission -- value not saved.");
                    break;
            }

            mySo.removeEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
        }
		
	}
	
}
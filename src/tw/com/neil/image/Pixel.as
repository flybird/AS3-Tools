package tw.com.neil.image{
  public class Pixel {
    private var value:uint;
    
    public function Pixel (n1:uint, n2:int=0, n3:int=0, n4:int=0) {
      if (arguments.length == 1) {
        value = n1;
      } else {
        value = n1<<24 | n2<<16 | n3<<8 | n4;
      }
    }

    public function setAlpha (n:int):void {
      if (n < 0 || n > 255) {
        throw new RangeError("Supplied value must be in the range 0-255.");
      }
      value &= (0x00FFFFFF);
      value |= (n<<24);
    }

    public function setRed (n:int):void {
      if (n < 0 || n > 255) {
        throw new RangeError("Supplied value must be in the range 0-255.");
      }
      value &= (0xFF00FFFF);
      value |= (n<<16);
    }

    public function setGreen (n:int):void {
      if (n < 0 || n > 255) {
        throw new RangeError("Supplied value must be in the range 0-255.");
      }
      value &= (0xFFFF00FF);
      value |= (n<<8);
    }

    public function setBlue (n:int):void {
      if (n < 0 || n > 255) {
        throw new RangeError("Supplied value must be in the range 0-255.");
      }
      value &= (0xFFFFFF00);
      value |= (n);
    }

    public function getAlpha ():int {
      return (value >> 24) & 0xFF;
    }
    
    public function getRed ():int {
      return (value >> 16) & 0xFF;
    }
    
    public function getGreen ():int {
      return (value >> 8) & 0xFF;
    }

    public function getBlue ():int {
      return value & 0xFF;
    }
   
    public function toString ():String {
      return toStringARGB();
    }

    public function toStringARGB (radix:int = 16):String {
      var s:String = 
           "A:" + ((value >> 24)&0xFF).toString(radix).toUpperCase()
        + " R:" + ((value >> 16)&0xFF).toString(radix).toUpperCase()
        + " G:" + ((value >> 8)&0xFF).toString(radix).toUpperCase()
        + " B:" + (value&0xFF).toString(radix).toUpperCase();

      return s;
    }

    public function toStringAlpha (radix:int = 16):String {
      return ((value >> 24)&0xFF).toString(radix).toUpperCase();
    }

    public function toStringRed (radix:int = 16):String {
      return ((value >> 16)&0xFF).toString(radix).toUpperCase();
    }

    public function toStringGreen (radix:int = 16):String {
      return ((value >> 8)&0xFF).toString(radix).toUpperCase();
    }

    public function toStringBlue (radix:int = 16):String {
      return (value&0xFF).toString(radix).toUpperCase();
    }
  }
}
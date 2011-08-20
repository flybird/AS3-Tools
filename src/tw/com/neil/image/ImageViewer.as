package tw.com.neil.image {
  import flash.display.*;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import flash.net.URLRequest;
  import flash.geom.Rectangle;
  import flash.events.*;

  public class ImageViewer extends Sprite {
    // Loader object. Visual asset used to load image.
    private var imgLoader:Loader;

    // Border shape. Visual asset to be added to display list.
    private var border:Shape = null;

    // Border style.
    private var borderThickness:Number;
    private var borderColor:Number;

    // Outer dimensions of entire viewer (including border).
    private var w:Number;
    private var h:Number;

    // Text field in which to display download progress.
    private var loadStatus_txt:TextField;
	
	private var _loadMotion:Sprite;

    // Constructor
    public function ImageViewer (x:Number = 0, 
                                 y:Number = 0, 
                                 w:Number = 0, 
                                 h:Number = 0, 
                                 borderThickness:Number = 1,
                                 borderColor:Number = 0) {
      this.borderThickness = borderThickness;
      this.borderColor = borderColor;
	 
      buildViewer();
	  setPosition(x, y);
      setSize(w, h);
	 
	}

    public function loadImage (URL:String):void {
      imgLoader.load(new URLRequest(URL));
    }

    public function setPosition (x:Number, y:Number):void {
      this.x = x;
      this.y = y;
      // No need to redraw because setting x and y 
      // automatically causes a screen update.
    }

    public function setSize (w:Number, h:Number):void {
      this.w = w;
      this.h = h;
      draw();
    }

    private function buildViewer ():void {
      createLoader();
      createBorder();
      createStatusField();
    }
	  
    private function createLoader ():void {
      // Create the Loader instance and make it a child of this object.
      imgLoader = new Loader();
      addChild(imgLoader);
      
      // Register for events from imgLoader
      imgLoader.contentLoaderInfo.addEventListener(Event.OPEN, loadOpenListener);
      imgLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, 
                                            loadProgressListener);
      imgLoader.contentLoaderInfo.addEventListener(Event.INIT, loadInitListener);
      imgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, 
                                            loadIOErrorListener);
    }

    private function createBorder ():void {
      // Create the Loader instance and make it a child of this object.
      border = new Shape();
      addChild(border);
    }

    private function createStatusField ():void {
	  var format:TextFormat = new TextFormat();
          format.font = "Arial";
          format.color = 0xCCCCCC;
          format.size = 10;
	
		
      loadStatus_txt = new TextField();
      loadStatus_txt.background = false;
      loadStatus_txt.border = false;
	  loadStatus_txt.defaultTextFormat = format;
      loadStatus_txt.autoSize = TextFieldAutoSize.LEFT;
	  loadStatus_txt.selectable = false;
	  //loadStatus_txt.background = true;
      //loadStatus_txt.x = w;
      //loadStatus_txt.x = w;
      //loadStatus_txt.y = h;
	  
	  _loadMotion = new Sprite();
	  _loadMotion.graphics.beginFill(0x125987, .5);
	  _loadMotion.graphics.drawCircle(0, 0, 20);
	  _loadMotion.graphics.endFill();
	 
	  _loadMotion.buttonMode = true;
      // loadStatus_txt is not added to the display list until loading
      // starts. See loadOpenListener().
    }

    private function draw ():void {
      // Only clip image and draw border if 
      // a width and height have been specified.
      if (w > 0 && h > 0) {
        // Size and position the loader.
        imgLoader.scrollRect = new Rectangle(0, 
                                             0, 
                                             w-borderThickness*2, 
                                             h-borderThickness*2);
        imgLoader.x = imgLoader.y = borderThickness;
      
        // Draw the border.
		
		/*
        var g:Graphics = border.graphics;
        g.clear();
        g.lineStyle(borderThickness, borderColor);
        g.moveTo(borderThickness/2, borderThickness/2);
        g.lineTo(w-borderThickness, borderThickness/2);
        g.lineTo(w-borderThickness, h-borderThickness);
        g.lineTo(borderThickness/2, h-borderThickness);
        g.lineTo(borderThickness/2, borderThickness/2);
		*/
      }
    }

// ===================== LoaderInfo EVENTS ========================

    private function loadOpenListener (e:Event):void {
      // It's not actually necessary to check if the object is already
      // on the display list (with contains()), but we do it here as a 
      // matter of good form and just in case ActionScript 3.0 adds an 
      // error in future.
      if (!contains(loadStatus_txt)) {
		addChild(_loadMotion);
		
		_loadMotion.x = (w - _loadMotion.width) / 2 + _loadMotion.width/2;
		_loadMotion.y = (h - _loadMotion.height) / 2 + _loadMotion.height/2;
		
        addChild(loadStatus_txt);
		
      }
      loadStatus_txt.text = "LOADING";
    }
    
    private function loadProgressListener (e:ProgressEvent):void {
	  /*
	  var str:String = "LOADING: " 
        + Math.floor(e.bytesLoaded / 1024)
        + "/" + Math.floor(e.bytesTotal / 1024) + " KB";
	  */
	  var percent:int = 100 - Math.floor(((e.bytesTotal - e.bytesLoaded) / e.bytesTotal) * 100) ;
	  loadStatus_txt.text = percent + "%";
	  
	  loadStatus_txt.x = (w - loadStatus_txt.width) / 2;
	  loadStatus_txt.y = (h - loadStatus_txt.height) / 2;
	 
      
    }
    
    private function loadInitListener (e:Event):void {
	  imgLoader.content.width = w;
	  imgLoader.content.height = h;
	  imgLoader.content.cacheAsBitmap = true;
      removeChild(loadStatus_txt);
	  removeChild(_loadMotion);
    }
    
    // could also check for http status
    // ## [http status might not be supported in netscape...]
    private function loadIOErrorListener (e:IOErrorEvent):void {
      if (!contains(loadStatus_txt)) {
        addChild(loadStatus_txt);
      }
      // Tell the user the image didn't load.
      loadStatus_txt.text = "Error" 
    }
  }
}










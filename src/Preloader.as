package 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.text.Font;
	import flash.utils.getDefinitionByName;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	
	[SWF(width = "600", height = "400")]
	
	public class Preloader extends MovieClip 
	{
		private var square:Sprite = new Sprite();
		private var border:Sprite = new Sprite();
		private var size:Number = 256;
		private var text:TextField = new TextField();

		private var txtColor:uint = 0xFFFFFF;
		private var loaderColor:uint = 0xD8D8D8;
		
		public function Preloader() 
		{
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			// show loader
			addChild(square);
			square.x = (stage.stageWidth / 2) -((size-8)/2);
			square.y = stage.stageHeight / 2;
			
			addChild(border);
			border.x = (stage.stageWidth / 2) - (size/2);
			border.y = stage.stageHeight / 2 - 4;
		
			addChild(text);
			text.x = (stage.stageWidth / 2) - (size/2);
			text.y = stage.stageHeight / 2 - 30;
	
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// update loader
			square.graphics.beginFill(loaderColor);
			square.graphics.drawRect(0,0,(loaderInfo.bytesLoaded / loaderInfo.bytesTotal) * (size-8),20);
			square.graphics.endFill();
			
			border.graphics.lineStyle(2, loaderColor);
			border.graphics.drawRect(0, 0, size, 28);
			
			text.textColor = txtColor;
			text.text = "Loading: " + Math.ceil((loaderInfo.bytesLoaded/loaderInfo.bytesTotal)*100) + "%";
			
		}
		
		private function checkFrame(e:Event):void 
		{
			//if we're done, run the startup function, remove event listener
			if (currentFrame == totalFrames) 
			{
				removeEventListener(Event.ENTER_FRAME, checkFrame);
				loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
				startup();
			}
		}
		
		private function startup():void 
		{
			// hide loader
			stop();
			
			//remove all the children
			var i:int = numChildren;
			while (i --) removeChildAt(i)
			
			//go to the main class
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass as DisplayObject);
		}
		
	}
	
}
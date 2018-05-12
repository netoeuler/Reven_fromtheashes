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
	//import punk.core.*;
	
	[SWF(width = "640", height = "480")]
	
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Preloader extends MovieClip 
	{		
		private var square:Sprite = new Sprite();
		private var border:Sprite = new Sprite();
		private var wd:Number = (loaderInfo.bytesLoaded / loaderInfo.bytesTotal) * 240;
		private var text:TextField = new TextField();
		private var textPressSpace:TextField = new TextField();
		private var percent:int;
		
		public function Preloader() 
		{
			[SWF(width = "640", height = "480")]
			
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			
			// show loader
			addChild(square);
			square.x = 200;
			square.y = stage.stageHeight / 2;
			
			addChild(border);
			border.x = 200-4;
			border.y = stage.stageHeight / 2 - 4;
		
			addChild(text);
			text.x = 300; //194
			text.y = stage.stageHeight / 2;
			
			// render background
			graphics.beginFill(0x000000, 1);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
		}
		
		private function progress(e:ProgressEvent):void 
		{
			percent = e.bytesLoaded/e.bytesTotal*100;
			
			// update loader
			square.graphics.beginFill(0x0000FF);
			square.graphics.drawRect(0,0,(e.bytesLoaded / e.bytesTotal) * 240,20);
			square.graphics.endFill();
			
			border.graphics.lineStyle(2,0xFFFFFF);
			border.graphics.drawRect(0, 0, 248, 28);
			
			text.textColor = 0xFFFFFF;
			text.text = int(percent) + "%";			
		}		
		
		private function checkFrame(e:Event):void 
		{			
			if (percent == 100)
			{
				removeEventListener(Event.ENTER_FRAME, checkFrame);
				startup();				
			}
		}
		
		private function startup():void 
		{
			// hide loader
			stop();
			var mainClass:Class = getDefinitionByName("Main") as Class;
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);			
			parent.addChild(new mainClass as DisplayObject);
		}
		
	}
	
}
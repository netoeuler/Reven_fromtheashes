package{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import player.*;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.events.Event;
	import splash.*;

	public class Main extends Engine
	{
		public var _player:Player = new Player("player",null);
		public static var pause:Boolean = false;
		public static var arrayOfLevelCompleted:Array = new Array();
		public static var stairwaySummoned:Boolean = false;
		
		public static var lifeMax:int;
		public static var livesNum:int;
		
		public function Main(){
			super(640, 480, 60, false);				
			
			arrayOfLevelCompleted.push("floresta");
			arrayOfLevelCompleted.push("caverna");
			arrayOfLevelCompleted.push("vila_abandonada");			
		}
		
		override public function init():void 
		{
			var s:Splash = new Splash;
			FP.world.add(s);
			s.start(splashComplete);
		}		
		
		public function splashComplete():void
		{
			// This function is called when the splash screen finishes.
			
			FP.console.enable();			
			FP.volume = 0;
			FP.world = new Map("volcano2", _player, true); 
			//FP.world = new Menu();
		}		
	}	
}
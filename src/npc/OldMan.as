package npc
{	
	import anim.BlackScreen;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class OldMan extends Entity
	{		
		[Embed(source = '../gfx/old_man.png')] private const OLDMAN:Class;		
		
		public var spr:Image = new Image(OLDMAN);
		public var entityText:Entity = null;
		public var blackScreen:BlackScreen = null;
		public var map:Map;

		public function OldMan(_map:Map):void
		{
			map = _map;
			
			this.x = 400;
			this.y = 350;
			graphic = spr;
		}		
		
		public function getDialog():Entity {
			var str:String;
			
			switch(Main.arrayOfLevelCompleted.length) {
				case 0:
					str = 	"Go ahead and get the 3 pendants to enter in the volcano. \n" +
							"If you hurt come to me. I can restore your life. \n\n" +
							"You have a hard quest to do, but we trust you.";
					break;
				case 1:
					str = 	"Yeah! You get your first pendant! \n" +
							"Two more less...";
					break;
				case 2:
					str =	"Just more one pendant for you can enter in the volcano \n" +
							"and encare face to face the demon who causes the terror \n" +
							"in the island.";
					break;
				case 3:
					str =	"Gotcha! Now you can enter on the volcano to defeat \n" +
							"the final boss. Go and do it!"
					break;
			}
			
			var text:Text = new Text(str, 100, 100);			
			
			entityText = new Entity();
			entityText.graphic = text;
			map.dialogueBoxActive = true;
			
			printBlackScreen();			
			return entityText;
		}
		
		public function printBlackScreen():void {
			blackScreen = new BlackScreen();
			blackScreen.active = false;
			blackScreen.x = 100;
			blackScreen.y = 100;
			blackScreen.spr.scaleX = 8;
			blackScreen.spr.scaleY = 1.3;
			FP.world.add(blackScreen);
		}
		
		public function remove():void {
			FP.world.remove(entityText);
			FP.world.remove(blackScreen);
			entityText = null;
		}
		
	}//end of class
}//end of package
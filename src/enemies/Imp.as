package enemies
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Imp extends Enemy
	{		
		[Embed(source = '../gfx/enemies/imp.png')] private const IMP:Class;		

		public function Imp(playerAux)
		{
			type = "enemy";
			
			player = playerAux;
			scoreUp = 5;
			life = 3;
			
			spr = new Spritemap(IMP, 45, 55);
			
			spr.add("walk", [0,1], 2, true);
			
			init();
		}	
		
	}//end of class
}//end of package
package enemies
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Zombie extends Enemy
	{		
		[Embed(source = '../gfx/enemies/zombie.png')] private const ZOMBIE:Class;		

		public function Zombie(playerAux)
		{
			type = "enemy";
			
			player = playerAux;
			scoreUp = 5;
			life = 3;
			
			spr = new Spritemap(ZOMBIE, 45, 55);
			
			spr.add("walk", [0,1,2,3], 2, true);
			
			init();
		}	
		
	}//end of class
}//end of package
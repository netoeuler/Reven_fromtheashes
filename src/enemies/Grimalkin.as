package enemies
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Grimalkin extends Enemy
	{		
		[Embed(source = '../gfx/enemies/grimalkin.png')] private const GRIMALKIN:Class;	

		public function Grimalkin(playerAux)
		{
			type = "enemy";
			
			player = playerAux;
			scoreUp = 5;
			life = 3;
			
			spr = new Spritemap(GRIMALKIN, 45, 55);
			
			spr.add("walk", [0,1], 2, true);			
			
			init();
		}
		
	}//end of class
}//end of package
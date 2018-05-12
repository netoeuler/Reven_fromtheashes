package enemies
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Grimalkin2 extends Enemy
	{		
		[Embed(source = '../gfx/enemies/grimalkin2.png')] private const GRIMALKIN2:Class;	

		public function Grimalkin2(playerAux)
		{
			type = "enemy";
			
			player = playerAux;
			scoreUp = 5;
			life = 3;
			
			spr = new Spritemap(GRIMALKIN2, 45, 55);
			
			spr.add("walk", [0,1], 2, true);			
			
			init();
		}
		
	}//end of class
}//end of package
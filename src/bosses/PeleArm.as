package bosses
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;
	import spells.*;

	public class PeleArm extends Boss
	{		
		[Embed(source = '../gfx/boss/boss_pele_arm.png')] private const PELE_ARM:Class;		
		
		//public var player;
		
		public var pele;
		public var zide:String;
		public var punchAttacking:Boolean = false;

		public function PeleArm(playerAux,_pele,_side:String)
		{
			nome = "PeleArm";
			
			zide = _side;
			pele = _pele;
			
			player = playerAux;
			scoreUp = 15;
			life = 1; //70
			
			spr = new Spritemap(PELE_ARM, 71, 186);
			spr.add("stand", [0], 2, false);
			graphic = spr;
			
			spr.play("stand");
			
			if (zide == "right"){
				subnome = "rightArm";
				spr.flipped = true;
			}
			else {
				subnome = "leftArm";
			}
		}
		
		override public function updateBoss():void
		{			
			if (zide == "left")
				this.x = pele.x - 40;			
			else 
				this.x = pele.x + pele.spr.width - 30;				
			
			this.y = pele.y + 120;
			
			if (zide == "right" && pele.rightPunchAttacking){
				spr.scale = 1.3;
				setHitbox(65, 200,-20,-20);
			}
			else if (zide == "left" && pele.leftPunchAttacking){
				spr.scale = 1.3;
				setHitbox(65, 200,0,-20);
			}
			else{
				spr.scale = 1;
				setHitbox(0, 0);
			}
		}		
		
	}//end of class
}//end of package
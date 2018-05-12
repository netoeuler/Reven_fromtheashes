package bosses
{
	import maps.volcano.Lava;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;
	import spells.*;

	public class Pele extends Boss
	{		
		[Embed(source = '../gfx/boss/boss_pele.png')] private const PELE:Class;
		
		public var rightArm:PeleArm
		public var leftArm:PeleArm;
		
		public var setAttack:int;
		
		public var countLimite:int = 200; //200
		public var countPunchAttack:int = 0;
		public var countLavaAttack:int = 0;
		public var countFollowerFlare:int = 0;
		public var countMaxFollowerFlare:int = 0;
		public var countPreAttack:int = 0;
		public var countToChangePele:int = 0;
		
		public var punchAttacking:Boolean = false;
		public var rightPunchAttacking:Boolean = false;
		public var leftPunchAttacking:Boolean = false;
		public var fireAttackBegins:Boolean = false;
		public var createLavaAttackBegins:Boolean = false;
		public var followerFlareAttackBegins:Boolean = false;
		
		public var lava:Lava = null;
		public var flare:Flare;

		public function Pele(playerAux)
		{			
			nome = "Pele";
			
			this.x = 200;
			this.y = 30;
			
			player = playerAux;
			scoreUp = 1000;
			life = 150; //30
			
			spr = new Spritemap(PELE, 180, 280);
			
			spr.add("stand", [0,1], 3, true);
			spr.add("attack", [2,3], 0.5 , false);			
			graphic = spr;			
			
			spr.play("stand");
			
			//setHitbox(50,100,-35,-40);
			
			//rightArm = peleArmsArray[0];
			//leftArm = peleArmsArray[1];
		}
		
		override public function updateBoss():void
		{			
			if (Map.rightArm == null && Map.leftArm == null) {
				if (countToChangePele < 100)
					countToChangePele++;
				else {
					if (lava != null){
						FP.world.remove(lava);
						lava = null;
					}
					
					killPele();
				}
			}
			else{
				if (!attack) {
					count++;
				}
				else{				
					if (setAttack == 0 && Map.rightArm != null)
						punchAttack("right")
					else if (setAttack == 1 && Map.leftArm != null)
						punchAttack("left");
					else 
						preAttack(setAttack);
				}
				
				if (count > countLimite && !attack)
				{				
					setAttack = Math.round(Math.random() * 3);
					if (setAttack == 2 && createLavaAttackBegins)
						setAttack = 0;
						
					attack = true;
				}
				
				if (lava != null) {
					if (countLavaAttack < 500)
						countLavaAttack++;
					else {
						createLavaAttackBegins = false;
						countLavaAttack = 0;
						FP.world.remove(lava);
						lava = null;					
					}
				}
			}			
		}
		
		/*
		public function generatePeleArms():void {
			
		}
		
		public function setArms(rightA, leftA):void {
			rightArm = rightA;
			leftArm = leftA;
		}*/
		
		public function preAttack(_setAttack:int):void {
			countPreAttack = 50;
			
			if (countPreAttack < 50) {
				if (countPreAttack % 2 == 0)
					spr.color = 0x0000FF;
				else
					spr.color = 0x00FF00;
					
				countPreAttack++;
			}
			else {				
				if (setAttack < 2){
					if (setAttack == 1 && Map.rightArm != null)
						setAttack = 0;
					else if (setAttack == 0 && Map.leftArm != null)
						setAttack = 1;
					else
						setAttack = Math.round(Math.random() * 1) + 2;
				}
				
				if (setAttack == 2)
					createLavaAttack();
				if (setAttack == 3)
					followerFlareAttack();
			}
		}
		
		public function punchAttack(_side:String):void {			
			if (spr.frame == 3) {
				//spr.play("stand");
				
				if (punchAttacking) {					
					if (countPunchAttack < 200)
						countPunchAttack++;
					else{						
						endAttack();						
					}
				}
				else {					
					if (_side == "right"){
						Map.rightArm.visible = true;
						rightPunchAttacking = true;
					}
					else{
						Map.leftArm.visible = true;
						leftPunchAttacking = true;
					}
					
					attackFire();
					
					punchAttacking = true;
				}				
			}
			else {
				spr.play("attack");
				if (_side == "right") {				
					spr.flipped = false;
					Map.rightArm.visible = false;
				}
				else {
					spr.flipped = true;
					Map.leftArm.visible = false;
				}				
			}			
		}
		
		public function attackFire():void {
			//spr.play("attack");
			
			if (!fireAttackBegins) {				
				fireAttackBegins = true;
				var dx:int;
				if (spr.flipped)
					dx = 170;
				else
					dx = 375;
				
				FP.world.add(new Fire(player, dx, 320, "right"));
				FP.world.add(new Fire(player, dx, 320, "left"));
				FP.world.add(new Fire(player, dx, 320, "right_down"));
				FP.world.add(new Fire(player, dx, 320, "left_down"));
				FP.world.add(new Fire(player, dx, 320, "down"));				
			}			
		}
		
		public function createLavaAttack():void {
			if (!createLavaAttackBegins){
				createLavaAttackBegins = true;
			
				var dX:int = Math.round(Math.random() * 9);
				var dY:int = Math.round(Math.random() * 3);
				lava = new Lava(player);
				lava.x = dX * 64;
				lava.y = 320 + (dY * 64);
				FP.world.add(lava);
				
				endAttack();
			}
		}
		
		public function followerFlareAttack():void {
			if (countMaxFollowerFlare < 7){
				if (countFollowerFlare < 120){
					countFollowerFlare++;
					
					if (countFollowerFlare == 100) {
						flare = new Flare(player);
						flare.x = player.x;
						flare.y = player.y - 20;
					}
				}
				else{
					countMaxFollowerFlare++;
					countFollowerFlare = 0;
					FP.world.add(flare);
				}
			}
			else
				endAttack();
		}
		
		public function endAttack():void {
			countPunchAttack = 0;
			countFollowerFlare = 0;
			countMaxFollowerFlare = 0;
			countPreAttack = 0;
			
			punchAttacking = false;
			rightPunchAttacking = false;
			leftPunchAttacking = false;
			fireAttackBegins = false;
			
			spr.play("stand");
			count = 0;
			attack = false;
		}
		
		
	}//end of class
}//end of package
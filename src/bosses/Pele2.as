package bosses
{
	import maps.volcano.Lava;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;
	import spells.*;

	public class Pele2 extends Boss
	{		
		[Embed(source = '../gfx/boss/boss_pele2.png')] private const PELE2:Class;
		
		public var rightArm:PeleArm
		public var leftArm:PeleArm;
		
		public var setAttack:int;
		
		public var countLimite:int = 200; //200		
		public var countLavaAttack:int = 0;
		public var countPreAttack:int = 0;
		public var countWalkAttack:int = 0;
		public var countThrowFireAttack:int = 0;
		
		public var createLavaAttackBegins:Boolean = false;
		public var walkAttackBegins:Boolean = false;
		public var throwFireAttackBegins:Boolean = false;
		
		public var shieldBeGenerated:Boolean = false;
		public var pele2Started:Boolean = false;
		
		public var lava:Lava = null;
		public var flare:Flare;
		
		public var fireShield:Array = new Array();

		public function Pele2(playerAux)
		{			
			nome = "Pele2";
			
			this.x = 660;
			this.y = 300;
			
			player = playerAux;
			scoreUp = 1000;
			life = 150; //30
			
			spr = new Spritemap(PELE2, 82, 112);
			
			spr.add("stand", [0,1,2], 3, false);
			spr.add("walk", [3,4,5], 5, true);
			graphic = spr;			
			
			spr.play("stand");
			
			setHitbox(82, 107);
			
			//init();			
			
			//rightArm = peleArmsArray[0];
			//leftArm = peleArmsArray[1];
		}
		
		override public function updateBoss():void
		{			
			if (!shieldBeGenerated) {
				generatePeleShield();
			}
			
			init();			
			
			if (!attack) {
				count++;
			}
			else {
				if (setAttack == 0 || setAttack == 1)
					walkAttack();
				else if (setAttack == 2){
					if (fireShield.length == 0){
						generatePeleShield();
						endAttack();
					}
					else
						throwFireAttack();
				}
				else if (setAttack == 3)
					createLavaAttack();				
				
			}
			
			if (count > countLimite && !attack)
			{				
				//setAttack = Math.round(Math.random() * 3);
				setAttack = 2;
					
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
			
			if (this.x < player.x)
				this.spr.flipped = true;
			else
				this.spr.flipped = false;
		}		
		
		public function generatePeleShield():void {
			fireShield.push(new Fire2(player, -20, 10, "default",this));
			fireShield.push(new Fire2(player, 50, 10, "default",this));
			fireShield.push(new Fire2(player, -20, 55, "default",this));
			fireShield.push(new Fire2(player, 50, 55, "default",this));
			
			FP.world.add(fireShield[0]);
			FP.world.add(fireShield[1]);
			FP.world.add(fireShield[2]);
			FP.world.add(fireShield[3]);
			
			shieldBeGenerated = true;
		}
		
		public function init():void {
			if (!pele2Started)
			{
				if (this.x < 550)
				{
					this.active = true;
					player.active = true;
					pele2Started = true;
					this.spr.play("stand");
				}
				else				
				{					
					player.active = false;
					this.spr.play("walk");
					this.x--;
				}
			}
			/*else {
				player.active = true;
			}*/
		}
		
		/*
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
				if (setAttack < 2)
					setAttack = Math.round(Math.random() * 1) + 2;
				
				if (setAttack == 2)
					createLavaAttack();
				if (setAttack == 3)
					followerFlareAttack();
			}
		}
		*/
		
		public function walkAttack():void {
			if (countWalkAttack < 200) {
				countWalkAttack++;
				
				spr.play("walk");
				moveTowards(player.x, player.y, 2);
			}
			else
				endAttack();
		}
		
		public function throwFireAttack():void {
			if (!throwFireAttackBegins) {
				if (!spr.flipped)
					fireShield[fireShield.length-1].side = "left";
				else
					fireShield[fireShield.length - 1].side = "right";
				
				var setDirY:int = Math.round(Math.random() * 1);
				if (setDirY == 0)
					fireShield[fireShield.length - 1].dirY = "down";
				else
					fireShield[fireShield.length - 1].dirY = "up";
				
				throwFireAttackBegins = true;
			}
			else {
				if (fireShield[fireShield.length - 1].endAttack){
					fireShield.pop();
					endAttack();
				}
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
		
		public function endAttack():void {			
			countPreAttack = 0;
			countWalkAttack = 0;
			
			throwFireAttackBegins = false;
			
			spr.play("stand");
			count = 0;
			attack = false;
		}
		
		
	}//end of class
}//end of package
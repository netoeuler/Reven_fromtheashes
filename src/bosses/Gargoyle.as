package bosses
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;
	import spells.*;

	public class Gargoyle extends Boss
	{		
		[Embed(source = '../gfx/boss/boss_gargoyle.png')] private const GARGOYLE:Class;
		
		public const DIR_UP:int = 0;
		public const DIR_DOWN:int = 1;
		
		public var countLimite = 200;
		public var countAttackRock:int = 0;
		public var countAttackRockMax:int = 30;
		public var numberOfAttackRock:int = 0;
		
		public var dirJump:String = "up";
		public var speedJump:int = 5;
		public var speedX = 1.5;		
		public var setAttack:int;
		public var countNumberOfAttacks:int = 0;
		public var isInTheGround:Boolean = false;
		
		public var wind:Wind = null;

		public function Gargoyle(playerAux)
		{			
			this.x = 450;
			this.y = 30;
			
			player = playerAux;
			scoreUp = 50;
			life = 150; //30
			
			spr = new Spritemap(GARGOYLE, 133, 158);
			
			spr.add("stand", [0,1,2,3,4], 8, true);
			spr.add("ground", [5, 6, 7, 8, 9], 8, false);
			spr.add("attack", [10,11,12,13,14], 8, false);
			graphic = spr;			
			
			spr.play("stand");
			
			setHitbox(50,100,-35,-40);
		}
		
		override public function updateBoss():void
		{			
			SetHitBox();
			
			if (life < 25)
				countLimite = 100;
			
			if (!attack)
				count++;
			else{					
				if (isInTheGround) {
					if (setAttack == 0 || setAttack == 1)
						upFromTheGround();
					else if (setAttack == 2)
						attackRock();
					else
						attackWind();
				}
				else {
					if (setAttack == 1)
						downToTheGround();	
					else
						walk();
				}
			}
				
			if (count > countLimite && !attack)
			{				
				var numberOfAttacks:int;
				if (isInTheGround)
					numberOfAttacks = 4;
				else
					numberOfAttacks = 1;
					
				setAttack = Math.round(Math.random()*numberOfAttacks);				
				attack = true;
			}
		}
		
		public function SetHitBox():void {
			if (spr.currentAnim == "stand") {
				if (spr.flipped)
					setHitbox(50,100,-25,-40);
				else
					setHitbox(50,100,-45,-40); //-35
			}
			else {
				if (spr.flipped)
					setHitbox(50,100,-25,-40);
				else
					setHitbox(50,100,-45,-40); //-35
				}
		}
		
		public function walk():void {
			if (!spr.flipped) {
				if (this.x > 30)
					this.x -= 5;
				else {
					spr.flipped = true;
					endAttackFunction();
				}
			}
			else {
				if (this.x < 450)
					this.x += 5;
				else {
					spr.flipped = false;
					endAttackFunction();
				}
			}
		}
		
		public function downToTheGround():void {
			if (this.y < 270)
				this.y += 2.5;
			else {
				isInTheGround = true;
				endAttackFunction();
			}
		}
		
		public function upFromTheGround():void {
			spr.play("stand");
			
			if (this.y > 30)
				this.y -= 2.5;
			else {
				isInTheGround = false;
				endAttackFunction();
			}
		}
		
		public function attackRock():void {
			shakeCamera();
			
			if (numberOfAttackRock < countAttackRockMax) {
				countAttackRock++;
			
				if (countAttackRock > 30) {
					FP.world.add(new Rock(player));
					countAttackRock = 0;
					numberOfAttackRock++;
				}
			}
			else {
				numberOfAttackRock = 0;
				endAttackFunction();
			}
		}
		
		public function attackWind():void {
			spr.play("attack");
			
			if (wind == null) {				
				wind = new Wind(player, this.x);
				FP.world.add(wind);
			}
			else {
				if (wind.endAttack) {
					FP.world.remove(wind);
					wind = null;
					endAttackFunction();
				}
			}
		}
		
		public function shakeCamera():void {
			if (countAttackRock % 2 == 0)
				FP.camera.x = -5;
			else
				FP.camera.x = 5;
		}
		
		public function endAttackFunction():void{			
			FP.camera.x = 0;
			count = 0;
			attack = false;
			if (isInTheGround)
				spr.play("ground");
			else
				spr.play("stand");		
		}
		
	}//end of class
}//end of package
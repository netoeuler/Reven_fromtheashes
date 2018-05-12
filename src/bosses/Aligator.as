package bosses
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;
	import spells.*;

	public class Aligator extends Boss
	{		
		[Embed(source = '../gfx/boss/boss_aligator.png')] private const ALIGATOR:Class;		
		
		public var countLimite:int = 200;
		
		public var speedX = 1.5;		
		public var setAttack:int;
		public var countSubmerse:int = 0;
		public var dirToMove:String = "default";
		public var dirToMoveToReturn:String = "default";
		public var originXHitBox:int = -10;
		public var forceAttackEnd:Boolean = false;

		public function Aligator(playerAux)
		{			
			this.x = 500;
			this.y = 300;
			
			player = playerAux;
			scoreUp = 50;
			life = 150; //150
			
			spr = new Spritemap(ALIGATOR, 150, 135);
			
			spr.add("stand", [0, 1, 2], 4, true);
			spr.add("punch", [3, 4, 5], 7, false);
			spr.add("submerse", [6, 7, 8], 2, true);
			graphic = spr;
			
			if (side == RIGHT) spr.flipped = true;
			
			spr.play("stand");			
		}
		
		override public function updateBoss():void
		{			
			if (this.x < player.x) {
				originXHitBox = -40;
				spr.flipped = true;
			}
			else {
				originXHitBox = -10;
				spr.flipped = false;
			}			
			
			if (life < 25)
				countLimite = 100;
			
			if (!attack) {				
				count++;
				setHitbox(90, 80, originXHitBox, 0);
			}
			else{
				if (setAttack == 0)
					punchFunction();
				else if (setAttack == 1)
					forceAttackFunction();
				else
					submerseFunction();
			}
				
			if (count > countLimite && !attack)
			{
				var numberOfAttacks:int;				
				numberOfAttacks = 4;				
				
				setAttack = Math.round(Math.random()*numberOfAttacks);
				//setAttack = 1;
				attack = true;
			}	
		}
		
		public function punchFunction():void {
			if (spr.flipped)
				setHitbox(90,80,-80,0); //20
			else
				setHitbox(90,80,40,0); //20
			
			if (spr.currentAnim != "punch")
				spr.play("punch");		
			
			if (spr.index == 2) {				
				endAttackFunction();
			}
		}
		
		public function submerseFunction():void {
			setHitbox(70, 60, originXHitBox, 0);
			
			if (spr.currentAnim != "submerse")
				spr.play("submerse");
			
			if (countSubmerse < 300)
				countSubmerse++;
			else {
				countSubmerse = 0;
				endAttackFunction();
			}
			
			if (dirToMove != "default")
				moveTowardsAdapted(dirToMove, 2.5, 0.2); 
			else {
				if (this.x > player.x)
					dirToMove = "left";
				else
					dirToMove = "right";				
			}
		}
		
		public function forceAttackFunction():void {
			setHitbox(70, 60, originXHitBox, 0);
			
			if (spr.currentAnim != "submerse") {				
				spr.play("submerse");
			}
			
			if (dirToMove != "default") {				
				moveTowardsAdaptedToForceAttack(dirToMove, 5);
			}
			else {
				if (forceAttackEnd) {
					endAttackToForceAttackFunction();
				}
				else {
					if (this.x > player.x) // - 100
						dirToMove = "left";
					else
						dirToMove = "right";
				}				
			}
			
		}
		
		public function moveTowardsAdapted(dir:String, amountX:Number, amountY:Number):void {
			if (dir == "left") {
				if (this.x > 30)
					this.x -= amountX;
				else {					
					dirToMove = "default";
				}
			}
			else {
				if (this.x < 500) //400
					this.x += amountX;
				else {					
					dirToMove = "default";					
				}
			}
			
			if (this.y < player.y) 				
				this.y += amountY;			
			else
				this.y -= amountY;
		}
		
		public function moveTowardsAdaptedToForceAttack(dir:String, amountX:Number):void {
			if (dir == "left") {
				if (this.x > -200)
					this.x -= amountX;
				else {
					dirToMoveToReturn = dirToMove;
					dirToMove = "default";					
					forceAttackEnd = true;
				}
			}
			else if (dir == "right") {
				if (this.x < 660)
					this.x += amountX;
				else {
					dirToMoveToReturn = dirToMove;
					dirToMove = "default";
					forceAttackEnd = true;
				}
			}			
		}
		
		public function endAttackToForceAttackFunction():void {
			if (dirToMoveToReturn == "left") {
				if (this.x < -10)
					this.x += 5;
				else {
					dirToMoveToReturn = "default";
					endAttackFunction();
				}
			}			
			else if (dirToMoveToReturn == "right") {
				if (this.x > 520)
					this.x -= 5;
				else {
					dirToMoveToReturn = "default";
					endAttackFunction();
				}
			}			
		}
		
		public function endAttackFunction():void {
			setHitbox(90, 80, -10, 0);
			forceAttackEnd = false;
			count = 0;
			spr.play("stand");
			attack = false;
		}
		
	}//end of class
}//end of package
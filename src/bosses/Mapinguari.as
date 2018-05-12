package bosses
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;
	import spells.*;

	public class Mapinguari extends Boss
	{		
		[Embed(source = '../gfx/boss/boss_mapinguari.png')] private const MAPINGUARI:Class;
		
		public const DIR_UP:int = 0;
		public const DIR_DOWN:int = 1;
		
		public var countLimite:int = 200;
		
		public var dirJump:String = "up";
		public var speedJump:int = 5;
		public var speedX = 1.5;		
		public var setAttack:int;
		public var countNumberOfAttacks:int = 0;

		public function Mapinguari(playerAux)
		{			
			this.x = 500;
			this.y = 300;
			
			player = playerAux;
			scoreUp = 50;
			life = 150; //150
			
			spr = new Spritemap(MAPINGUARI, 106, 160); //106,160
			
			spr.add("stand", [0,1,2], 2, true);
			spr.add("jump", [3,4,5], 2, false);
			graphic = spr;
			
			if (side == RIGHT) spr.flipped = true;
			
			spr.play("stand");
			
			setHitbox(80,100,-10,-40); //106
		}
		
		override public function updateBoss():void
		{			
			if (life < 25)
				countLimite = 100;
			
			if (!attack)
				count++;
			else{					
				if (life > 20)
				{
					if (setAttack == 0)
						shotRajada(1);
					else
						jump();
				}
				else
				{
					if (setAttack == 0)
						shotRajada(2);
					else
						jump();
				}
				
			}
				
			if (count > countLimite && !attack)
			{
				var numberOfAttacks:int;
				if (life > 10)
					numberOfAttacks = 2;
				else
					numberOfAttacks = 1;
					
				setAttack = Math.round(Math.random()*numberOfAttacks);	
				attack = true;				
				spr.play("jump");
			}
		}			
		
		public function shotRajada(level:int):void
		{
			if (dirJump == "up")
			{
				spr.play("jump");
				if (this.y < 150)
					dirJump = "down";
				else
					this.y -= speedJump;
			}
			else if (dirJump == "down")
			{
				if (this.y > 300)
				{
					FP.world.add(new Rajada(player,this.x,player.y,spr.flipped));
					spr.play("stand");
					
					if (level == 2)
					{
						if (countNumberOfAttacks > 2)
							dirJump = "default";
						else{
							dirJump = "up";
							countNumberOfAttacks++;
						}
					}
					else					
						dirJump = "default";
				}
				else
					this.y += speedJump;
			}
			else
			{
				if (level == 2)
					countNumberOfAttacks = 0;
				
				endAttackFunction();
			}			
		}		
		
		public function jump():void
		{
			if (dirJump == "up")
			{
				walk();
				spr.play("jump");
				if (this.y < 150)
					dirJump = "down";
				else
					this.y -= speedJump;
			}
			else if (dirJump == "down")
			{
				walk();
				if (this.y > 300)
				{
					spr.play("stand");
					dirJump = "up";
				}
				else
					this.y += speedJump;
			}
			else
			{
				if (endAttack())
				{
					endAttackFunction();
				}
				else
				{
					if (this.y < 300)
						this.y += speedJump;
				}
			}
		}
		
		public function endAttackFunction():void
		{
			if (endAttack())
			{
				this.y = 299;
				count = 0;
				attack = false;
				dirJump = "up";
				spr.play("stand");
			}
			else
			{
				if (this.y < 300)
					this.y += speedJump;
			}
		}
		
		public function walk():void
		{
			if (side == LEFT)
			{				
				if (this.x < 20)
				{
					side = RIGHT;
					spr.flipped = true;	
					dirJump = "default";
				}
				else
					this.x -= speedX;
			}
			else if (side == RIGHT)
			{				
				if (this.x > 500)
				{
					side = LEFT;
					spr.flipped = false;
					dirJump = "default";
				}
				else
					this.x += speedX;
			}			
		}
		
		public function endAttack():Boolean
		{
			if (this.y >= 300)
				return true;
			
			return false;			
		}		
		
	}//end of class
}//end of package
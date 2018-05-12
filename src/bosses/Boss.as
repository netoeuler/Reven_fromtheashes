package bosses{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import anim.*;

	public class Boss extends Entity
	{
		[Embed(source = '../snd/enemyHit.mp3')] private const SFX_HIT:Class;
		[Embed(source = '../snd/enemyKill.mp3')] private const SFX_KILL:Class;
		
		public const LEFT:int=0;
		public const RIGHT:int=1;
		
		public const KNOCK:int = 5;
		
		public var sfxHit:Sfx = new Sfx(SFX_HIT);
		public var sfxKill:Sfx = new Sfx(SFX_KILL);

		public var spr:Spritemap;
		public var speed:int = 1;
		public var player;
		public var scoreUp:int;
		public var life:int;
		public var iniX:int;
		public var sideToAppear:int;
		public var side:int;
		public var protectedToAttack:Boolean = false;
		public var count:int = 0;
		public var attack:Boolean = false;
		public var dead:Boolean = false;
		public var bossFinished:Boolean = false;
		
		public var countExplode:int = 0;
		public var countGeneralExplode:int = 0;
		
		public var countEnemy:int = 0;
		
		public var peleArmsArray:Array = new Array();
		public var nome:String;
		public var subnome:String;
		
		public var callPele2:Boolean = false;

		public function Boss()
		{
			type = "boss"
			
			sfxHit.volume = 0.3;
			sfxKill.volume = 0.3;
		}

		override public function update():void 
		{			
			if (dead){
				if (this.nome != "PeleArm")
					kill();
				else
					killPeleArm();
			}
			else
				updateBoss();
			
			if (protectedToAttack)
			{
				countEnemy++;
				spr.color=0xFFAA00;
			}
			else
				spr.color=0xFFFFFF;
				
			if (countEnemy > 20)
			{
				protectedToAttack = false;
				countEnemy = 0;				
			}			

			if (collide("player",x,y) && !dead) {
				if ( player.attack && !protectedToAttack ) {
					if (life > 0)
					{
						sfxHit.play();
						protectedToAttack = true;
						life--;
					}
					else
					{
						dead = true;
						player.score.updateScore(scoreUp);
						this.y -= 50;
						//spr.angle = 90;
						sfxKill.play();
					}
				}
				else
				{
					if (!player.isBlink() && !protectedToAttack && !player.isDead())
						player.receivedDamage();			
				}
			}

			super.update();
		}
		
		public function kill():void
		{
			if (this.y < 300) //450
				this.y += 10;
			else
			{
				this.y = 450;
				if (countGeneralExplode < 30)
					countExplode++;
				else
					bossFinished = true;

				if (countExplode > 10)
				{
					generateExplode();
					countExplode = 0;
					countGeneralExplode++
				}
			}
		}
		
		public function killPeleArm():void {
			sfxKill.play();
			generateExplode();
			player.score.updateScore(scoreUp);
			destroy();
			
			if (subnome == "rightArm")
				Map.rightArm = null;
			else	
				Map.leftArm = null;
			
			//bossFinished = true;
		}
		
		public function killPele():void
		{
			if (this.y < 300) //450
				this.y += 10;
			else
			{
				this.y = 450;
				if (countGeneralExplode < 30)
					countExplode++;
				else
					callPele2 = true;

				if (countExplode > 10)
				{
					generateExplode();
					countExplode = 0;
					countGeneralExplode++
				}
			}
		}
		
		public function generateExplode():void
		{			
			graphic = null;
			
			explode(this.x + 90,this.y - 140);
			explode(this.x + 20,this.y - 100);
			explode(this.x + 70,this.y - 60);
			explode(this.x + 70,this.y - 100);
			explode(this.x + 10,this.y - 50);
			explode(this.x + 40,this.y - 150);
			explode(this.x + 5,this.y - 130);
			explode(this.x    ,this.y - 100);
			explode(this.x + 110,this.y - 100);
		}	
		
		public function kill2():void
		{
			sfxKill.play();
			explode(this.x,this.y);
			player.score.updateScore(scoreUp);
			destroy();
		}

		public function destroy():void {
			Map.currentEnemiesInTheStage--;
			FP.world.remove(this);
		}

		public function explode(_x:int,_y:int):void {
			var explod:Explosion = new Explosion();
			explod.x = _x;
			explod.y = _y;
			FP.world.add(explod);
		}

		public function receivedAttack():void {
			if (player.x < this.x)
			{
				if (this.x < 620)
					this.x += KNOCK;
			}
			else
			{
				if (this.x > 20)
					this.x -= KNOCK;
			}
			life--;
		}
		
		public function updateBoss():void
		{
		}

	}//end of class
}//end of package
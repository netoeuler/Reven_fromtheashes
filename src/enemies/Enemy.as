package enemies{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import anim.*;
	import itens.*;

	public class Enemy extends Entity
	{
		[Embed(source = '../snd/enemyHit.mp3')] private const SFX_HIT:Class;
		[Embed(source = '../snd/enemyKill.mp3')] private const SFX_KILL:Class;
		
		public const LEFT:int=0;
		public const RIGHT:int=1;
		
		public const KNOCK:int = 20;
		
		public var sfxHit:Sfx = new Sfx(SFX_HIT);
		public var sfxKill:Sfx = new Sfx(SFX_KILL);
		
		public var itensToDrop:Array = new Array();

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
		
		public var countEnemy:int = 0;

		public function Enemy() 
		{
			type = "enemy";
			
			sideToAppear=Math.round(Math.random()*1);
			if (sideToAppear==0)
			{
				this.x = FP.camera.x+650;
				side = LEFT;
			} else {
				this.x = FP.camera.x;
				side = RIGHT;
			}
	
			this.y=Math.round(Math.random()*50)+350; //80
			
			sfxHit.volume = 0.3;
			sfxKill.volume = 0.3;
		}

		override public function update():void 
		{
			updateEnemy();
			
			if (protectedToAttack) 
				countEnemy++;
				
			if (countEnemy > 20)
			{
				protectedToAttack = false;
				countEnemy = 0;
			}

			if (collide("player",x,y) && !dead) {
				if (player.attack && !protectedToAttack) {
					if (life > 1)
					{
						sfxHit.play();
						protectedToAttack = true;
						receivedAttack();						
					}
					else
					{
						var dropItem:int = Math.round(Math.random()*2);
						if (dropItem == 0)
							FP.world.add(new Item_Life(player,this.x,this.y));
							
						kill();
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
		
		public function init():void{
			graphic = spr;
			spr.scale = 1.3;
			
			if (side == RIGHT){
				spr.flipped = true;
				setHitbox(35,45,-10,-10);
			}
			else{
				setHitbox(35,45,0,-10);
			}				
			
			spr.play("walk");
		}
		
		public function kill():void
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

		public function receivedAttack():void 
		{
			if (player.x < this.x)
				this.x += KNOCK;
			else
				this.x -= KNOCK;
				
			this.life--;
		}
		
		public function updateEnemy():void
		{
			if (side==LEFT) {
				if (this.x>FP.camera.x) {
					this.x -= this.speed;
				} else {
					destroy();
				}
			} else {
				if (this.x>FP.camera.x+650) {
					destroy();
				} else {
					this.x += this.speed;
				}
			}
		}
		
		public function generateItensToDrop():void
		{
		}

	}//end of class
}//end of package
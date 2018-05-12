package spells{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Fire2 extends Entity
	{
		[Embed(source = '../gfx/fire.png')] private const FIRE2:Class;
		
		public var spr:Spritemap = new Spritemap(FIRE2, 35, 35);
		public var count:int = 0;
		public var speed:int = 8;
		
		public var side:String;
		public var endAttack:Boolean = false;
		
		public var player;
		public var pele;
		
		public var amountX:int;
		public var amountY:int;
		public var dirY:String;
		public var isCounterAttack:Boolean = false;
	
		public function Fire2(dPlayer,dx,dy,dside,_pele):void
		{
			spr.add("fire", [0, 1], 5, true);
			graphic = spr;
			spr.scale = 1.3;

			player = dPlayer;
			side = dside;
			pele = _pele;
			
			amountX = dx;
			amountY = dy;			
			
			spr.play("fire");
			setHitbox(35,35);
		}
		
		override public function update():void {
			if (!endAttack)
				movement();
			
			if (collide("player", x, y) && !player.isDead()) {
				if (!player.isBlink())
					player.receivedDamage();
			}
			
			if (collide("boss", x, y) && !pele.protectedToAttack && isCounterAttack) {
				pele.sfxHit.play();
				pele.protectedToAttack = true;
				pele.life--;
			}
			
			super.update();
		}
		
		public function movement():void {
			if (side == "right"){
				this.x += speed;
				moveVert();
			}
			else if (side == "left"){
				this.x -= speed;
				moveVert();
			}
			else{				
				this.x = pele.x + amountX;
					
				this.y = pele.y + amountY;
			}			
			
			if (outOfRange() && side != "default") {
				if (isCounterAttack) {
					isCounterAttack = false;
					speed *= -1;
				}
				
				FP.world.remove(this);
				endAttack = true;
			}
			
			if (player.attack && !isCounterAttack) {
				isCounterAttack = true;
				speed *= -1;				
			}
			
		}
		
		public function moveVert():void {
			if (dirY == "down")
				this.y += 7;
			else
				this.y -= 7;
			
			if (this.y > 460 && dirY == "down")
				dirY = "up";
			else if (this.y < 320 && dirY == "up")
				dirY = "down";
		}
		
		public function outOfRange():Boolean {
			if (this.x < 0 || this.x > 640 || this.y > 480)
				return true;
			else
				return false;
		}
	}
}
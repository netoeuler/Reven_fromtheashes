package spells{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Fire extends Entity
	{
		[Embed(source = '../gfx/fire.png')] private const FIRE:Class;
		
		public var spr:Spritemap = new Spritemap(FIRE, 35, 35);
		public var count:int = 0;
		public var speed:int = 5;
		
		public var side:String;
		public var endAttack:Boolean = false;
		
		public var player;
		
		public var amountX:int;
		public var amountY:int;
	
		public function Fire(dPlayer,dx,dy,dside):void
		{
			spr.add("fire", [0, 1], 5, true);
			graphic = spr;
			spr.scale = 1.3;

			player = dPlayer;
			side = dside;			
			
			this.x = dx;
			this.y = dy;			
			
			spr.play("fire");
			setHitbox(35,35);
		}
		
		override public function update():void {
			if (!endAttack)
				movement();
			
			if (collide("player", x, y)) {
				if (!player.isBlink())
					player.receivedDamage();
			}
			
			super.update();
		}
		
		public function movement():void {
			if (side == "right")
				this.x += speed;
			else if (side == "left")
				this.x -= speed;
			else if (side == "right_down") {
				this.x += speed;
				this.y += 3;
			}
			else if (side == "left_down") {
				this.x -= speed;
				this.y -= 3;
			}
			else if (side == "down")
				this.y += 3;			
			
			if (outOfRange()) {
				FP.world.remove(this);
				endAttack = true;
			}
		}
		
		public function outOfRange():Boolean {
			if (this.x < 0 || this.x > 640 || this.y > 480)
				return true;
			else
				return false;
		}
	}
}
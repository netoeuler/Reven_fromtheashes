package spells{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Wind extends Entity
	{
		[Embed(source = '../gfx/wind.png')] private const WIND:Class;
		
		public var spr:Spritemap = new Spritemap(WIND, 80, 66);
		public var count:int = 0;
		
		public var destX:int;
		public var destY:int;
		public var side:String;
		public var endAttack:Boolean = false;
		
		public var player;
	
		public function Wind(dPlayer,dx):void
		{
			spr.add("wind", [0, 1, 2], 5, true);
			graphic = spr;
			spr.scale = 1.3;

			player = dPlayer;
			
			if (dx > player.x)
				side = "left";//destX = 0;
			else
				side = "right";//destX = 640;
			
			this.x = dx;
			this.y = player.y;
			
			spr.play("wind");
			setHitbox(80,66);
		}
		
		override public function update():void {
			if (side == "left") {
				if (this.x > 0)
					this.x -= 5;
				else
					endAttack = true;//FP.world.remove(this);
			}
			else {
				if (this.x < 640)
					this.x += 5;
				else
					endAttack = true; //FP.world.remove(this);			
			}			
			
			if (collide("player", x, y)) {
				if (!player.isBlink())
					player.receivedDamage();
			}
			
			super.update();
		}
	}
}
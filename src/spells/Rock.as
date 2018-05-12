package spells{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Rock extends Entity
	{
		[Embed(source = '../gfx/rock.png')] private const ROCK:Class;
		
		public var spr:Image = new Image(ROCK);
		public var count:int = 0;
		
		public var destX:int;
		public var destY:int;
		
		public var player;
	
		public function Rock(dPlayer):void
		{
			graphic = spr;

			player = dPlayer;
			this.x = Math.round(Math.random() * 550) + 20;
			destY = Math.round(Math.random() * 150) + 350;
			
			setHitbox(60,60,15);
		}
		
		override public function update():void {
			if (this.y < destY) {
				this.y += 8;			
				
				if (collide("player", x, y)) {
					if (!player.isBlink())
						player.receivedDamage();
				}
			}
			else {
				FP.world.remove(this);
			}
			
			super.update();
		}
	}
}
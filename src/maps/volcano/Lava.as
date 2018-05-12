package maps.volcano
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;	
	import net.flashpunk.utils.*;	

	public class Lava extends Entity{		
		[Embed(source = 'tile_lava.png')] private const LAVA:Class;
		
		public var spr:Spritemap = new Spritemap(LAVA, 32, 32);	
		public var player;
		
		public function Lava(dPlayer):void
		{			
			player = dPlayer;
			spr.scale = 2;
			
			spr.add("lava", [0,1], 2, true);			
			
			graphic = spr;
			spr.play("lava");
			
			setHitbox(60, 60);
		}
		
		override public function update():void {
			if (collide("player", x, y)) {
				if (!player.isBlink())
					player.receivedDamage();
			}
			
			super.update();
		}
	}
}
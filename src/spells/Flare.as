package spells{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Flare extends Entity
	{
		[Embed(source = '../gfx/flare.png')] private const FLARE:Class;
		
		public var spr:Spritemap = new Spritemap(FLARE, 52, 88);
		public var count:int = 0;
		public var speed:int = 5;
		
		public var side:String;
		public var endAttack:Boolean = false;
		
		public var player;
	
		public function Flare(dPlayer):void
		{
			spr.add("flare", [0, 1,2,3], 8, true);
			graphic = spr;
			//spr.scale = 1.3;

			player = dPlayer;
			//side = dside;			
			
			//this.x = player.x;
			//this.y = player.y - 20;
			
			spr.play("flare");
			setHitbox(52,89);
		}
		
		override public function update():void {			
			if (count % 2 == 0)
				spr.visible = true;
			else
				spr.visible = false;
			
			if (count < 150)
				count++;
			else
				FP.world.remove(this);
				
			if (collide("player", x, y) && !player.isDead()) {
				if (!player.isBlink())
					player.receivedDamage();
			}
			
			super.update();
		}		
	}
}
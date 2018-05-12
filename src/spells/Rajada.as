package spells{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Rajada extends Entity
	{
		[Embed(source = '../gfx/rajada.png')] private const RAJADA:Class;
		
		public var spr:Image = new Image(RAJADA);
		public var speed = 7;
		public var count:int = 0;
		
		public var destX:int;
		public var destY:int;
		
		public var player;
		public var side;
	
		public function Rajada(dPlayer,dX, dY, dSide):void
		{
			graphic = spr;
			spr.flipped = dSide;		

			player = dPlayer;
			side = dSide;
			
			if (side)
				this.x = dX + 20;
			else
				this.x = dX - 20;
				
			this.y = dY;
			
			setHitbox(140,37);
		}
		
		override public function update():void{
			if (side)
			{				
				if (this.x < 0)
					FP.world.remove(this);
				else
					this.x += speed;
			}
			else
			{
				if (this.x > 640)
					FP.world.remove(this);
				else
					this.x -= speed;
			}
			
			if(collide("player",x,y))
			{
				if (!player.isBlink())
						player.receivedDamage();
			}
			
			super.update();
		}
	}
}
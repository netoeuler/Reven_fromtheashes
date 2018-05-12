package anim
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Explosion extends Entity
	{
		[Embed(source = '../gfx/explosion.png')] private const EXPLOD:Class;
		
		public var spr:Spritemap = new Spritemap(EXPLOD,82,83);
		
		public function Explosion():void
		{
			spr.add("explode", [0, 1, 2, 3], 15, true);
			graphic = spr;
			
			spr.play("explode");
		}
		
		override public function update():void
		{
			if (spr.index == 3) FP.world.remove(this);
			
			super.update();
		}
	}
}
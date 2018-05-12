package maps.mapa
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;
	import flash.geom.Point;
	import net.flashpunk.utils.*;
	import player.*;
	import anim.*;

	public class Water extends Entity{		
		[Embed(source = 'tile_water.png')] private const WATER:Class;
		
		public var spr:Spritemap = new Spritemap(WATER, 32, 32);		
		
		public function Water(w:int,h:int):void
		{			
			spr.add("water", [0,1], 2, true);
			
			this.x = w;
			this.y = h;
			
			graphic = spr;
			spr.play("water");
		}
	}
}
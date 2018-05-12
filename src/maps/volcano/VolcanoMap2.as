package maps.volcano
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.Grid;

	public class VolcanoMap2 extends Entity
	{
		public var tilemap:Tilemap;
		public var grid:Grid;		
		
		public var dimW:int = 64;
		public var dimH:int = 64;
		
		public function VolcanoMap2(map:XML):void
		{
			type = "level";

			tilemap = new Tilemap(Assets.TILES_VOLCANO,map.width,map.height,dimW,dimH);
			
			graphic = tilemap;
			
			grid = new Grid(map.width,320,dimW,dimH,0,0);
			//grid = new Grid(map.width, 256, dimW, dimH, 0, 0);			
			mask = grid;
			
			//grid.setRect(320, 320, 64, 64, true);			
		}		

	}
}
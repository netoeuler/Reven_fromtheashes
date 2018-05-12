package maps.caverna
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.Grid;

	public class CavernaMap extends Entity
	{
		public var tilemap:Tilemap;
		public var grid:Grid;
		
		public var dimW:int = 64;
		public var dimH:int = 64;
		
		public function CavernaMap(map:XML):void
		{
			type = "level";

			tilemap = new Tilemap(Assets.TILES_CAVERNA,map.width,map.height,dimW,dimH);			
			
			graphic = tilemap;
			
			grid = new Grid(map.width,320,dimW,dimH,0,0); //3840
			mask = grid;
		}	

	}
}
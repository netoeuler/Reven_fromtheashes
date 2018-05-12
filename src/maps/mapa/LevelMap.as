package maps.mapa
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.Grid;

	public class LevelMap extends Entity
	{
		public var tilemap:Tilemap;
		public var grid:Grid;
		
		public var dimW:int = 32;
		public var dimH:int = 32;		
		
		public function LevelMap(map:XML):void
		{
			type = "level";

			tilemap = new Tilemap(Assets.TILES_MAP,map.width,map.height,dimW,dimH);
			
			graphic = tilemap;
			
			grid = new Grid(map.width,320,dimW,dimH,0,0);
			mask = grid;
		}

	}
}
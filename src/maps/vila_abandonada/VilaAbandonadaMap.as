package maps.vila_abandonada
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.Grid;

	public class VilaAbandonadaMap extends Entity
	{
		public var tilemap:Tilemap;
		public var grid:Grid;
		
		public var dimW:int = 64;
		public var dimH:int = 64;
		
		public function VilaAbandonadaMap(map:XML):void
		{
			type = "level";

			tilemap = new Tilemap(Assets.TILES_VILA_ABANDONADA,map.width,map.height,dimW,dimH);			
			
			graphic = tilemap;
			
			grid = new Grid(map.width,320,dimW,dimH,0,0); //3840
			mask = grid;
		}	

	}
}
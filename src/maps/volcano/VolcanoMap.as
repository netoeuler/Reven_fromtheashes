package maps.volcano
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.Grid;

	public class VolcanoMap extends Entity
	{
		public var tilemap:Tilemap;
		public var grid:Grid;
		public var grid2:Grid;
		//public var arrayGrid:Array = new Array();
		
		public var dimW:int = 64;
		public var dimH:int = 64;
		
		public function VolcanoMap(map:XML):void
		{
			type = "level";

			tilemap = new Tilemap(Assets.TILES_VOLCANO,map.width,map.height,dimW,dimH);
			
			graphic = tilemap;
			
			grid = new Grid(map.width, 256, dimW, dimH, 0, 0);
			//arrayGrid.push(grid);
			grid2 = new Grid(192, 192, 64, 64, 448, 320);
			//arrayGrid.push(grid2);
			mask = grid;
			
			grid.setRect(320, 320, 64, 64, true);
			grid2.setRect(320, 320, 64, 64, true);
		}	

	}
}
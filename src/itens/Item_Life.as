package itens{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Item_Life extends Item
	{
		[Embed(source = '../gfx/item_life.png')] private const ITEMLIFE:Class;		
	
		public function Item_Life(dPlayer,dX, dY):void
		{
			this.x = dX;
			this.y = dY;

			player = dPlayer;
			
			spr = new Image(ITEMLIFE);
			graphic = spr;		
		}
		
		override public function onCollide():void{
			if (player.currentLife < player.lifeMax){
				player.currentLife++;
				player.map.updateLife();
			}	
		}
	}	
}
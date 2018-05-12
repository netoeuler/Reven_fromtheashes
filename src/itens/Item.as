package itens{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;

	public class Item extends Entity
	{
		[Embed(source = '../snd/item.mp3')] private const ITEM_SND:Class;
		
		public var sfx:Sfx = new Sfx(ITEM_SND);
		
		public var spr:Image;
		
		public var player;
	
		public function Item():void
		{
			graphic = spr;			
			
			setHitbox(23,21);
		}
		
		override public function update():void{
			if (this.x < FP.camera.x)
				FP.world.remove(this);
			
			if(collide("player",x,y))
			{
				sfx.play();
				onCollide();					
				FP.world.remove(this);
			}
			
			super.update();
		}
		
		public function onCollide():void{			
		}
	}
}
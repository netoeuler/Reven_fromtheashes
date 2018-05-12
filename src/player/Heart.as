package player
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Heart extends Entity{		
		[Embed(source = '../gfx/heart.png')] private const HEART:Class;
		
		public var sprHeart:Spritemap = new Spritemap(HEART, 30, 23);		
		
		public var incX:int;
	
		public function Heart(status:int, _incX:int):void
		{
			incX = _incX;
			
			sprHeart.add("red", [0], 0, false);
			sprHeart.add("black", [1], 0, false);
			
			graphic = sprHeart;
			
			if (status == 0) sprHeart.play("red");
			else sprHeart.play("black");
		}		
		
		override public function update():void
		{
			this.x = FP.camera.x + incX;
			//this.y = 450;
		}
		
	}
}
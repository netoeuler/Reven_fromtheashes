package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Stairway extends Entity
	{
		[Embed(source = 'gfx/stairway.png')] private const STAIRWAY:Class;
		
		public var spr:Image = new Image(STAIRWAY);
		
		public function Stairway():void
		{
			this.x = 448;
			this.y = 320;
			graphic = spr;			
		}		
	}
}
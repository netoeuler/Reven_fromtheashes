package player
{
	import net.flashpunk.Entity;	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	public class Avatar extends Entity{
		[Embed(source = '../gfx/swordguy_avatar.png')] private const AVATAR:Class;
		
		public var spr:Image = new Image(AVATAR);
		
		public function Avatar():void{			
			graphic = spr;
		}
		
		override public function update():void{			
			this.x = FP.camera.x;
			this.y = 30;
			
			super.update();
		}		
	}
}
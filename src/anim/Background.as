package anim {
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class Background extends Entity
	{
		public var img:Image;

		public function Background(cls:Class) {
			img = new Image(cls);
			graphic = img;
		}
		
		override public function update():void{
			this.x = FP.camera.x;
		}

	}
	
}

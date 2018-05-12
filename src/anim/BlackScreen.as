package anim
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class BlackScreen extends Entity
	{
		[Embed(source = '../gfx/blackScreen.png')] private const BLACK:Class;
		
		public var spr:Image = new Image(BLACK);		
		
		private var count:int = 0;
		private var countMax:int = 5;
	
		public function BlackScreen():void
		{
			graphic = spr;
			
			this.x = FP.width/2 - 32;
			this.y = FP.height/2 - 32;
		}
		
		override public function update():void{
			if (spr.scale < 25){
				count++;
				if (count > countMax){
					count = 0;
					
					this.x -= 32;
					this.y -= 32;
					
					spr.scale++;
				}
			}			
		}
		
		public function atingiuTamanhoMaximo():Boolean{
			if (spr.scale == 25)
				return true;
			else 
				return false;
		}
		
	}
}
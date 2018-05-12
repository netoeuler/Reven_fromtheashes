package anim
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class GameOver extends Entity
	{
		[Embed(source = '../gfx/game_over.png')] private const GAMEOVER:Class;
		
		public var spr:Image = new Image(GAMEOVER);
		
		private var count:int = 0;
		private var countMax:int = 5;
	
		public function GameOver():void
		{
			graphic = spr;
			
			this.x = FP.width/2 - 32;
			this.y = FP.height/2 - 32;
		}
		
		override public function update():void {
			if (Input.check(Key.A)) {
				Input.clear();
				FP.world = new Menu();
			}
			
			super.update();
		}
	}
}
package player
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;

	public class Lives extends Entity{		
		public var lives:Text;
		public var livesNum:int = 3; //3
		
		private var xIni:int;
		private var yIni:int;
	
		public function Lives(avatar:Avatar):void{
			xIni = avatar.x + avatar.width + 20;
			yIni = avatar.y + avatar.spr.height + 15;
		
			lives = new Text( String(livesNum),xIni,yIni );			
			
			graphic = lives;
		}
		
		override public function update():void{
			lives.text = "x "+livesNum;
			lives.x = FP.camera.x + 25;
			
			super.update();
		}
		
		public function updateLives(value:int):void{
			livesNum += value;
		}
		
		public function setLives(value:int):void
		{
			livesNum = value;
		}
		
	}
}
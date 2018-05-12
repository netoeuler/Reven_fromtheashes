package player
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;

	public class Score extends Entity{		
		public var score:Text;
		public var scoreNum:int = 0;
	
		public function Score():void{
			score = new Text( String(scoreNum),0,450 );			
			
			graphic = score;
		}
		
		override public function update():void{
			score.text = "Score: "+String(scoreNum);
			score.x = FP.camera.x;
			
			super.update();
		}
		
		public function updateScore(value:int):void{
			scoreNum += value;
		}
		
		public function setScore(value:int):void
		{
			scoreNum = value;
		}
		
	}
}
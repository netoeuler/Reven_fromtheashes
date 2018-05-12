package player
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;

	public class Pendant extends Entity{		
		[Embed(source = '../gfx/pendants.png')] private const PENDANTS:Class;
		
		public var spr:Spritemap = new Spritemap(PENDANTS, 64, 64);	
		public var animComplete:Boolean = false;
		public var stopMoveAround:Boolean = false;
		public var count:int = 0;
		
		public var dirHor:String = "left";
		public var dirVer:String = "down";
	
		public function Pendant(destino:String):void
		{			
			spr.add("floresta", [0], 0, false);
			spr.add("caverna", [1], 0, false);
			spr.add("vila_abandonada", [2], 0, false);
			graphic = spr;			
			
			this.x = 280;
			this.y = -20;			
			
			spr.play(destino);
		}		
		
		override public function update():void
		{
			if (Main.arrayOfLevelCompleted.length == 3) {
				if (!stopMoveAround)
					moveAround();
				else
					if (this.x > 500 && this.y > 400) {
						graphic = null;
						animComplete = true;
					}
					else
						moveTowards(520, 420, 10);
			}
			else {
				if (this.y < 230)
					this.y += 2;
				else
					animComplete = true;
			}
			
			super.update();
		}
		
		public function moveAround():void {
			if (count > 320)
				stopMoveAround = true;
			else
				count++;
			
			if (dirHor == "left") {
				if (this.x > 200)
					this.x -= 5;
				else
					dirHor = "right";
			}
			else {
				if (this.x < 400)
					this.x += 5;
				else
					dirHor = "left";
			}
			
			if (dirVer == "down") {
				if (this.y < 220)
					this.y += 2.5;
				else {
					if (dirHor == "left")
						dirVer = "up";
				}
			}
			else {
				if (this.y > 200)
					this.y -= 2.5;
				else {
					if (dirHor == "right")
						dirVer = "down";
				}
			}
		}
		
	}
}
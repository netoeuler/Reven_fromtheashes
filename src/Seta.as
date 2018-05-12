package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.FP;
	import flash.geom.Point;
	import net.flashpunk.utils.*;
	import player.*;
	import anim.*;

	public class Seta extends Entity{		
		[Embed(source = '/gfx/seta.png')] private const SETA:Class;
		
		public var spr:Spritemap = new Spritemap(SETA, 30, 23);		
		
		public var i:int = 0;
		public var count:int = 0;
		public var point:Point;
		private var positions:Array = new Array();
		private var movePlayerToPoint:Boolean = false;
		private var blackScreen:BlackScreen;
		
		private var map:Map;
		
		private var _player:Player;
	
		public function Seta(_map:Map):void //p:Player
		{			
			spr.add("anim", [0,1], 5, true);
			
			map = _map;
			_player = _map._player;
			
			generatePositions();	
			
			graphic = spr;
			spr.play("anim");
		}
		
		override public function update():void
		{
			this.x = positions[i].x;
			this.y = positions[i].y;
			
			if (Input.check(Key.RIGHT) && count == 0){
				if (i+1 < positions.length)
					i++;
				else
					i = 0;
				
				count++;
			}
			if (Input.check(Key.LEFT) && count == 0){
				if (i > 0)
					i--;
				else
					i = positions.length-1;
				
				count++;
			}
			
			if (count > 0)
				count++;
			if (count > 20)
				count = 0;
				
			if (Input.check(Key.A))
				movePlayerToPoint = true;
			
			if (movePlayerToPoint){
				_player.moveTowards(this.x,this.y,10);				
				
				if (_player.x == this.x && _player.y == this.y){
					//map.printBlackScreen(blackScreen);
					blackScreen = new BlackScreen();
					FP.world.add(blackScreen);
					movePlayerToPoint = false;
				}					
			}
			
			if (blackScreen != null)
				if (blackScreen.atingiuTamanhoMaximo())
					map.checkDestino(i);
		}
		
		private function generatePositions():void{
			
			if (!compareIfHasFinished("aldeia")) {
				point = new Point(240,400); //aldeia
				positions.push(point);
			}
			
			if (!compareIfHasFinished("floresta")) {
				point = new Point(130,345); //floresta
				positions.push(point);
			}
			
			if (!compareIfHasFinished("caverna")) {
				point = new Point(482,278); //caverna
				positions.push(point);
			}
			
			if (!compareIfHasFinished("vila_abandonada")) {
				point = new Point(66,180); //vila abandonada
				positions.push(point);
			}
			
			point = new Point(258,150); //volcano
			positions.push(point);			
		}
		
		private function compareIfHasFinished(destino:String):Boolean {			
			for (var iAux:int = 0 ; iAux < Main.arrayOfLevelCompleted.length ; iAux++) {
				if (destino == Main.arrayOfLevelCompleted[iAux])
					return true;
			}
			
			return false;
		}
		
	}
}
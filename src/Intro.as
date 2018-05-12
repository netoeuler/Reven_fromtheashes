package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import player.Player;
	
	/**
	 * ...
	 * @author EulerNeto
	 */
	public class Intro extends World 
	{
		[Embed(source = 'gfx/intro/pg01.png')] private const INTRO_01:Class;
		[Embed(source = 'gfx/intro/pg02.png')] private const INTRO_02:Class;
		[Embed(source = 'gfx/intro/pg03.png')] private const INTRO_03:Class;
		[Embed(source = 'gfx/intro/pg04.png')] private const INTRO_04:Class;
		[Embed(source = 'gfx/intro/pg05.png')] private const INTRO_05:Class;
		
		public var arraySpr:Array = new Array();
		public var arrayText:Array = new Array();
		
		public var iC:int = 0;
		
		//public var currentText:Entity = new Entity;
		public var rodape:Entity;
		
		public var _player;
		
		public function Intro(_p:Player):void {
			_player = _p;
			
			generateArraySpr();
			generateArrayText();
			generateRodape();
			FPWorldAdd();		
		}
		
		override public function update():void {			
			if (Input.check(Key.A)) {
				Input.clear();
				if (iC+1 < arraySpr.length){
					remove(arraySpr[iC]);
					remove(arrayText[iC]);
					iC++;
					FPWorldAdd();					
				}
				else
					FP.world = new Map("mapa", _player, false);
			}
			
			if (Input.check(Key.S)) {
				Input.clear();
				FP.world = new Map("mapa", _player, false);
			}
			
			super.update();
		}
		
		public function generateArraySpr():void {
			var entity:Entity;
			var spr:Image;
			
			spr = new Image(INTRO_01);
			spr.scale = 0.6;
			entity = new Entity();
			entity.graphic = spr;
			arraySpr.push(entity);
			
			spr = new Image(INTRO_02);
			spr.scale = 0.6;
			entity = new Entity();
			entity.graphic = spr;
			arraySpr.push(entity);
			
			spr = new Image(INTRO_03);
			spr.scale = 0.6;
			entity = new Entity();
			entity.graphic = spr;
			arraySpr.push(entity);
			
			spr = new Image(INTRO_04);
			spr.scale = 0.6;
			entity = new Entity();
			entity.graphic = spr;
			arraySpr.push(entity);
			
			spr = new Image(INTRO_05);
			spr.scale = 0.6;
			entity = new Entity();
			entity.graphic = spr;
			arraySpr.push(entity);
		}
		
		public function generateArrayText():void {
			var entity:Entity;
			var text:String;
			
			text = "There's one more calm day in the Log Island. The sun is high, the birds \n";
			text += "fly and the habbitants lives the routine.";
			entity = new Entity();
			entity.graphic = new Text(text);
			arrayText.push(entity);
			
			text = "When a fire comet approachs falling inside the volcano. Instantly a \n";
			text += "earthquake begins causing population's total panic. \n";
			text += "Nobody knew what to do when a strange old man appears..";
			entity = new Entity();
			entity.graphic = new Text(text);
			arrayText.push(entity);
			
			text = "He explain that comet is Pele, a demon tath feeds fire. He came from \n";
			text += "the island when know about the volcano. So he'll accommodate inside it \n";
			text += "to gain energy and destroy everyone."
			entity = new Entity();
			entity.graphic = new Text(text);
			arrayText.push(entity);
			
			text = "The oldman is a necromancer and he's offer to ressurect Reven, \n";
			text += "the legendary protector to the island who is dead. \n";			
			entity = new Entity();
			entity.graphic = new Text(text);
			arrayText.push(entity);
			
			text = "Reven back to life and your mission is going to the volcano \n";
			text += "and destroy Pele";
			entity = new Entity();
			entity.graphic = new Text(text);
			arrayText.push(entity);
		}
		
		public function FPWorldAdd():void {			
			arraySpr[iC].x = 130;
			arraySpr[iC].y = 50;			
			add(arraySpr[iC]);
			
			arrayText[iC].y = 350;
			add(arrayText[iC]);
		}
		
		public function generateRodape():void {			
			rodape = new Entity();
			rodape.graphic = new Text("[S] Skip / [A] Continue >");
			rodape.y = 460;
			add(rodape);
		}
		
	}
	
}
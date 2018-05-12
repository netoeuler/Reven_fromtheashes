package  {
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.geom.Point;
	import player.Player;
	
	public class Menu extends World{		
		[Embed(source = 'gfx/title.png')] private static const TITLE:Class;
		[Embed(source = 'gfx/setaMenu.png')] private static const SETAMENU:Class;
		
		[Embed(source = 'snd/click.mp3')] private const CLICK:Class;
		
		var _player:Player = new Player("player",null);
		
		private var countToAppearMenu:int = 0;
		private var countBlinkPressStart:int = 0;
		private var countSeta:int = 0;
		
		private var pressStartMode:Boolean = false;
		
		private var entityMenu:Entity;
		
		private var seta:Entity = null;
		private var positions:Array = new Array();
		private var txt_right_array:Array;
		
		private var txt_menu:Text;
		private var state:String = "menu";
		private var dir:String = "";
		
		private var i:int = 0;
		private var j:int = 0;
		private var maxPosition:int = 0;
		
		private var rightLife:Array = new Array(3,4,5);
		private var rightContinue:Array = new Array(0,1,2,3);
		private var rightSound:Array = new Array("on", "off");
		private var iLife:int = 0;
		private var iContinue:int = 3;
		private var iSound:int = 0;
		
		private var sfxClick:Sfx = new Sfx(CLICK);
		
		public function Menu() {			
			printImage(TITLE,150,20);
			
			createText("2011 - NetoNightmare", 200, 460);			
			
			initArrayPositions("menu");
			seta.visible = false;
		}
		
		override public function update():void
		{			
			if (countToAppearMenu == 30){
				pressStartMode = true;
				pressStartText();				
				countToAppearMenu++;
			}
			else
				countToAppearMenu++;
				
			if (countToAppearMenu > 30)
			{				
				if (positions != null) {
					seta.x = positions[i].x;
					seta.y = positions[i].y;
				}
				if (state == "options") {
					if (iSound == 0)
						FP.volume = 1; 
					else
						FP.volume = 0;
					
					_player.lifeMax = rightLife[iLife];
					_player.lives.livesNum = rightContinue[iContinue];
				}
				
				keys();
				
				if (countSeta > 0)
					if (countSeta > 15)
						countSeta = 0;
					else
						countSeta++;
			}
			
			super.update();
		}
		
		public function destinoByDirRight():void {
			if (i == 0) {
				if (iLife + 1 > rightLife.length - 1)
					iLife = 0;
				else
					iLife++;
			}
			if (i == 1) {
				if (iContinue + 1 > rightContinue.length - 1)
					iContinue = 0;
				else
					iContinue++;
			}
			if (i == 2) {
				if (iSound + 1 > rightSound.length - 1)
					iSound = 0;
				else
					iSound++;
			}
			dir = "";
		}
		
		public function destinoByDirLeft():void {
			if (i == 0) {
				if (iLife - 1 < 0)
					iLife = rightLife.length - 1;
				else
					iLife--;
			}
			if (i == 1) {
				if (iContinue - 1 < 0)
					iContinue = rightContinue.length - 1;
				else
					iContinue--;
			}
			if (i == 2) {
				if (iSound - 1 < 0)
					iSound = rightSound.length - 1;
				else
					iSound--;
			}
			dir = "";
		}
		
		public function menu():void {	
			state = "menu";
			maxPosition = 1;
			
			remove(entityMenu);
			
			var txtmenu = "Start \n\n" +
					      "Options";
						  
			txt_menu = new Text(txtmenu);
			
			txt_menu.x = 250;
			txt_menu.y = 270;
			
			entityMenu = new Entity();
			entityMenu.graphic = txt_menu;
			add(entityMenu);
		}
		
		public function options():void {
			state = "options";
			maxPosition = 3;		
			
			remove(entityMenu);			
			
			entityMenu = new Entity();
			entityMenu.graphic = new Text("");
			generateOptions();
			add(entityMenu);
		}
		
		public function keys():void{
			if (pressStartMode) {
				if (Input.check(Key.A)) {
					sfxClick.play();
					Input.clear();
					pressStartMode = false				
					menu();
					seta.visible = true;				
				}
			}
			else {
				if (Input.check(Key.A)){
					sfxClick.play();
					Input.clear();				
					destino(state);
					
				}				
				
				if (Input.check(Key.DOWN) && seta.visible && countSeta == 0){
					countSeta++;
					if ( (i+1) > maxPosition ) //positions.length-1
						i = 0;
					else
						i++;
				}
				
				if (Input.check(Key.UP) && seta.visible && countSeta == 0){
					countSeta++;
					if ( (i-1) < 0 )
						i = maxPosition;
					else
						i--;
				}
				
				if (state == "options") {
					if (Input.check(Key.RIGHT) && seta.visible && countSeta == 0) {
						countSeta++;
						dir = "right";
						destino(state)
					}
					if (Input.check(Key.LEFT) && seta.visible && countSeta == 0) {
						countSeta++;
						dir = "left";
						destino(state)
					}
				}
				
			}
		}
		
		public function printImage(imgClass:Class,_x:int,_y:int):void{
			var img:Image = new Image(imgClass);
			img.x = _x;
			img.y = _y;
			
			var entity = new Entity();
			entity.graphic = img;
			add(entity);
		}
		
		public function printSeta():void {
			if (seta != null)
				remove(seta);
			
			var img:Image = new Image(SETAMENU);					
			
			seta = new Entity();
			seta.graphic = img;
			add(seta);
		}		
		
		public function pressStartText():void{
			var txt:Text = new Text("Press [A] to Continue",200,250);
			
			entityMenu = new Entity();
			entityMenu.graphic = txt;
			add(entityMenu);
		}
		
		public function initArrayPositions(st:String):void{
			var point:Point;
			
			for each(var p in positions)
				positions.pop();
			
			point = new Point(230,275);
			positions.push(point);
			point = new Point(230,305);
			positions.push(point);
			point = new Point(230,335);
			positions.push(point);
			point = new Point(230,365);
			positions.push(point);
			
			if (st == "menu")
				maxPosition = 1;
			if (st == "options")
				maxPosition = 3;			
			
			printSeta();
		}
		
		public function destino(st:String):void {
			if (st == "menu") {
				if (i == 0)
					FP.world = new Intro(_player); //new Map("mapa", _player, false);
				if (i == 1) {
					i = 0;
					options();		
				}
			}
			else if (st == "options") {		
				if (i == 3) {
					i = 0;
					removeOptions();
					menu();
				}
				else {
					if (dir == "right")
						destinoByDirRight();
					else if (dir == "left")
						destinoByDirLeft();
					
					updateOptions();
				}
			}
		}
		
		private function generateOptions():void {			
			var ix:int = 250;
			var iy:int = 270;
			var entityText:Entity;
			
			txt_right_array = new Array();
			
			//[0]
			txt_right_array.push(new Array());
			entityText = createText("Life: ", ix, iy);
			txt_right_array[0].push(entityText);
			entityText = createText( rightLife[iLife]+"", ix + 150, iy );
			txt_right_array[0].push(entityText);
			
			//[1]
			txt_right_array.push(new Array());
			entityText = createText("Continues: ", ix, iy + 30);
			txt_right_array[1].push(entityText);
			entityText = createText( rightContinue[iContinue]+"", ix + 150, iy + 30 );
			txt_right_array[1].push(entityText);
			
			//[2]
			txt_right_array.push(new Array());
			entityText = createText("Sound: ", ix, iy + 60)
			txt_right_array[2].push(entityText);
			entityText = createText( rightSound[iSound]+"", ix + 150, iy + 60 );
			txt_right_array[2].push(entityText);
			
			//[3]
			txt_right_array.push(new Array());
			entityText = createText("Back To Menu", ix, iy + 90)
			txt_right_array[3].push(entityText);
			entityText = createText("", ix + 150, iy + 90)
			txt_right_array[3].push(entityText);							
			
			for (var line in txt_right_array) {
				for (var row in txt_right_array[i])
					FP.world.add(txt_right_array[line][row]);
			}			
		}
		
		private function removeOptions():void {
			for (var line in txt_right_array) {
				for (var row in txt_right_array[i])
					FP.world.remove(txt_right_array[line][row]);
			}
		}
		
		private function createText(text:String,ix:int,iy:int):Entity {
			var e:Entity = new Entity;
			e.graphic = new Text(text, ix, iy);
			
			return e;
		}
		
		private function updateOptions():void {
			removeOptions();
			generateOptions();
		}

	}	
}
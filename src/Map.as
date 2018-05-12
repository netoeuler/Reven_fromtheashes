package
{
	import maps.vila_abandonada.VilaAbandonadaMap;
	import maps.volcano.Lava;
	import maps.volcano.VolcanoMap2;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import maps.floresta.FlorestaMap;
	import maps.volcano.VolcanoMap;
	import maps.aldeia.AldeiaMap; 
	import maps.mapa.LevelMap;
	import maps.mapa.Water;
	import npc.OldMan;
	import player.*;
	import enemies.*;
	import bosses.*;
	import spells.*;
	import anim.*;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;	
	import maps.caverna.CavernaMap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.events.Event;
	
	public class Map extends World
	{
		//OELS
		[Embed(source = "maps/aldeia/aldeia.oel", mimeType = "application/octet-stream")] private static const ALDEIA_OEL:Class;
		[Embed(source = "maps/mapa/mundo.oel", mimeType = "application/octet-stream")] private static const MAP_OEL:Class;
		[Embed(source = "maps/floresta/floresta.oel", mimeType = "application/octet-stream")] private static const FLORESTA_OEL:Class;
		[Embed(source = "maps/floresta/florestaBoss.oel", mimeType = "application/octet-stream")] private static const FLORESTABOSS_OEL:Class;
		[Embed(source = "maps/caverna/caverna.oel", mimeType = "application/octet-stream")] private static const CAVERNA_OEL:Class;
		[Embed(source = "maps/caverna/cavernaBoss.oel", mimeType = "application/octet-stream")] private static const CAVERNABOSS_OEL:Class;
		[Embed(source = "maps/vila_abandonada/vila_abandonada.oel", mimeType = "application/octet-stream")] private static const VILA_ABANDONADA_OEL:Class;
		[Embed(source = "maps/vila_abandonada/vila_abandonadaBoss.oel", mimeType = "application/octet-stream")] private static const VILA_ABANDONADABOSS_OEL:Class;
		[Embed(source = "maps/volcano/volcano.oel", mimeType = "application/octet-stream")] private static const VOLCANO_OEL:Class;
		[Embed(source = "maps/volcano/volcano2.oel", mimeType = "application/octet-stream")] private static const VOLCANO2_OEL:Class;
		[Embed(source = "maps/volcano/volcano2Boss.oel", mimeType = "application/octet-stream")] private static const VOLCANO2BOSS_OEL:Class;
		
		//BACKGROUNDS
		[Embed(source = 'maps/aldeia/background.png')] private static const BCK_ALDEIA:Class;
		[Embed(source = 'maps/floresta/background.png')] private static const BCK_FLORESTA:Class;
		[Embed(source = 'maps/volcano/background.png')] private static const BCK_VOLCANO:Class;
		
		//THEMES
		[Embed(source = 'themes/mapaTheme.mp3')] private const MAPA_THEME:Class;
		[Embed(source = 'themes/bossTheme.mp3')] private const BOSS_THEME:Class;
		[Embed(source = 'themes/aldeiaTheme.mp3')] private const ALDEIA_THEME:Class;
		[Embed(source = 'themes/florestaTheme.mp3')] private const FLORESTA_THEME:Class;
		[Embed(source = 'themes/cavernaTheme.mp3')] private const CAVERNA_THEME:Class;
		[Embed(source = 'themes/vila_abandonadaTheme.mp3')] private const VILA_ABAND_THEME:Class;
		[Embed(source = 'themes/volcanoTheme.mp3')] private const VOLCANO_THEME:Class;
		[Embed(source = 'themes/volcano2Theme.mp3')] private const VOLCANO2_THEME:Class;
		
		//SFX
		[Embed(source = 'snd/win.mp3')] private const WINSFX:Class;
		[Embed(source = 'snd/shine.mp3')] private const SHINESFX:Class;
		[Embed(source = 'snd/getPendant.mp3')] private const GETPENDANTSFX:Class;
		
		public var entity;
		public var destino:String;
		public var _player:Player;
		public static var theme:Sfx;
		
		public var countMap:int = 0;
		public var intervalToAppearEnemy:int = 300;
		public var levelAsStarted:Boolean = false;
		public var levelAsOver:Boolean = false;
		public var isBossLevel:Boolean;
		public var boss:Boss;
		public var bossDeadCount:int = 0;
		public var pendant:Pendant = null;	
		public var water:Boolean = false;
		public var countAnimPendants:int = 0;
		public var countGeneralExplode:int = 0;
		public var countExplode:int = 0;
		public var stairway:Stairway;
		public var seta:Seta;
		public var pause:Boolean;		
		public var backgroundPause:BlackScreen;
		public var pauseText:Entity;
		public var dialogueBoxActive:Boolean = false;
		public var oldman:OldMan = null;
		
		public static var rightArm;
		public static var leftArm;
		
		public var backgroundMap:Background;
		public var isScrolling:Boolean;
		
		public static var currentEnemiesInTheStage:int = 0;
		
		public var ramData:ByteArray;
		public var xmlData:XML;
		
		public function Map(_destino:String, playerAux:Player, _bossLevel:Boolean):void
		{
			destino = _destino;
			isBossLevel = _bossLevel;			
			
			switch(destino){
				case "mapa":
					isScrolling = false;
					
					ramData = new MAP_OEL;
					xmlData = new XML(ramData.readUTFBytes(ramData.length));
					loadMap();
					
					theme = new Sfx(MAPA_THEME);
					
					_player = new Player("small_player",this);
					_player.x = 240;
					_player.y = 440;
					
					seta = new Seta(this);
					add(seta);
					
					break;
				case "aldeia":
					isScrolling = false;
					ramData = new ALDEIA_OEL;
					theme = new Sfx(ALDEIA_THEME);
					
					xmlData = new XML(ramData.readUTFBytes(ramData.length));
					backgroundMap = new Background(BCK_ALDEIA);
					loadMap();
					
					oldman = new OldMan(this);
					add(oldman);
					
					_player = new Player("player",this);
					_player.x = -100;
					_player.y = 400;					
					
					break;
				case "floresta":
					if (isBossLevel)
					{
						isScrolling = false;
						ramData = new FLORESTABOSS_OEL;
						theme = new Sfx(BOSS_THEME);
					}
					else
					{
						isScrolling = true;
						ramData = new FLORESTA_OEL;
						theme = new Sfx(FLORESTA_THEME);
					}					
					xmlData = new XML(ramData.readUTFBytes(ramData.length));
					backgroundMap = new Background(BCK_FLORESTA);
					loadMap();
					
					_player = new Player("player",this);
					_player.x = -100;
					_player.y = 400;					
					
					break;
				case "caverna":
					if (isBossLevel)
					{
						isScrolling = false;
						ramData = new CAVERNABOSS_OEL;
						theme = new Sfx(BOSS_THEME);
					}
					else
					{
						isScrolling = true;
						ramData = new CAVERNA_OEL;
						theme = new Sfx(CAVERNA_THEME);
					}					
					xmlData = new XML(ramData.readUTFBytes(ramData.length));
					//backgroundMap = new Background(BCK_FLORESTA);
					loadMap();
					
					_player = new Player("player",this);
					_player.x = -100;
					_player.y = 400;					
					
					break;
				case "vila_abandonada":
					if (isBossLevel)
					{
						isScrolling = false;
						ramData = new VILA_ABANDONADABOSS_OEL;
						theme = new Sfx(BOSS_THEME);
						water = true;
					}
					else
					{
						isScrolling = true;
						ramData = new VILA_ABANDONADA_OEL;
						theme = new Sfx(VILA_ABAND_THEME);
					}					
					xmlData = new XML(ramData.readUTFBytes(ramData.length));
					backgroundMap = new Background(BCK_ALDEIA);
					loadMap();					
					
					_player = new Player("player", this);
					_player.x = -100;
					_player.y = 400;					
					
					break;
				case "volcano":
					isScrolling = false;
					
					ramData = new VOLCANO_OEL;
					theme = new Sfx(VOLCANO_THEME);

					xmlData = new XML(ramData.readUTFBytes(ramData.length));
					backgroundMap = new Background(BCK_VOLCANO);
					loadMap();
					
					stairway = new Stairway();					
					stairway.visible = Main.stairwaySummoned;
					add(stairway);
					
					_player = new Player("player",this);
					_player.x = -100;
					_player.y = 400;					
					
					break;
				case "volcano2":
					if (isBossLevel)
					{
						isScrolling = false;
						ramData = new VOLCANO2BOSS_OEL;
						theme = new Sfx(BOSS_THEME);						
					}
					else
					{
						isScrolling = true;
						ramData = new VOLCANO2_OEL;
						theme = new Sfx(VOLCANO2_THEME);
					}					
					xmlData = new XML(ramData.readUTFBytes(ramData.length));
					backgroundMap = new Background(BCK_VOLCANO);
					loadMap();					
					
					_player = new Player("player", this);
					_player.x = -100;
					_player.y = 400;
					
					printLava();
					
					break;
			}
			
			if (isBossLevel) {
				boss = buildBoss(destino);	
				boss.active = false;
				add(boss);
				
				if (destino == "volcano2") {
					/*
					rightArm = new PeleArm(_player,boss, "right");
					leftArm = new PeleArm(_player,boss, "left");
					add(rightArm);
					add(leftArm);
					*/
					rightArm = null;
					leftArm = null;
				}
			}				
			
			_player.score.setScore(playerAux.score.scoreNum);
			_player.setCurrentLife(playerAux.currentLife);
			_player.setLifeMax(playerAux.lifeMax);
			_player.lives.setLives(playerAux.lives.livesNum);
			
			add(_player);
			add(_player.score);
			add(_player.avatar);
			add(_player.lives);
			printLife(true);
			
			if (theme != null)
				theme.loop();
		}
		
		override public function update():void
		{				
			if (destino != "mapa") {
				if (Input.check(Key.P)) {
					Input.clear();
					Pause();
					
					if (pause)
						pause = false;
					else
						pause = true;
				}
				if (Input.check(Key.M)) {
					if (FP.volume == 0)
						FP.volume = 1;
					else if (FP.volume == 1)
						FP.volume = 0;
				}
			}
			if (destino == "aldeia") {
				if ( Input.check(Key.A) ) { 
					Input.clear();					
					
					if (!dialogueBoxActive)
						add( oldman.getDialog() );
					else {
						oldman.remove();
						if (_player.currentLife < _player.lifeMax) {
							_player.currentLife = _player.lifeMax;
							updateLife();
						}						
						dialogueBoxActive = false;
					}
				}
			}
			
			if (!levelAsStarted)
			{
				if (_player.x > 70)
				{
					_player.setControllable(true);
					levelAsStarted = true;
					if (isBossLevel)
						boss.active = true;
				}
				else				
				{					
					_player.sprSwordguy.play("run");
					_player.x++;
				}				
			}
			else
			{
				if (!pause) { // || !dialogueBoxActive
					if (isScrolling)
						scrollingLevel();
					else
						nonScrollingLevel();
				}				

				if (isBossLevel)
					if (boss.callPele2){
						boss = new Pele2(_player);
						add(boss);
					}
				
					if (boss.bossFinished) {						
						if (pendant == null) {
							theme.stop();
							theme = new Sfx(GETPENDANTSFX);
							theme.play();
							pendant = new Pendant(destino);
							add(pendant);
							
							if (!_player.sprSwordguy.flipped)
								_player.sprSwordguy.flipped = true;
							else
								_player.sprSwordguy.flipped = false;
						}
						else
							if (pendant.animComplete)
								levelCompleteAnimation();
							else {
								_player.setControllable(false);								
									
								if (_player.x == 250 && _player.y == 400) {									
									_player.sprSwordguy.play("stand");
									_player.sprSwordguy.flipped = false;
								}
								else {									
									_player.sprSwordguy.play("run");
									_player.moveTowards(250, 400, _player.speed);
								}
							}
					}					
			}
			
			if (!dialogueBoxActive) {
				if (!pause)
					super.update();
			}				
		}
		
		/*
		//
		//
		//
		//
		*/		
		
		public function levelCompleteAnimation():void {			
			bossDeadCount++;
			if (bossDeadCount == 50) {
				_player.sprSwordguy.play("stand");
				_player.setControllable(false);
			}
			if (bossDeadCount == 100){
				theme = new Sfx(WINSFX);
				theme.play();							
			}
			if (bossDeadCount == 400) {
				_player.sprSwordguy.play("win");
				theme = new Sfx(SHINESFX);
				theme.play();														
			}
			if (bossDeadCount > 420)
				goToNextLevelMap();
		}
		
		public function scrollingLevel():void
		{			
			if (destino != "mapa")
			{
				if (FP.camera.x < 3200)
					generateEnemies();
				else
					if (currentEnemiesInTheStage == 0)
						goToNextLevel();

				if (!outOfRange())
				{
					FP.camera.x += 0.5;
					if (_player.x <= FP.camera.x)
						_player.x += _player.speed;
				}
			}
		}
		
		public function nonScrollingLevel():void{
			if (destino != "mapa" && !isBossLevel)
			{
				if (_player.x < -80)
					backToMap();
				
				if (destino == "volcano" && Main.arrayOfLevelCompleted.length == 3) {
					if (!Main.stairwaySummoned)
						animWhenHaveThreePendants();
				}
			}
			
		}
		
		public function outOfRange():Boolean
		{			
			if (_player.x > 0 && FP.camera.x < 3200)
				return false;
			else
				return true;
		}
		
		public function printWater():void
		{
			for (var w=0; w < 640 ; w+=32)
				for (var h=0; h < 480 ; h+=32)
					add(new Water(w,h));
		}
		
		public function printLava():void {
			var dataElement:XML;
			
			for each(dataElement in xmlData.camada3.tile) {
				var lava:Lava = new Lava(_player);
				lava.x = int(dataElement.@x);
				lava.y = int(dataElement.@y);
				add(lava);
			}
		}
		
		public function loadMap():void
		{			
			var dataElement:XML;
			
			if (backgroundMap != null)
				add(backgroundMap);
			
			if (destino == "mapa")
				printWater();
			
			builder(destino);
			
			for each(dataElement in xmlData.camada.tile)
			{
				entity.tilemap.setTile(int(dataElement.@x)/entity.dimW, 
										int(dataElement.@y)/entity.dimH,
										entity.tilemap.getIndex(int(dataElement.@tx)/entity.dimW,int(dataElement.@ty)/entity.dimH));
				entity.grid.setTile(int(dataElement.@x)/entity.dimW, 
									int(dataElement.@y)/entity.dimH, 
									true);
			}			
			
			builder(destino);
			
			for each(dataElement in xmlData.camada2.tile)
			{
				entity.tilemap.setTile(int(dataElement.@x)/entity.dimW, 
										int(dataElement.@y)/entity.dimH,
										entity.tilemap.getIndex(int(dataElement.@tx) / entity.dimW, int(dataElement.@ty) / entity.dimH));				
			}
			
			builder(destino);			
			
			for each(dataElement in xmlData.camada3.tile)
			{
				entity.tilemap.setTile(int(dataElement.@x)/entity.dimW, 
										int(dataElement.@y)/entity.dimH,
										entity.tilemap.getIndex(int(dataElement.@tx) / entity.dimW, int(dataElement.@ty) / entity.dimH));
				
				/*if (destino == "volcano2") {
					var lava:Lava = new Lava(_player);
					lava.x = int(dataElement.@x);
					lava.y = int(dataElement.@y);
					add(lava);
				}*/
			}
			
			builder(destino);
		}		
		
		public function builder(instance:String):void
		{			
			switch(instance)
			{
				case "mapa":
					entity = new LevelMap(xmlData);			
					break;
				case "aldeia":
					entity = new AldeiaMap(xmlData);					
					break;
				case "floresta":
					entity = new FlorestaMap(xmlData);					
					break;
				case "caverna":
					entity = new CavernaMap(xmlData);					
					break;
				case "vila_abandonada":
					entity = new VilaAbandonadaMap(xmlData);					
					break;
				case "volcano":
					entity = new VolcanoMap(xmlData);
					break;
				case "volcano2":
					entity = new VolcanoMap2(xmlData);
					break;
			}
			add(entity);
		}
		
		public function buildEnemy(instance:String):Enemy
		{
			var randomEnemy:int;
			
			switch(instance)
			{
				case "floresta":
					randomEnemy = Math.round(Math.random()*1);
					if (randomEnemy == 0) return new Grimalkin(_player);
					if (randomEnemy == 1) return new Zombie(_player);
					
					break
				case "caverna":
					randomEnemy = Math.round(Math.random()*1);
					if (randomEnemy == 0) return new Grimalkin2(_player);
					if (randomEnemy == 1) return new Zombie(_player);
					
					break;
				case "vila_abandonada":
					randomEnemy = Math.round(Math.random()*1);
					if (randomEnemy == 0) return new Grimalkin(_player);
					if (randomEnemy == 1) return new Zombie(_player);
					
					break;
				case "volcano2":
					randomEnemy = Math.round(Math.random()*2);
					if (randomEnemy == 0) return new Grimalkin(_player);
					if (randomEnemy == 1) return new Zombie(_player);
					if (randomEnemy == 2) return new Grimalkin2(_player);
					
					break;
			}
			
			return null;
		}
		
		public function buildBoss(instance:String):Boss
		{			
			switch(instance)
			{
				case "floresta":
					return new Mapinguari(_player);				
					break;
				case "caverna":
					return new Gargoyle(_player);
					break;
				case "vila_abandonada":
					return new Aligator(_player);
					break;
				case "volcano2":
					return new Pele(_player);
					break;
			}
			
			return null;
		}
		
		public function generateEnemies():void
		{
			countMap++;
			
			if (countMap > intervalToAppearEnemy)
			{
				add(buildEnemy(destino));
				currentEnemiesInTheStage++;
				countMap = 0;
				intervalToAppearEnemy = Math.round(Math.random()*150)+50;
			}
		}
		
		public function printLife(maxToo:Boolean):void{
			var heart;
			var i;
			var xIni = 0;
			
			if (maxToo){							
				for (i=0; i < _player.lifeMax; i++)
				{
					heart = new Heart(1,xIni);
					heart.x = xIni;					
					add(heart);
					xIni += 30;
				}
				
				xIni = 0;
			}
			
			for (i=0; i < _player.currentLife; i++)
			{
				heart = new Heart(0,xIni);
				heart.x = xIni;
				_player.life.push(heart);
				add(_player.life[i]);
				xIni += 30;
			}
		}
		
		public function removeLife():void{			
			while (_player.life.length > 0){
				remove(_player.life.pop());				
			}
		}
		
		public function updateLife():void{
			removeLife();
			printLife(false);
		}		
		
		public function goToNextLevel():void
		{			
			if (_player.isBlink())
				_player.blink = false;
				
			_player.setControllable(false);			
			countMap++;
			
			if (countMap > 200)
			{
				_player.sprSwordguy.play("run");
				if (_player.x < 4000) //4000
				{
					if (_player.sprSwordguy.flipped)
						_player.sprSwordguy.flipped = false;
						
					_player.x += _player.speed;
				}
				else
				{
					theme.stop();
					FP.world = new Map(destino, _player, true);
				}
			}
			else
				_player.sprSwordguy.play("stand");				
		}
		
		public function goToNextLevelMap():void {
			//_player.setControllable(false);			
			countMap++;
			
			if (countMap > 100) {
				_player.sprSwordguy.play("run");
				if (_player.x < 700) {
					if (_player.sprSwordguy.flipped)
						_player.sprSwordguy.flipped = false;
						
					_player.x += _player.speed;
				}
				else
				{
					Main.arrayOfLevelCompleted.push(destino);
					theme.stop();
					FP.world = new Map("mapa", _player, false);					
				}
			}
		}
		
		public function checkDestino(i:int):void{
			theme.stop();
			
			if (seta.x == 240 && seta.y == 400)
				FP.world = new Map("aldeia",_player,false);
			if (seta.x == 130 && seta.y == 345)
				FP.world = new Map("floresta",_player,false);
			if (seta.x == 482 && seta.y == 278)
				FP.world = new Map("caverna",_player,false);
			if (seta.x == 66 && seta.y == 180)
				FP.world = new Map("vila_abandonada", _player, false);
			if (seta.x == 258 && seta.y == 150){
				if (Main.stairwaySummoned)
					FP.world = new Map("volcano2", _player, false);
				else
					FP.world = new Map("volcano", _player, false);
			}
		}
		
		public function backToMap():void{
			if (theme != null)
				theme.stop();
			
			FP.world = new Map("mapa",_player,false);
		}
		
		public function animWhenHaveThreePendants():void {
			countAnimPendants++;
			
			_player.active = false;
			
			if (countAnimPendants == 100) {
				_player.sprSwordguy.play("win");
			}
			if (countAnimPendants == 150) {
				pendant = new Pendant(Main.arrayOfLevelCompleted[0]);
				pendant.x = 300;
				pendant.y = 200;
				add(pendant);
			}
			if (countAnimPendants == 160) {
				pendant = new Pendant(Main.arrayOfLevelCompleted[1]);
				pendant.x = 300;
				pendant.y = 200;
				add(pendant);
			}
			if (countAnimPendants == 170) {
				pendant = new Pendant(Main.arrayOfLevelCompleted[2]);
				pendant.x = 300;
				pendant.y = 200;
				add(pendant);
			}
			
			if (countAnimPendants > 170 && pendant.animComplete) { //countAnimPendants > 170
				if (countGeneralExplode < 30)
					countExplode++;
				if (countGeneralExplode == 30) {										
					stairway.visible = true;
					//Main.stairwaySummoned = true;
					countGeneralExplode++;
				}

				if (countExplode > 10)
				{
					generateExplode();
					countExplode = 0;
					countGeneralExplode++;
				}
			}
			
			if (countGeneralExplode == 31) {
				if (_player.x < 660) {					
					_player.sprSwordguy.play("run");
					_player.x += _player.speed;
				}
				else {					
					//ir para fase do Vulcao
					FP.world = new Map("volcano2",_player,false);
					Main.stairwaySummoned = true;
				}
				
				
				if (_player.x > 448)
					_player.y++;				
			}
			
		}
		
		public function generateExplode():void
		{			
			explode(pendant.x + 90,pendant.y - 140);
			explode(pendant.x + 20,pendant.y - 100);
			explode(pendant.x + 70,pendant.y - 60);
			explode(pendant.x + 70,pendant.y - 100);
			explode(pendant.x + 10,pendant.y - 50);
			explode(pendant.x + 40,pendant.y - 150);
			explode(pendant.x + 5 ,pendant.y - 130);
			explode(pendant.x     ,pendant.y - 100);
			explode(pendant.x + 110,pendant.y - 100);
		}
		
		public function explode(_x:int,_y:int):void {
			var explod:Explosion = new Explosion();
			explod.x = _x - 50;
			explod.y = _y + 50;
			FP.world.add(explod);
		}
		
		public function Pause():void{			
			if (!pause) {				
				backgroundPause = new BlackScreen();
				backgroundPause.x = FP.camera.x;
				backgroundPause.y = 0;
				backgroundPause.spr.scaleX = 10;
				backgroundPause.spr.scaleY = 10;
				backgroundPause.spr.alpha = 0.5;
				add(backgroundPause);				
				
				pauseText = new Entity();
				pauseText.graphic = new Text("-- Pause --");
				pauseText.x = FP.camera.x + 250;
				pauseText.y = 240;
				add(pauseText);
				
				if (FP.volume != 0)
					FP.volume = 0.5;
			}
			else {
				remove(backgroundPause);
				remove(pauseText);
				
				if (FP.volume == 0.5)
					FP.volume = 1;
			}
		}	
		
	}
}
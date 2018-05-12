package player
{
	import anim.GameOver;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;	
	
	public class Player extends Entity{		
		[Embed(source = '../gfx/swordguy.png')] private const SWORDGUY:Class;
		[Embed(source = '../gfx/swordguy_inWater.png')] private const SWORDGUY_INWATER:Class;
		[Embed(source = '../gfx/swordguy_small.png')] private const SWORDGUY_SMALL:Class;
		
		[Embed(source = '../snd/sword.mp3')] private const SWORD:Class;
		[Embed(source = '../snd/playerHurt.mp3')] private const HURT:Class;
		
		private const TIME_TO_ATTACK:int = 10;
		private const TIME_TO_BLINK:int = 60;
		private const KNOCK:int = 10;
		
		public var sprSwordguy:Spritemap;
		public var sfxSword:Sfx = new Sfx(SWORD);
		public var sfxHurt:Sfx = new Sfx(HURT);

		public var speed:int = 3;		
		public var life:Array = new Array(); 
		public var lifeMax:int = 5; //5
		public var currentLife:int = lifeMax;
		
		public var walking:Boolean = false;
		public var attack:Boolean = false;
		
		public var blink:Boolean = false;
		public var blinkCount:int = 0;
		public var receivedAttackCount:int = 0;
		
		public var score:Score = new Score();
		public var avatar:Avatar = new Avatar();
		public var lives:Lives = new Lives(avatar);
		public var map:Map;
		
		private var isControllable:Boolean = false;
		private var decresceTimeToAttack:int = 1;
		private var timeToAttack:int = 0;
		private var isActive:Boolean = true;
		
		private var dead:Boolean = false;

		public function Player(_type:String,_map:Map)
		{			
			map = _map;
			
			type = _type;
			
			if (type == "player")
			{				
				if (map != null) {
					if (map.destino == "vila_abandonada" && map.isBossLevel)
						sprSwordguy = new Spritemap(SWORDGUY_INWATER, 62, 37);
					else
						sprSwordguy = new Spritemap(SWORDGUY, 62, 37);
				}
				else {
					sprSwordguy = new Spritemap(SWORDGUY, 62, 37);
				}
				
				sprSwordguy.add("stand", [0, 1, 2], 10, true);
				sprSwordguy.add("run", [3, 4, 5], 10, true);
				sprSwordguy.add("attack1", [6, 7, 8], 10, false);
				sprSwordguy.add("attack2", [9, 10, 11], 10, false);
				sprSwordguy.add("attack3", [12, 13, 14], 10, false);
				sprSwordguy.add("receivedAttack",[15,16,17],10,false);
				sprSwordguy.add("dead", [18, 19, 20], 7, false);
				sprSwordguy.add("win", [21, 22, 23], 7, false);
				
				graphic = sprSwordguy;
				
				sprSwordguy.scale = 1.3;
			}			
			else
			{
				sprSwordguy  = new Spritemap(SWORDGUY_SMALL, 32, 32);
				
				sprSwordguy.add("front", [0,1], 5, true);
				sprSwordguy.add("side", [2,3], 5, true);
				sprSwordguy.add("up", [4,5], 5, true);
				
				graphic = sprSwordguy;
				
				sprSwordguy.play("front");
			}
			
			sfxSword.volume = 0.3;
		}
		
		override public function update():void
		{			
			if (this.type == "player" || this.type == "player_water")
			{
				if (isControllable)
					playerUpdates();
			}
			/*else
				input3();
			*/
			
			super.update();
		}
		
		public function playerUpdates():void
		{
			if (!dead){
				input();
				/*if (map.isScrolling)
					input();
				else
					input2();*/
			}
			else if (!isBlink())
				checkIfRessurect();
			
			SetHitbox();
			
			if (!attack){
				defineAnimation();
				
				if (Input.check(Key.A) && timeToAttack == 0 && !dead && map.destino != "aldeia") {
					playerAttack();
				}
				
				if (timeToAttack > 0)
					timeToAttack--;
			}
			else{				
				if (sprSwordguy.index == sprSwordguy.columns-1)				
					attack = false;
			}

			if (isBlink()) 
				toBlink();
			
			if (receivedAttackCount > 0){
				receivedAttackCount++;
				
				if (receivedAttackCount > 20)
					receivedAttackCount = 0;
			}			
		}
		
		/*
		//
		//
		*/
		
		public function checkIfRessurect():void{
			if (lives.livesNum > 0){
				lives.livesNum--;				
				dead = false;
				blink = true;
				
				currentLife = lifeMax;
				map.updateLife();
			}
			else {
				this.active = false;
				FP.world.add(new GameOver());
			}
		}
		
		public function SetHitbox():void{
			if (sprSwordguy.flipped){
				if (attack)
					setHitbox(85,32,0,0);
				else
					setHitbox(32,32,-20,0);
			}
			else{
				if (attack)
					setHitbox(85,32,0,0);
				else
					setHitbox(32,32,0,0);
			}
		}
		
		public function defineAnimation():void{
			if (receivedAttackCount > 0)
				sprSwordguy.play("receivedAttack");
			else{
				if (dead)
					sprSwordguy.play("dead");
				else{
					if (walking) 
						sprSwordguy.play("run");
					else					
						sprSwordguy.play("stand");
				}
			}
		}
		
		public function playerAttack():void{
			var randAttack = Math.round(Math.random()*2)+1;
			sprSwordguy.play("attack"+randAttack);	
			attack = true;
			sfxSword.play();
			timeToAttack = TIME_TO_ATTACK;
		}
		
		public function toBlink():void
		{
			if (blinkCount == TIME_TO_BLINK){
				blink = false;
				blinkCount = 0;
			}
			else blinkCount++;
			
			if (blinkCount % 2 == 0) this.visible = true;
			else this.visible = false;
		}
		
		public function receivedDamage():void{			
			receivedAttackCount++;
			currentLife--;
			map.updateLife();
			this.blink = true;
			sfxHurt.play();
			
			if (currentLife <= 0){
				dead=true;
				setHitbox(0,0);
			}
				
		}	
		
		public function input():void{
			if (Input.check(Key.RIGHT) && this.x < (FP.camera.x + 600))
			{
				if (sprSwordguy.flipped)
					this.x += 30;
				
				sprSwordguy.flipped = false;
				this.x += speed;
				walking=true;
			}
			else if (Input.check(Key.LEFT) && this.x-20 >= FP.camera.x)
			{
				if (!sprSwordguy.flipped)
					this.x -= 30;
				
				sprSwordguy.flipped = true;
				this.x -= speed;
				walking=true;
			}
			else walking=false;
			
			if (Input.check(Key.UP) && !collide("level",x,y - speed))
			{
				this.y -= speed;
				walking=true;
			}
			else if (Input.check(Key.DOWN) && (y + speed) < 430)
			{
				this.y += speed;
				walking=true;
			}
		}
		
		public function input2():void{
			if (Input.check(Key.RIGHT) && this.x < (FP.camera.x + 640) && !collide("level",x - speed,y)) // && dontWalkInLava()
			{
				if (sprSwordguy.flipped)
					this.x += 30;
				
				sprSwordguy.flipped = false;
				this.x += speed;
				walking=true;
			}
			else if (Input.check(Key.LEFT))
			{
				if (!sprSwordguy.flipped)
					this.x -= 30;
				
				sprSwordguy.flipped = true;
				this.x -= speed;
				walking=true;
			}
			else walking=false;
			
			if (Input.check(Key.UP) && !collide("level",x,y - speed))
			{
				this.y -= speed;
				walking=true;
			}
			else if (Input.check(Key.DOWN) && (y + speed) < 430)
			{
				this.y += speed;
				walking=true;
			}
		}
		
		/*public function input3():void{
			if (Input.check(Key.RIGHT) && !collide("level",x + speed,y)){
				sprSwordguy.flipped = true;
				this.x += speed;
				sprSwordguy.play("side");
			}
			else if (Input.check(Key.LEFT) && !collide("level",x - speed,y)){
				sprSwordguy.flipped = false;
				this.x -= speed;
				sprSwordguy.play("side");
			}
			
			if (Input.check(Key.UP) && !collide("level",x,y - speed)){
				this.y -= speed;
				sprSwordguy.play("up");
			}
			else if (Input.check(Key.DOWN) && !collide("level",x,y + speed)){
				this.y += speed;
				sprSwordguy.play("front");
			}
			
			if (Input.check(Key.A)) {
				Input.clear();
				trace(this.x+" "+this.y);
			}
		}*/
		
		public function getIsActive()
		{
			return true;
		}
		
		public function setIsActive(info:Boolean)
		{
			isActive = info;
		}
		
		public function getControllable():Boolean
		{
			return isControllable;
		}
		
		public function setControllable(ctr:Boolean):void
		{
			isControllable = ctr;
		}
		
		public function setCurrentLife(value:int):void
		{
			currentLife = value;
		}
		
		public function setLifeMax(value:int):void
		{
			lifeMax = value;
		}
		
		public function isBlink():Boolean{
			return this.blink;
		}
		
		public function isDead():Boolean{
			return dead;
		}
		
		public function dontWalkInLava():Boolean {
			if (map.destino == "volcano" && !Main.stairwaySummoned && this.x < 395)
				return true;
			else
				return false;
		}
		
	}//end of class
}//end of package
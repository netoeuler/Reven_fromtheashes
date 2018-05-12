package {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	
	public class Menu_Options extends Entity{
		
		private var txt_left:Text;
		private var txt_right:Text;
		private var txt_right_array:Array;
		
		private var entity:Entity;
		private var entityLeft:Entity;
		private var entityRight:Entity;
		
		private var rightLife:int = 3;
		private var rightContinues:int = 3;
		private var rightSound:Array = new Array("on", "off");
		
		private var iSound:int = 0;
		
		public function Menu_Options():void {
			/*generateTxt();
			
			txt_left.x = 250;
			txt_left.y = 270;
			
			txt_right.x = txt_left.x + 150;
			txt_right.y = txt_left.y;
			
			entityLeft = new Entity();
			entityLeft.graphic = txt_left;
			FP.world.add(entityLeft);
			
			entityRight = new Entity();
			entityRight.graphic = txt_right;
			FP.world.add(entityRight);*/
			generateArraysTxt();
		}
		
		/*
		override public function update():void {			
			
			super.update();
		}
		*/
		
		private function generateTxt():void {
			var txtleft = 	"Life: \n\n" +
							"Continues: \n\n" +
							"Sound: \n\n" +
							"Back to Menu";
			
			var txtright = rightLife.toString() + "\n\n" +
					       rightContinues.toString() + "\n\n" +
						   rightSound[iSound].toString() + "\n\n";
						
			txt_left = new Text(txtleft);
			txt_right = new Text(txtright);
		}
		
		private function generateArraysTxt():void {
			var ix:int = 250;
			var iy:int = 270;
			var entityText:Entity;
			
			txt_right_array = new Array();
			
			//[0]
			txt_right_array.push(new Array());
			entityText = createText("Life: ", ix, iy);
			txt_right_array[0].push(entityText);
			entityText = createText( rightLife+"", ix + 150, iy );
			txt_right_array[0].push(entityText);
			
			//[1]
			txt_right_array.push(new Array());
			entityText = createText("Continues: ", ix, iy + 30);
			txt_right_array[1].push(entityText);
			entityText = createText( rightContinues+"", ix + 150, iy + 30 );
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
			
			/*
			txt_right_array = [
				[entityText = createText("Life: ",ix,iy), 			entityText = createText( rightLife.toString(),ix+20,iy )],
				[entityText = createText("Continues: ",ix,iy+20), 	entityText = createText( rightContinues.toString(),ix+20,iy+20 )],
				[entityText = createText("Sound: ",ix,iy+40), 		entityText = createText( rightSound[iSound].toString(),ix+20,iy+40 )]
			]
			*/					
			
			for (var i in txt_right_array) {
				for (var j in txt_right_array[i]) {
					FP.world.add(txt_right_array[i][j]);
				}
			}
			//return txt_right_array;			
		}		
		
		private function createText(text:String,ix:int,iy:int):Entity {
			var e:Entity = new Entity;
			e.graphic = new Text(text, ix, iy);
			
			return e;
		}
		
		public function removeEntities():void {
			FP.world.remove(entityLeft);
			FP.world.remove(entityRight);
		}
	}
}
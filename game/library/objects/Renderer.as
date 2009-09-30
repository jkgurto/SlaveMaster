package game.library.objects {
	import flash.display.*;
	import flash.events.*;
	//import library.objects.*;
	
	public class Renderer extends flash.display.MovieClip {
		// ------- Properties -------
		//var sky;
		var sun;
		var boat;
		var seasky;
		
		public function Renderer() {
			
			this.width = 800;
			this.height = 600;
			this.x = 0;
			this.y = 0;
			
			//create background and boat
			//sky = new Sky();
			seasky = new Seasky();
			sun = new Sun();
			boat = new Boat();
			seasky.x = 0;
			seasky.y = 0;
			seasky.width = 800;
			seasky.height = 600;
			sun.x = 650;
			sun.y = -80;
			boat.y = this.height - boat.height + 2;
			this.addChild(seasky);
			this.addChild(sun);
			this.addChild(boat);
		}
     
	}
}
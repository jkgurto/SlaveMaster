package game.library.objects {
	import flash.display.*;
	import flash.events.*;
	//import library.objects.*;
	
	public class Renderer extends flash.display.MovieClip {
		// ------- Properties -------
		var sky;
		var sun;
		var boat;
		
		public function Renderer() {
			
			this.width = 800;
			this.height = 600;
			this.x = 0;
			this.y = 0;
			
			//create background and boat
			sky = new Sky();
			sun = new Sun();
			boat = new Boat();
			sky.x = 0;
			sky.y = 0;
			sky.width = 800;
			sky.height = 600;
			sun.x = 650;
			sun.y = -80;
			boat.y = this.height - boat.height + 2;
			this.addChild(sky);
			this.addChild(sun);
			this.addChild(boat);
		}
     
	}
}
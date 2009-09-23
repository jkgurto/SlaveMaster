package game.library.objects {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	//import library.objects.*;
	
	public class Hands extends flash.display.MovieClip {
		
		//properties
		private var delay:int;
		
		public function Hands() {
			delay = 5; //default 5ms
		}
		
		public function setSpeed(speed:int) {
			this.delay = speed;
		}
	}
}
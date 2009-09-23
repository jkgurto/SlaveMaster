package library.objects {
	import flash.display.*;
	import flash.events.*;
	//import library.objects.*;
	
	public class Drum extends flash.display.MovieClip {
		
		private var bpm:int; //maximum bpm is 24x60 since we can only have max 24 actions per second.
		private var counter:int;
		
		public function Drum() {
			
		}
		
		/*
			hit a beat on the drum, record beats within the object and link to timer
		*/
		public function doBeat(time:int):void {
			//TODO
			trace(time);			
		}
		
		public function getBPM():int {
			return 100;
		}
		
	}
}
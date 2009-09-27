package library.objects {
	import flash.display.*;
	import flash.events.*;
	//import library.objects.*;
	
	public class Difficulty {
		
		
		/*
			Current plan is to get level difficulties from an XML file, however people can cheat and make levels easier
			Other solution is to hardcode a table in this class that stores all the data required in terms of difficulty per level
			
		*/
		
		
		public function Difficulty(initialLevel:int = 1) {
			
		}
		
		public function setLevel(myLevel:int) {
			
		}
		
		public function getLevel():int {
			return 0;
		}
		
		public function getNumSlaves():int {
			return 5;
		}
		
		//get total distance to finish level
		public function getDistance():int {
			return 0;
		}
		
		//returns total time allocated for level in seconds
		public function getTimeLimit():int {
			return 180;
		}
		
		/* optional implementation
		public function getNumObstacles():int {
			
		}
		*/
		
	}
}
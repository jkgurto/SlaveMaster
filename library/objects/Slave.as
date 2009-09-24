package library.objects {
    
	//import flash.display.*;
	//import flash.events.*;
	//import library.objects.*;
	
	//import mx.core.SpriteAsset;
	
	import assets.Assets_slaveClass;
	
	public class Slave extends assets.Assets_slaveClass {
	    
	    // ------- Properties -------
	    
	    // Counts the number of slaves created.
	    private static var slaveCount:uint = 0;
	    
		
		private var _id:uint;
      	
      	// type descriptor of slave
		private var _type:String;
		
		// number of times whipped
		private var _numWhips:int;
		
		// maximum number of whips
		private var _maxWhips:int;
		
		// thirst as a percentage
		private var _thirst:int;
		
		// percentage
		private var _morale:int;
		
		// enum for emotion
		private var _emotion:String;
		
		//a ll factors considered what is the slaves output(contribution)
		private var _output:int;
			  
		// constructor
		public function Slave() {
		    ++slaveCount;
		    
		    _id = slaveCount;
		    
		    // name is inherited from sprite
		    name = "Default slave";
		}
		
		public function get id():uint {
		    return _id;
		}
		
		public function get type():String {
			return _type;
		}
		
		public function get numWhips():int {
			return _numWhips;
		}
		
		public function set numWhips(myNumWhips:int):void {
			_numWhips = myNumWhips;
		}
		
		public function get maxWhips():int {
			return _maxWhips;
		}
		
		public function get thirst():int {
			return _thirst;
		}
		
		public function get morale():int {
			return _morale;
		}
		
		public function set morale(myMorale:int):void {
			_morale = myMorale;
		}
		
		public function get emotion():String {
			return _emotion;
		}
		
		public function set emotion(myEmotion:String):void {
			_emotion = myEmotion;
		}
		
		public function get output():int {
			return _output;
		}
		
		public function set output(myOutput:int):void {
			_output = myOutput;
		}
		
		/*
			remove thirst by supplied amount
			(slave automatically gets thirsty on its own)
		*/
		public function recoverThirst(myThirst:int):void {
			//TODO
			return;
		}
	}
}
package game.library.objects {
	
	import assets.Assets_slaveClass;
	
	public class Slave extends assets.Assets_slaveClass {
	    
	    // ------- Properties -------
	    
	    // Counts the number of slaves created.
	    private static var slaveCount:uint = 0;
	    
		
		private var _id:uint;
		private var _type:String;    // type descriptor of slave
		private var _numWhips:int;   // number of times whipped
		private var _maxWhips:int;   // maximum number of whips
		private var _thirst:int;     // thirst as a percentage
		private var _morale:int;     // percentage
		private var _emotion:String; // enum for emotion
		private var _output:int;     // all factors considered what is the 
		                             // slaves output(contribution)
		private var _speed:int;       //in milliseconds per frame
		private var myHands:Hands;
			  
		// constructor
		public function Slave() {
		    ++slaveCount;
		    
		    _id = slaveCount;
		    
		    // name is inherited from sprite
		    // position is also inherited
		    name = "Default slave";
		    
		    myHands = new Hands();
			myHands.x = -68.3;
			myHands.y = -17.3;
			myHands.scaleX = 0.436;
			myHands.scaleY = 0.489;
			myHands.rotation = 8.5;
			this.addChild(myHands);
			this.setChildIndex(myHands, 0);
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
		
		public function get speed():int {
			return _speed;
		}
		
		public function set speed(mySpeed:int):void {
			_speed = mySpeed;
			myHands.speed = this.speed;
		}
		
		public function recoverThirst(myThirst:int):void {
			return;
		}
		
		public function doWhip():void {
			trace("ouch! i got whipped...");
		}
	}
}

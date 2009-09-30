package game.library.objects {
	
	import assets.Assets;
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.controls.ProgressBar;
	
	import mx.core.Application;
	
	public class Slave extends Sprite {
	    
	    // ------- Properties -------
	    public static const SLAVE_SCALE:Number = 0.8;
	    
	    public static const DEFAULT_MAX_WHIPS:int = 10;
	    public static const DEFAULT_PROGRESS_WIDTH:int = 50;
	    
	    public static const MIN_OUTPUT:Number = 1;
	    public static const MAX_OUTPUT:Number = 20;
	    public static const OUTPUT_DECREASE:Number = 1;
	    
	    
	    // Counts the number of slaves created.
	    private static var slaveCount:uint = 0;
		
		private var _id:uint;
		private var _type:String;    // type descriptor of slave
		
		// number of times whipped
		private var _numWhips:int = DEFAULT_MAX_WHIPS;
		// maximum number of whips
		private var _maxWhips:int = DEFAULT_MAX_WHIPS;
		
		private var _thirst:int;     // thirst as a percentage
		private var _morale:int;     // percentage
		private var _emotion:String; // enum for emotion
		private var _output:Number;  // all factors considered what is the 
		                             // slaves output(contribution)
		private var _speed:int;      //in milliseconds per frame
		private var myHands:Hands;
		
		private var _progress:ProgressBar;
		
		// Slave Image
		private var slaveImage:Sprite
		    = new assets.Assets_slaveClass();
		    
		private var slaveRowImage:Sprite
		    = new assets.Assets_slaveRowingClass();
			  
		// constructor
		public function Slave() {
		    ++slaveCount;
		    
		    _id = slaveCount;
		    
		    // name is inherited from sprite
		    // position is also inherited
		    name = "Default slave";
		    
		    // Images
		    slaveImage.scaleX = SLAVE_SCALE;
		    slaveImage.scaleY = SLAVE_SCALE;
		    
		    slaveRowImage.scaleX = SLAVE_SCALE;
		    slaveRowImage.scaleY = SLAVE_SCALE;
		    
		    this.addChild(slaveImage);
		    
		    // Output
		    _output = MIN_OUTPUT;
		    
		    // Hands
		    myHands = new Hands();
			myHands.x = -68.3;
			myHands.y = -17.3;
			myHands.scaleX = 0.436;
			myHands.scaleY = 0.489;
			myHands.rotation = 8.5;
			this.addChild(myHands);
			this.setChildIndex(myHands, 0);
			
			// Health bar
			_progress = new ProgressBar();
			_progress.visible = true;
			_progress.label = "";
			_progress.direction = "right";
			_progress.mode = "manual";
			
            _progress.width = DEFAULT_PROGRESS_WIDTH;
            _progress.x = this.x;
            _progress.y = this.y;
            
            _progress.minimum = 0;
            //progress.maximum = _maxWhips;
            _progress.setProgress( (_maxWhips - _numWhips), _maxWhips );
		}
		
		public function update(frameRate:Number):void {
		    
		    // Decrease rowing output with time to a minimum
		    if (_output > MIN_OUTPUT) {
		        _output -= (OUTPUT_DECREASE / frameRate);
		        //trace(name + " output: " + _output + " / " + MAX_OUTPUT);
		    }
		}
		
		public function doWhip():void {
		    
		    // Set health
		    --_numWhips;
		    
		    // Set health bar
		    _progress.setProgress( (_maxWhips - _numWhips), _maxWhips );
		    
		    // Set rowing output
		    _output = MAX_OUTPUT;
		    
			trace(name + " health: " + _numWhips + " / " + _maxWhips);
			trace(name + " output: " + _output + " / " + MAX_OUTPUT);
		}
		
		public function startRow():void {
		    
		    // Set rowing image
		    this.removeChild(slaveImage);
		    this.addChild(slaveRowImage);
        }
        
        public function stopRow():void {
		    
		    // Set rowing image
		    this.removeChild(slaveRowImage);
		    this.addChild(slaveImage);
        }
		
		public function isDead():Boolean {
		    
		    if (_numWhips <= 0) {
		        return true;
		    }
		    return false;
		}
		
		override public function set x(value:Number):void {
		    super.x = value;
		    _progress.x = value;
		}
		
		override public function set y(value:Number):void {
		    super.y = value;
		    _progress.y = value;
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
		
		public function get output():Number {
			return _output;
		}
		
		public function set output(myOutput:Number):void {
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
		
		public function get progress():ProgressBar {
			return _progress;
		}
	}
}

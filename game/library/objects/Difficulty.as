package game.library.objects {
	
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.utils.Timer;
    
    import game.library.objects.Boat;
    
    import mx.core.Application;
	
	/**
	 * Current plan is to get level difficulties from an XML file, however
	 * people can cheat and make levels easier
	 * Other solution is to hardcode a table in this class that stores all the
	 * data required in terms of difficulty per level
	 */
	public class Difficulty {
		
		public const MAX_TIME:int = 180;       // Ticks
		public const TICK_INTERVAL:int = 1000; // Seconds
		
		public const MAX_SLAVES:int = 4;
		public const MAX_DISTANCE:int = 1000;
		
		public const TEXT_SPACER:int = 20;
		
		private var _distanceLeftText:TextField = null;
		
		private var _timeLeftText:TextField = null;
        private var _timer:Timer = null;
        
        private var _level:int;
        private var _numSlaves:int;
        private var _distance:int;
		
		private var boat:Boat;
		
		public function Difficulty(myBoat:Boat, initialLevel:int = 1) {
		    
		    boat = myBoat;
		    _level = initialLevel;
		    _numSlaves = MAX_SLAVES;
		    _distance = MAX_DISTANCE;
		    
		    // -- Format
		    var format:TextFormat = new TextFormat();
            format.color = 0xFF0000;
            format.size = 24;
		    
		    // -- Distance
            _distanceLeftText = new TextField();
            _distanceLeftText.autoSize = TextFieldAutoSize.CENTER;
            _distanceLeftText.defaultTextFormat = format;
            _distanceLeftText.text = "Distance: " + _distance;
            
            // Top left of screen
            _distanceLeftText.x =
                Application.application.width
                - (_distanceLeftText.width + TEXT_SPACER);
                
            _distanceLeftText.y = TEXT_SPACER;
			
			// -- Timer
            _timeLeftText = new TextField();
            _timeLeftText.autoSize = TextFieldAutoSize.CENTER;
            _timeLeftText.defaultTextFormat = format;
            _timeLeftText.text = "Time: " + MAX_TIME;
            
            _timer = new Timer(TICK_INTERVAL, MAX_TIME);
            _timer.addEventListener(TimerEvent.TIMER, onTick);
            _timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
            
            // Top left of screen
            // Under distance
            _timeLeftText.x =
                Application.application.width
                - (_timeLeftText.width + TEXT_SPACER);
                
            _timeLeftText.y = _distanceLeftText.height + (TEXT_SPACER * 2);
		}
		
		public function get level():int {
			return _level;
		}
		
		public function set level(value:int):void {
			_level = value;
		}
		
		public function get numSlaves():int {
			return _numSlaves;
		}
		
		public function get distance():int {
			return _distance;
		}
		
		public function set distance(value:int):void {
			_distance = value;
			_distanceLeftText.text = "Distance: " + _distance;
		}
		
		/* optional implementation
		public function getNumObstacles():int {
			
		}
		*/
		
		public function get distanceLeftText():TextField {
		    return _distanceLeftText;
		}
		
		public function get timeLeftText():TextField {
		    return _timeLeftText;
		}
		
		public function get timer():Timer {
		    return _timer;
		}
		
		private function onTick(event:TimerEvent):void 
        {
            // -- Timer
            // Count down, not up
            _timeLeftText.text =
                "Time: " + (MAX_TIME - event.target.currentCount);
            
            /*
            // -- Distance
            _distance -= boat.speed;
            _distanceLeftText.text = "Distance: " + _distance;
            
            // Distance finished
            if (_distance <= 0) {
                Application.application.setCurrentState("GameOverState");
            }
            */
        }
        
        private function onTimerComplete(event:TimerEvent):void
        {
            // Timer finished
            //timeLeftText.text = "Time's Up!";
            Application.application.setCurrentState("GameOverState");
        }
		
	}
}
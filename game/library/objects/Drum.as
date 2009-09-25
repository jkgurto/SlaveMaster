package game.library.objects {
    
    import assets.Assets_drumClass;
    import assets.Assets_drumSoundClass;
	
	public class Drum extends assets.Assets_drumClass {
	    
	    public static var sound:assets.Assets_drumSoundClass =
	        new assets.Assets_drumSoundClass();
	    
	    public static const MAX_CORRECT:Number = 100;
	    public static const MIN_CORRECT:Number = 0;
	    public static const CORRECT_DECREASE_RATE:Number = 1;
	    public static const GOOD_BONUS:Number = 20;
		
		// maximum bpm is 24x60 since we can only have max 24
		// actions per second.
		private var bpm:int;
		private var counter:int;
		
		// Player hits drum with hands, left, right, left, right etc.
		private var firstBeat:Boolean = true;
		private var good:Boolean = false;
		private var leftLastBeat:Boolean = false;
		
		// Measure of how evenly the player is beating the drum
		// Low = bad, High = good
		private var correctness:Number = MIN_CORRECT;
		
		/**
		 * TODO Timing stuff
		 * Needs some tweaking.
		 */
		public function Drum() {
			
		}
		
		public function update(frameRate:Number):void {
		    
		    // Decrease
		    correctness -= (CORRECT_DECREASE_RATE / frameRate);
		    
		    // Clamp
		    if (correctness < MIN_CORRECT) {
		        correctness = MIN_CORRECT;
		    }
		    
		    //trace("correctness: " + correctness);
		}
		
		public function doLeftBeat():void {
			
			// First beat always good
			if (firstBeat) {
			    firstBeat = false;
			    correctness += GOOD_BONUS;
			    
			    // Clamp
			    if (correctness > MAX_CORRECT) {
    		        correctness = MAX_CORRECT;
    		    }
    		    
    		    // Play sound
    		    sound.play();
			}
			
			// Right last beat
			else if (!leftLastBeat) {
			    correctness += GOOD_BONUS;
			    
			    // Clamp
			    if (correctness > MAX_CORRECT) {
    		        correctness = MAX_CORRECT;
    		    }
    		    
    		    // Play sound
    		    sound.play();
			}
			
			// Left last beat
			// Bad
			
			leftLastBeat = true;
		}
		
		public function doRightBeat():void {
			
			// First beat always good
			if (firstBeat) {
			    firstBeat = false;
			    correctness += GOOD_BONUS;
			    
			    // Clamp
			    if (correctness > MAX_CORRECT) {
    		        correctness = MAX_CORRECT;
    		    }
    		    
    		    // Play sound
    		    sound.play();
			}
			
			// Left last beat
			else if (leftLastBeat) {
			    correctness += GOOD_BONUS;
			    
			    // Clamp
			    if (correctness > MAX_CORRECT) {
    		        correctness = MAX_CORRECT;
    		    }
    		    
    		    // Play sound
    		    sound.play();
			}
			
			// Right last beat
			// Bad
			
			leftLastBeat = false;		
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
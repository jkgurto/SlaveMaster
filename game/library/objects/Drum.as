﻿package game.library.objects {
    
    import assets.Assets;
    
    import flash.display.Sprite;
    import flash.events.TimerEvent;
    import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.utils.Timer;
	
	public class Drum extends Sprite implements Pauseable {
	    
	    public static var sound:assets.Assets_drumSoundClass =
	        new assets.Assets_drumSoundClass();
	        
	    public static const DRUM_SCALE:Number = 0.5;
	        
	    // Time until next row
	    public static const MIN_ROW_INTERVAL_S:Number = 0.5;
	    public static const MAX_ROW_INTERVAL_S:Number = 3;
	    
	    public static const ROW_DECREASE_S:Number = 1;
	    public static const ROW_INCREASE_S:Number = 0.5;
	    
	    // Time of row
	    public static const ROW_TIME_S:Number = 1;
		
		// Player hits drum with hands, left, right, left, right etc.
		private var firstBeat:Boolean = true;
		private var good:Boolean = false;
		private var leftLastBeat:Boolean = false;
		
		// Interval gets smaller as the player gets more correct beats
		private var rowIntervalS:Number = MAX_ROW_INTERVAL_S;
		
		// Currently does not change
		private var _rowTimeS:Number = ROW_TIME_S;
		
		// Times 2 things alternating
		// 1. The time until the next row.
		// 2. The time until this row ends.
		private var _rowTimer:Timer = new Timer(MAX_ROW_INTERVAL_S * 1000, 1);
		
		// Used to start and stop slave animations
		private var _startRow:Boolean = false;
		private var _stopRow:Boolean = false;
		
		// Used to tell if the _rowTimer is counting down the time to the
		// next row or the time until the row ends.
		private var _rowing:Boolean = false;
		
		// Used to pause the timer
		private var paused:Boolean = false;
		
		private var _beatText:TextField = null;
		
		// Drum image
		private var drumImage:Sprite = new assets.Assets_drumClass();
		
		/**
		 * TODO Timing stuff
		 * Needs some tweaking.
		 */
		public function Drum() {
		    
		    drumImage.scaleX = DRUM_SCALE;
		    drumImage.scaleY = DRUM_SCALE;
		    
			this.addChild(drumImage);
			
			// -- Timer
			_rowTimer.addEventListener(TimerEvent.TIMER, onTimerComplete);
			_rowTimer.start();
			
			// -- Format
		    var format:TextFormat = new TextFormat();
            format.color = 0xFF0000;
            format.size = 24;
			
			// -- Beat
            _beatText = new TextField();
            _beatText.autoSize = TextFieldAutoSize.CENTER;
            _beatText.defaultTextFormat = format;
            _beatText.text = "Left";
            
            _beatText.visible = false;
            
            // Over top of drum
            _beatText.x = this.x;
            _beatText.y = this.y - (_beatText.height + 20);
		}
		
		/**
		 * Can't set the text as a child because it appears underneath.
		 */
		override public function set x(value:Number):void {
		    super.x = value;
		    _beatText.x = value;
		}
		
		override public function set y(value:Number):void {
		    super.y = value;
		    _beatText.y = value - (_beatText.height + 20);
		}
		
		public function update(frameRate:Number):void {
		    
		    //increaseRowInterval(frameRate);
		}
		
		// TODO increment time when wrong
		public function doLeftBeat():void {
			
			// Only hit drum when it indicates to
			if (_beatText.visible) {
			    
    			// First beat always good
    			if (firstBeat) {
    			    firstBeat = false;
    			    
    			    // Make time until next row shorter
    			    decreaseRowInterval();
        		    
        		    // Play sound
        		    sound.play();
    			}
    			
    			// Right last beat
    			else if (!leftLastBeat) {
    			    
    			    // Make time until next row shorter
    			    decreaseRowInterval();
        		    
        		    // Play sound
        		    sound.play();
    			}
    			
    			// Left last beat
    			// Bad
    			
    			leftLastBeat = true;
    			_beatText.visible = false;
    			_beatText.text = "Right";
			}
		}
		
		public function doRightBeat():void {
			
			// Only hit drum when it indicates to
			if (_beatText.visible) {
    			// First beat always good
    			if (firstBeat) {
    			    firstBeat = false;
    			    
    			    // Make time until next row shorter
    			    decreaseRowInterval();
        		    
        		    // Play sound
        		    sound.play();
    			}
    			
    			// Left last beat
    			else if (leftLastBeat) {
    			    
    			    // Make time until next row shorter
    			    decreaseRowInterval();
        		    
        		    // Play sound
        		    sound.play();
    			}
    			
    			// Right last beat
    			// Bad
    			
    			leftLastBeat = false;
    			_beatText.visible = false;
    			_beatText.text = "Left";
			}	
		}
		
		private function decreaseRowInterval():void {
		    rowIntervalS -= ROW_DECREASE_S;
		    
		    // Clamp to minimum value
		    if (rowIntervalS < MIN_ROW_INTERVAL_S) {
		        rowIntervalS = MIN_ROW_INTERVAL_S;
		    }
		    
		    // Timer interval is updated next row
		    
		    //trace("dec rowInterval " + rowIntervalS);
		}
		
		private function increaseRowInterval(frameRate:Number):void {
		    rowIntervalS += (ROW_INCREASE_S / frameRate);
		    
		    // Clamp to minimum value
		    if (rowIntervalS > MAX_ROW_INTERVAL_S) {
		        rowIntervalS = MAX_ROW_INTERVAL_S;
		    }
		    
		    // Timer interval is updated next row
		    
		    //trace("inc rowInterval " + rowIntervalS);
		}
		
		public function get beatText():TextField {
		    return _beatText;
		}
		
		/**
		 * Check if slaves have just started to row.
		 */
		public function get startRow():Boolean {
		    return _startRow;
		}
		
		/**
		 * Set if slaves have just started to row.
		 * startRow should be set to false after the slaves have been updated.
		 */
		public function set startRow(value:Boolean):void {
		    _startRow = value;
		}
		
		/**
		 * Check if slaves have just stopped a row.
		 */
		public function get stopRow():Boolean {
		    return _stopRow;
		}
		
		/**
		 * Set if slaves have just stopped a row.
		 * stopRow should be set to false after the slaves have been updated.
		 */
		public function set stopRow(value:Boolean):void {
		    _stopRow = value;
		}
		
		public function get rowing():Boolean {
		    return _rowing;
		}
		
		public function get rowTimer():Timer {
		    return _rowTimer;
		}
		
		public function get rowTimeS():Number {
		    return _rowTimeS;
		}
		
		public function pause():void {
		    
		    if (_rowTimer.running) {
    		    paused = true;
    		    _rowTimer.stop();
		    }
		}
		
        public function resume():void {
            
            if (paused) {
                paused = false;
                _rowTimer.start();
            }
        }
        
        private function onTimerComplete(event:TimerEvent):void
        {
            // Slaves are waiting to row
            if (!_rowing) {
                _rowing = true;
                _startRow = true;
                _beatText.visible = true;
                
                _rowTimer.delay = (_rowTimeS * 1000);
                _rowTimer.reset();
                _rowTimer.start();
                
                //trace("rowTime " + rowTimeS);
            }
            
            // Slaves are rowing
            else {
                _rowing = false;
                _stopRow = true;
                _beatText.visible = false;
                
                _rowTimer.delay = (rowIntervalS * 1000);
                _rowTimer.reset();
                _rowTimer.start();
                
                //trace("rowInterval " + rowIntervalS);
            }
        }
	}
}
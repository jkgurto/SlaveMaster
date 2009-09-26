package game.library.objects {
    
    import assets.Assets;
    
    import flash.display.Sprite;
    import flash.events.TimerEvent;
    import flash.geom.Point;
    import flash.utils.Timer;
    
    import game.library.objects.Slave;
    
    import mx.core.Application;
    
    public class SlaveMaster extends Sprite implements Pauseable {
        
        public static const WHIP_TIME_S:Number = 0.5;
        
        private var whip:Sprite = new Sprite();
        private var _whipTimer:Timer = new Timer(WHIP_TIME_S * 1000, 1);
        private var paused:Boolean = false;
        
        private var slaveMasterImage:Sprite =
            new assets.Assets_slaveMasterClass();
        
        public function SlaveMaster()
        {
            this.addChild(slaveMasterImage);
            
            whip.name = "whip";
            this.addChild(whip);
            
            _whipTimer.stop();
            _whipTimer.addEventListener(TimerEvent.TIMER_COMPLETE,
                                       onTimerComplete);
        }
        
        public function doWhip(slave:Slave,
                               stageX:Number,
                               stageY:Number):void {
            
            //trace("whip to: " + slave.x + " " + slave.y);
            
            // Clear last line
            whip.graphics.clear();
            
            // Draw line from slave master to slave
            var start:Point = this.globalToLocal(
               new Point(this.x,
                         this.y + (this.height * 0.5)));
            var end:Point = this.globalToLocal(new Point(stageX, stageY));
            
            whip.graphics.lineStyle(10, 0x990000, .75);
            whip.graphics.moveTo(start.x, start.y);
            whip.graphics.lineTo(end.x, end.y);
            
            // Start timer for how long the whip should last
            _whipTimer.reset();
            _whipTimer.start();
        }
        
        public function pause():void {
		    
		    if (_whipTimer.running) {
    		    paused = true;
    		    _whipTimer.stop();
		    }
		}
		
        public function resume():void {
            
            if (paused) {
                paused = false;
                _whipTimer.start();
            }
        }
        
        private function onTimerComplete(event:TimerEvent):void 
        {
            // Stop whipping
            _whipTimer.stop();
            
            // Clear whip line
            whip.graphics.clear();
        }

    }
}
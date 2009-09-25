package game.library.objects {
    
    import assets.Assets_treeClass;
    
    import flash.geom.Point;
    
    import mx.core.Application;
    
    /**
     * A tree that appears to come closer as the boat moves.
     * When it comes too close it respawns in the distance.
     * Moves from top middle of screen to bottom right.
     * TODO other side
     */
    public class Tree extends assets.Assets_treeClass {
        
        public static const START_SCALE:Point = new Point(0.1, 0.1);
        
        public static const HORIZON_DISTANCE:Number = 50;
        
        public static const HORIZON_START:Point
            = new Point(Application.application.width / 3.0, 0);
            
        public static const HORIZON_END:Point
            = new Point(0, Application.application.height / 2.0);
        
        private var _distance:Number;
        
        public function Tree() {
            
            reset();
        }
        
        /**
         * Place the tree in the distance.
         */
        private function reset():void {
            
            _distance = HORIZON_DISTANCE
            
            this.x = HORIZON_START.x - this.width;
            this.y = HORIZON_START.y - this.height;
            
            this.scaleX = START_SCALE.x;
            this.scaleY = START_SCALE.y;
        }
        
        public function get distance():Number {
            return _distance;
        }
        
        /**
         * Set the distance and move the tree closer.
         * Tree is scaled bigger and moved to the side.
         */
        public function set distance(value:Number):void {
            _distance = value;
            
            if (_distance <= 0) {
                
                reset();
            }
            else {
                
                // Make tree appear like it's moving closer
                var percent:Number = (_distance / HORIZON_DISTANCE);
                //trace("percent: " + percent);
                
                // Move to side as a percentage of how close it is
                this.x = (HORIZON_START.x - HORIZON_END.x) * percent - this.width;
                this.y = HORIZON_END.y - (HORIZON_END.y - HORIZON_START.y) * percent - this.height;
                //trace("this.x: " + this.x);
                //trace("this.y: " + this.y);
                
                // Scale as a percentage of how close it is
                this.scaleX = START_SCALE.x / percent;
                this.scaleY = START_SCALE.y / percent;
                //trace("this.scaleX: " + this.scaleX);
                //trace("this.scaleY: " + this.scaleY);
            }
            
        }

    }
}
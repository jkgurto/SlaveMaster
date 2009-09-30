package game.library.objects {
    
    import assets.Assets;
    
    import flash.display.Sprite;
    
    import game.library.objects.Drum;
    import game.library.objects.Slave;
    
    import mx.collections.ArrayCollection;
    
    public class Boat extends Sprite {
        
        public static const BOAT_SCALE:Number = 1.0;
        
        // Stores slaves for adding up speeds
        private var store:ArrayCollection = new ArrayCollection();
        private var _drum:Drum = null;
        
        private var boatImage:Sprite = new assets.Assets_boatClass();
        
        public function Boat() {
            
            boatImage.scaleX = BOAT_SCALE;
            boatImage.scaleY = BOAT_SCALE;
            
            this.addChild(boatImage);
        }
        
        public function addItem(slave:Slave):void {
            store.addItem(slave);
        }
        
        public function removeItem(slave:Slave):void {
            
            var index:int;
            var found:Boolean = false;
            
            for (index = 0; index < store.length; ++index) {
                
                if (slave == store.getItemAt(index)) {
                    found = true;
                    break;
                }
            }
            
            if (found) {
                store.removeItemAt(index);
            }
        }
        
        public function set drum(value:Drum):void {
            _drum = value;
        }
        
        public function get speed():Number {
            
            var speed:Number = 0;
            var slave:Slave;
            
            for each (slave in store) {
                
                speed += slave.output;
            }
            
            // TODO boost when rowing
            /*
            if (_drum != null) {
            
                //if (_drum.rowing) {
                    
                    //var percent:Number = _drum.rowTimer.currentCount;
                    //trace("percent: " + percent);
                    //percent /= _drum.rowTimeS;
                    //trace("percent: " + percent);
                //}
                
                trace("speed: " + speed);
            }
            */
            
            return speed;
        }

    }
}
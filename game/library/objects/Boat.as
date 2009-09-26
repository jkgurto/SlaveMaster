package game.library.objects {
    
    import assets.Assets;
    
    import flash.display.Sprite;
    
    import game.library.objects.Slave;
    
    import mx.collections.ArrayCollection;
    
    public class Boat extends Sprite {
        
        private var store:ArrayCollection = new ArrayCollection();
        private var boatImage:Sprite = new assets.Assets_boatClass();
        
        public function Boat() {
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
        
        public function get speed():Number {
            
            var speed:Number = 0;
            
            for each (var slave:Slave in store) {
                
                speed += slave.output;
            }
            
            //trace("speed: " + speed);
            
            return speed;
        }

    }
}
package game.library.objects {
    
    import assets.Assets_boatClass;
    
    import game.library.objects.Slave;
    
    import mx.collections.ArrayCollection;
    
    public class Boat extends assets.Assets_boatClass {
        
        private var store:ArrayCollection = new ArrayCollection();
        
        public function Boat() {
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
        
        public function get speed():int {
            
            var speed:int = 0;
            
            for each (var slave:Slave in store) {
                
                speed += slave.output;
            }
            
            //trace("speed: " + speed);
            
            return speed;
        }

    }
}
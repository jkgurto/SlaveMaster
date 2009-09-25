package game.library.objects {
    
    import assets.Assets_backgroundClass;
    
    import game.library.objects.Tree;
    
    import mx.collections.ArrayCollection;
    
    /**
     * Class for spawning clouds, animating waves etc.
     */
    public class Environment {
        
        private var background:assets.Assets_backgroundClass =
            new assets.Assets_backgroundClass();
        //private var tree:Tree = new Tree();
        
        public function Environment() {
            
            //tree = new Tree();
        }
        
        public function update(boatSpeed:Number, frameRate:Number):void {
            //tree.distance -= (boatSpeed / frameRate);
        }
        
        public function get sprites():ArrayCollection {
            var collection:ArrayCollection = new ArrayCollection();
            
            collection.addItem(background);
            //collection.addItem(tree);
            
            return collection;
        }

    }
}
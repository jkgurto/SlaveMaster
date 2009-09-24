package game.library.objects {
    
    import mx.core.SpriteAsset;
    
    // TODO Dummy hands class
    public class Hands extends SpriteAsset {
        
        private var _speed:int;
        
        public function Hands() {
        }
        
        public function get speed():int {
            return _speed;
        }
        
        public function set speed(mySpeed:int):void {
            _speed = mySpeed;
        }

    }
}
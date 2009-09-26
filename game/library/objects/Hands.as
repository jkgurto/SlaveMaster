package game.library.objects {
    
    import flash.display.Sprite;
    
    // TODO Dummy hands class
    public class Hands extends Sprite {
        
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
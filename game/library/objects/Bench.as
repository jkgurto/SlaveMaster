package game.library.objects
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.geom.Point;
    
    public class Bench extends Sprite
    {
        public static const MAX_SLAVES:int = 3;
        
        // Top left hand side of bench
        // Use this because addChild changes the x and y coordinates of the
        // bench.
        private var _start:Point = new Point();
        
        public function Bench()
        {
        }
        
        //override private function addChild(child:DisplayObject):DisplayObject {
        //    return super.addChild(child);
        //}
        
        public function addSlave(slave:Sprite):void {
            
            if (this.numChildren >= MAX_SLAVES) {
                return;
            }
            
            slave.x = _start.x;
            slave.y = _start.y;
            
            var i:int;
            var s:Sprite;
            for (i = 0; i < this.numChildren; ++i) {
                s = this.getChildAt(i) as Sprite;
                slave.x += s.width;
            }
            
            this.addChild(slave);
        }
        
        public function get start():Point {
            return _start;
        }
        
        public function set start(value:Point):void {
            _start = value;
        }

    }
}
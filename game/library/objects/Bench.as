package game.library.objects
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.geom.Point;
    
    public class Bench extends Sprite
    {
        public static const MAX_SLAVES:int = 3;
        
        public static var _point1:Point = new Point(0, 0);
        public static var _point2:Point = new Point(70, 0);
        public static var _point3:Point = new Point(140, 0);
        
        // Points along the bench
        private var points:Array = new Array();
        
        public function Bench()
        {
            points.push(_point1);
            points.push(_point2);
            points.push(_point3);
        }
        
        //override private function addChild(child:DisplayObject):DisplayObject {
        //    return super.addChild(child);
        //}
        
        public function addSlave(slave:Sprite):void {
            
            if (this.numChildren >= MAX_SLAVES) {
                return;
            }
            
            slave.x = this.x + points[this.numChildren].x;
            slave.y = this.y + points[this.numChildren].y;
            
            this.addChild(slave);
        }
        
        public function get point1():Point {
            return _point1;
        }
        
        public function set point1(value:Point):void {
            _point1 = value;
        }
        
        public function get point2():Point {
            return _point2;
        }
        
        public function set point2(value:Point):void {
            _point2 = value;
        }
        
        public function get point3():Point {
            return _point3;
        }
        
        public function set point3(value:Point):void {
            _point3 = value;
        }

    }
}
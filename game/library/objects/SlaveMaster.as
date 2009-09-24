package game.library.objects {
    
    import assets.Assets_slaveMasterClass;
    
    import game.library.objects.Slave;
    
    import flash.display.Sprite;
    import flash.geom.Point;
    
    import mx.core.Application;
    
    public class SlaveMaster extends assets.Assets_slaveMasterClass {
        
        private var whip:Sprite = new Sprite();
        
        public function SlaveMaster()
        {
            whip.name = "whip";
            this.addChild(whip);
        }
        
        public function doWhip(slave:Slave):void {
            
            //trace("whip to: " + slave.x + " " + slave.y);
            
            // Draw line from slave master to slave
            var start:Point = this.globalToLocal(new Point(this.x, this.y));
            var end:Point = this.globalToLocal(new Point(slave.x, slave.y));
            
            // Clear last line
            whip.graphics.clear();
            
            whip.graphics.lineStyle(10, 0x990000, .75);
            whip.graphics.moveTo(start.x, start.y);
            whip.graphics.lineTo(end.x, end.y);
        }

    }
}
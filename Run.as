package {
    
    import flash.display.Sprite;

    [SWF(width="800", height="600", frameRate="30", backgroundColor="#66CCFF")]
    public class Run extends Sprite
    {
        private var main:Main = null;
        
        public function Run()
        {
            //this.width = 800;
            //this.height = 600;
            //this.frameRate = 30;
            
            main = new Main();
            
            stage.addChild(main);
            
            main.setup();
        }
    }
}

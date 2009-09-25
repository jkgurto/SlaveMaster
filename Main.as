
// -- Imports
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import game.library.objects.Boat;
import game.library.objects.Difficulty;
import game.library.objects.Slave;
import game.library.objects.SlaveMaster;

import mx.core.Application;
import mx.core.UIComponent;
import mx.core.SpriteAsset;

// -- Variables
protected var boat:Boat = null;
protected var slave1:Slave = null;
protected var slave2:Slave = null;
protected var slave3:Slave = null;
protected var slave4:Slave = null;
protected var slaveMaster:SlaveMaster = null;

protected var difficulty:Difficulty = null;

protected var reset:Boolean = true;
protected var slaveCount:int = 0;

// -- Methods
protected function enterFrame(event:Event):void {
    
}

protected function enterStartState(event:Event):void {
    
}

protected function exitStartState(event:Event):void {
    
}

protected function enterPlayState(event:Event):void {
    
    // -- Reset scene
    if (reset) {
        
        reset = false;
        
        // -- Boat
        boat = new Boat();
        
        // -- Difficulty
        difficulty = new Difficulty(boat);
        
        // -- Slaves
        const SLAVE_SCALE:Number = 0.2;
        const START:Point = new Point(200, 100);
        const ROW_WIDTH:Number = 250;
        
        // - Slave 1
        slave1 = new Slave();
        
        slave1.name = "slave1";
        
        slave1.scaleX = SLAVE_SCALE;
        slave1.scaleY = SLAVE_SCALE;
        
        slave1.x += START.x;
        slave1.y += START.y;
        
        slave1.addEventListener(MouseEvent.CLICK, slave1Click);
        
        // - Slave 2
        slave2 = new Slave();
        
        slave2.name = "slave2";
        
        slave2.scaleX = SLAVE_SCALE;
        slave2.scaleY = SLAVE_SCALE;
        
        slave2.x += START.x + ROW_WIDTH;
        slave2.y += START.y;
        
        slave2.addEventListener(MouseEvent.CLICK, slave2Click);
        
        // - Slave 3
        slave3 = new Slave();
        
        slave3.name = "slave3";
        
        slave3.scaleX = SLAVE_SCALE;
        slave3.scaleY = SLAVE_SCALE;
        
        slave3.x += START.x;
        slave3.y += START.y + slave1.height;
        
        slave3.addEventListener(MouseEvent.CLICK, slave3Click);
        
        // - Slave 4
        slave4 = new Slave();
        
        slave4.name = "slave4";
        
        slave4.scaleX = SLAVE_SCALE;
        slave4.scaleY = SLAVE_SCALE;
        
        slave4.x += START.x + ROW_WIDTH;
        slave4.y += START.y + slave1.height;
        
        slave4.addEventListener(MouseEvent.CLICK, slave4Click);
        
        // -- Slave Master
        slaveMaster = new SlaveMaster();
        slaveMaster.scaleX = SLAVE_SCALE;
        slaveMaster.scaleY = SLAVE_SCALE;
        
        slaveMaster.x += START.x + ROW_WIDTH;
        slaveMaster.y += START.y + slave2.height + slave4.height;
    }
    
    // Add scene to stage
    stage.addChild(difficulty.distanceLeftText);
    stage.addChild(difficulty.timeLeftText);
    stage.addChild(difficulty.tree);
    
    addChildSprite(boat);
    addChildSlave(slave1);
    addChildSlave(slave2);
    addChildSlave(slave3);
    addChildSlave(slave4);
    addChildSprite(slaveMaster);
    
    // -- Start listening to keyboard
    stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
    
    // -- Start timer
    difficulty.timer.start();
}

protected function exitPlayState(event:Event):void {
    
    stage.removeChild(difficulty.distanceLeftText);
    stage.removeChild(difficulty.timeLeftText);
    removeChildSprite(boat);
    removeChildSprite(slaveMaster);
    
    // Important - need to check if slaves are children of the stage before
    // attempting to remove them
    if (slave1.parent.parent != null) {
        removeChildSlave(slave1);
    }
    if (slave2.parent.parent != null) {
        removeChildSlave(slave2);
    }
    if (slave3.parent.parent != null) {
        removeChildSlave(slave3);
    }
    if (slave4.parent.parent != null) {
        removeChildSlave(slave4);
    }
    
    // -- Stop timer
    difficulty.timer.stop();
}

protected function enterPausedState(event:Event):void {
    
}

protected function exitPausedState(event:Event):void {
    
}

protected function enterGameOverState(event:Event):void {
    reset = true;
}

protected function exitGameOverState(event:Event):void {
    
}

protected function slave1Click(event:MouseEvent):void {
    
    slaveMaster.doWhip(slave1);
    slave1.doWhip();
    
    if (slave1.isDead()) {
        
        removeChildSlave(slave1);
        
        if (slaveCount <= 0) {
            setCurrentState("GameOverState");
        }
    }
}

protected function slave2Click(event:MouseEvent):void {
    
    slaveMaster.doWhip(slave2);
    slave2.doWhip();
    
    if (slave2.isDead()) {
        
        removeChildSlave(slave2);
        
        if (slaveCount <= 0) {
            setCurrentState("GameOverState");
        }
    }
}

protected function slave3Click(event:MouseEvent):void {
    
    slaveMaster.doWhip(slave3);
    slave3.doWhip();
    
    if (slave3.isDead()) {
        
        removeChildSlave(slave3);
        
        if (slaveCount <= 0) {
            setCurrentState("GameOverState");
        }
    }
}

protected function slave4Click(event:MouseEvent):void {
    
    slaveMaster.doWhip(slave4);
    slave4.doWhip();
    
    if (slave4.isDead()) {
        
        removeChildSlave(slave4);
        
        if (slaveCount <= 0) {
            setCurrentState("GameOverState");
        }
    }
}

protected function addChildSprite(sprite:Sprite):void {

    var component:UIComponent = new UIComponent();
    component.addChild(sprite);
    canvas.addChild(component);
}

protected function removeChildSprite(sprite:Sprite):void {
    
    canvas.removeChild(sprite.parent);
}

protected function addChildSlave(slave:Slave):void {
    
    boat.addItem(slave);
    var component:UIComponent = new UIComponent();
    component.addChild(slave);
    component.addChild(slave.progress);
    canvas.addChild(component);
    ++slaveCount;
}

protected function removeChildSlave(slave:Slave):void {
    
    boat.removeItem(slave);
    canvas.removeChild(slave.parent);
    --slaveCount;
}

override protected function keyDownHandler(event:KeyboardEvent):void {
    
    if (event.keyCode == Keyboard.ESCAPE) {
        setCurrentState("GameOverState");
    }
    else if (String.fromCharCode(event.charCode) == "p") {
        setCurrentState("PausedState");
    }
}

protected function startButtonClicked(event:MouseEvent):void {
    setCurrentState("PlayState");
}

protected function continueButtonClicked(event:MouseEvent):void {
    setCurrentState("PlayState");
}

protected function playAgainButtonClicked(event:MouseEvent):void {
    setCurrentState("StartState");
}

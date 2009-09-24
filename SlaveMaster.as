
// -- Imports
import assets.Assets;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import library.objects.Slave;

import mx.core.SpriteAsset;

// -- Variables
protected var reset:Boolean = true;

protected var boat:SpriteAsset = null;
protected var slave1:Slave = null;
protected var slave2:Slave = null;
protected var slave3:Slave = null;
protected var slave4:Slave = null;
protected var slaveMaster:SpriteAsset = null;

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
        
        slaveCount = 4;
        
        const SLAVE_SCALE:Number = 0.2;
        const START:Point = new Point(200, 100);
        const ROW_WIDTH:Number = 250;
        
        boat = new assets.Assets_boatClass();
        
        slave1 = new Slave();
        slave1.scaleX = SLAVE_SCALE;
        slave1.scaleY = SLAVE_SCALE;
        
        slave1.x += START.x;
        slave1.y += START.y;
        
        slave1.addEventListener(MouseEvent.CLICK, slave1Click);
        
        slave2 = new Slave();
        slave2.scaleX = SLAVE_SCALE;
        slave2.scaleY = SLAVE_SCALE;
        
        slave2.x += START.x + ROW_WIDTH;
        slave2.y += START.y;
        
        slave2.addEventListener(MouseEvent.CLICK, slave2Click);
        
        slave3 = new Slave();
        slave3.scaleX = SLAVE_SCALE;
        slave3.scaleY = SLAVE_SCALE;
        
        slave3.x += START.x;
        slave3.y += START.y + slave1.height;
        
        slave3.addEventListener(MouseEvent.CLICK, slave3Click);
        
        slave4 = new Slave();
        slave4.scaleX = SLAVE_SCALE;
        slave4.scaleY = SLAVE_SCALE;
        
        slave4.x += START.x + ROW_WIDTH;
        slave4.y += START.y + slave1.height;
        
        slave4.addEventListener(MouseEvent.CLICK, slave4Click);
        
        slaveMaster = new assets.Assets_slaveMasterClass();
        slaveMaster.scaleX = SLAVE_SCALE;
        slaveMaster.scaleY = SLAVE_SCALE;
        
        slaveMaster.x += START.x + ROW_WIDTH;
        slaveMaster.y += START.y + slave2.height + slave4.height;
    }
    
    stage.addChild(boat);
    stage.addChild(slave1);
    stage.addChild(slave2);
    stage.addChild(slave3);
    stage.addChild(slave4);
    stage.addChild(slaveMaster);
    
    // -- Start listening to keyboard
    stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
}

protected function exitPlayState(event:Event):void {
    
    stage.removeChild(boat);
    stage.removeChild(slaveMaster);
    
    // Important - need to check if slaves are children of the stage before
    // attempting to remove them
    if (slave1.parent != null) {
        stage.removeChild(slave1);
    }
    if (slave2.parent != null) {
        stage.removeChild(slave2);
    }
    if (slave3.parent != null) {
        stage.removeChild(slave3);
    }
    if (slave4.parent != null) {
        stage.removeChild(slave4);
    }
}

protected function enterPausedState(event:Event):void {
    
}

protected function exitPausedState(event:Event):void {
    
}

protected function enterGameOverState(event:Event):void {
    
}

protected function exitGameOverState(event:Event):void {
    
}

protected function slave1Click(event:MouseEvent):void {
    stage.removeChild(slave1);
    --slaveCount;
    if (slaveCount <= 0) {
        setCurrentState("GameOverState");
    }
}

protected function slave2Click(event:MouseEvent):void {
    stage.removeChild(slave2);
    --slaveCount;
    if (slaveCount <= 0) {
        setCurrentState("GameOverState");
    }
}

protected function slave3Click(event:MouseEvent):void {
    stage.removeChild(slave3);
    --slaveCount;
    if (slaveCount <= 0) {
        setCurrentState("GameOverState");
    }
}

protected function slave4Click(event:MouseEvent):void {
    stage.removeChild(slave4);
    --slaveCount;
    if (slaveCount <= 0) {
        setCurrentState("GameOverState");
    }
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

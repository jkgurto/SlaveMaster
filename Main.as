
// -- Imports
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import game.library.objects.Bench;
import game.library.objects.Boat;
import game.library.objects.Difficulty;
import game.library.objects.Drum;
import game.library.objects.Environment;
import game.library.objects.Slave;
import game.library.objects.SlaveMaster;

import mx.collections.ArrayCollection;

import mx.controls.ProgressBar;

import mx.core.Application;
import mx.core.UIComponent;
import mx.core.SpriteAsset;

// -- Constants
protected const SPEED_BAR_WIDTH:int = 100;

protected const MAX_SLAVES_PER_BENCH:int = 3;

protected const BENCH_1:Point = new Point(150, 200);
protected const BENCH_2:Point = new Point(150, 200);
protected const BENCH_3:Point = new Point(150, 200);
protected const BENCH_4:Point = new Point(150, 200);

// -- Variables
protected var boat:Boat = null;
protected var drum:Drum = null;
protected var environment:Environment = null;
protected var bench1:Bench = null;
protected var bench2:Bench = null;
protected var bench3:Bench = null;
protected var bench4:Bench = null;
protected var slave1:Slave = null;
protected var slave2:Slave = null;
protected var slave3:Slave = null;
protected var slave4:Slave = null;
protected var slaveMaster:SlaveMaster = null;

protected var difficulty:Difficulty = null;

protected var reset:Boolean = true;
protected var slaveCount:int = 0;

private var speedBar:ProgressBar = null;

// -- Methods
protected function creationComplete(event:Event):void {
    
}

protected function enterFrame(event:Event):void {
    
    if (currentState.toString() == "PlayState") {
        
        // -- Slaves
        slave1.update(stage.frameRate);
        slave2.update(stage.frameRate);
        slave3.update(stage.frameRate);
        slave4.update(stage.frameRate);
        
        // -- Drum
        drum.update(stage.frameRate);
        
        if (drum.startRow) {
            drum.startRow = false;
            slave1.startRow();
            slave2.startRow();
            slave3.startRow();
            slave4.startRow();
        }
        else if (drum.stopRow) {
            drum.stopRow = false;
            slave1.stopRow();
            slave2.stopRow();
            slave3.stopRow();
            slave4.stopRow();
        }
        
        // -- Environment
        environment.update(boat.speed, stage.frameRate);
        
        // -- Speed Bar
        speedBar.setProgress(boat.speed,
                             Slave.MAX_OUTPUT * slaveCount);
        
        // -- Distance to goal
        difficulty.distance -= (boat.speed / stage.frameRate);
        
        // Distance finished
        if (difficulty.distance <= 0) {
            Application.application.setCurrentState("GameOverState");
        }
    }
}

protected function enterStartState(event:Event):void {
    
}

protected function exitStartState(event:Event):void {
    
}

protected function enterHelpState(event:Event):void {
    
}

protected function exitHelpState(event:Event):void {
    
}

protected function enterCreditsState(event:Event):void {
    
}

protected function exitCreditsState(event:Event):void {
    
}

protected function enterPlayState(event:Event):void {
    
    // -- Reset scene
    if (reset) {
        
        reset = false;
        
        // -- Boat
        boat = new Boat();
        
        boat.x = 0;
        boat.y = Application.application.height - boat.height;
        
        // -- Difficulty
        difficulty = new Difficulty(boat);
        
        // -- Environment
        environment = new Environment();
        
        // -- Slaves
        
        bench1 = new Bench();
        bench1.start.x = BENCH_1.x;
        bench1.start.y = BENCH_1.y;
        
        bench2 = new Bench();
        bench2.start.x = BENCH_2.x;
        bench2.start.y = BENCH_2.y;
        
        bench3 = new Bench();
        bench3.start.x = BENCH_3.x;
        bench3.start.y = BENCH_3.y;
        
        bench4 = new Bench();
        bench4.start.x = BENCH_4.x;
        bench4.start.y = BENCH_4.y;
        
        // - Slave 1
        slave1 = new Slave();
        
        slave1.name = "slave1";
        
        //slave1.x = COL_1_X;
        //slave1.y = ROW_1_Y;
        bench1.addSlave(slave1);
        
        trace("slave1.height " + slave1.height);
        
        slave1.addEventListener(MouseEvent.CLICK, slave1Click);
        
        // - Slave 2
        slave2 = new Slave();
        
        slave2.name = "slave2";
        
        //slave2.x = COL_1_X + slave2.width + ROW_1_X_SPACER;
        //slave2.y = ROW_1_Y;
        bench1.addSlave(slave2);
        
        slave2.addEventListener(MouseEvent.CLICK, slave2Click);
        
        // - Slave 3
        slave3 = new Slave();
        
        slave3.name = "slave3";
        
        //slave3.x += ROW_1_Y.x;
        //slave3.y += ROW_1_Y.y + slave1.height;
        bench1.addSlave(slave3);
        
        slave3.addEventListener(MouseEvent.CLICK, slave3Click);
        
        // - Slave 4
        slave4 = new Slave();
        
        slave4.name = "slave4";
        
        //slave4.x += ROW_1_Y.x + ROW_WIDTH;
        //slave4.y += ROW_1_Y.y + slave1.height;
        
        slave4.addEventListener(MouseEvent.CLICK, slave4Click);
        
        // -- Boat speed bar
        speedBar = new ProgressBar();
		speedBar.visible = true;
		speedBar.label = "Speed";
		speedBar.direction = "right";
		speedBar.mode = "manual";
        
        speedBar.width = SPEED_BAR_WIDTH;
        
        speedBar.x = Application.application.width
                     - (speedBar.width + 20);
        speedBar.y = difficulty.timeLeftText.y
                     + difficulty.timeLeftText.height
                     + 20;
        
        speedBar.minimum = boat.speed;
        speedBar.setProgress(boat.speed,
                             Slave.MAX_OUTPUT * slaveCount);
                             
        
        // -- Slave Master
        slaveMaster = new SlaveMaster();
        slaveMaster.scaleX = 0.2;
        slaveMaster.scaleY = 0.2;
        
        //slaveMaster.x += COL_1_X;
        //slaveMaster.y += ROW_1_Y;
        
        // -- Drum
        drum = new Drum();
        
        //drum.scaleX = SLAVE_SCALE;
        //drum.scaleY = SLAVE_SCALE;
        
        //drum.x = slaveMaster.x;
        //drum.y = slaveMaster.y - slaveMaster.height + drum.height;
        //drum.x = ROW_1_Y.x + ROW_WIDTH;
        //drum.y = ROW_1_Y.y;
        
        boat.drum = drum;
    }
    
    // -- Add scene to stage
    // Layered in order
    addChildSprite(environment);
    addChildSprite(boat);
    addChildSprite(bench1);
    addChildSlave(slave1);
    addChildSlave(slave2);
    addChildSlave(slave3);
    addChildSlave(slave4);
    addChildSprite(slaveMaster);
    addChildSprite(drum);
    
    stage.addChild(difficulty.distanceLeftText);
    stage.addChild(difficulty.timeLeftText);
    
    stage.addChild(drum.beatText);
    
    canvas.addChild(speedBar);
    
    // -- Start listening to keyboard
    stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
    
    // -- Start timer
    resumeTimers();
}

protected function exitPlayState(event:Event):void {
    
    removeChildSprite(environment);
    removeChildSprite(boat);
    removeChildSprite(slaveMaster);
    removeChildSprite(drum);
    
    stage.removeChild(difficulty.distanceLeftText);
    stage.removeChild(difficulty.timeLeftText);
    
    stage.removeChild(drum.beatText);
    
    canvas.removeChild(speedBar);
    
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
    
    // -- Stop timers
    pauseTimers();
}

protected function enterPausedState(event:Event):void {
    pausedInfoText.text = "Level " + difficulty.level;
}

protected function exitPausedState(event:Event):void {
    
}

protected function enterGameOverState(event:Event):void {
    reset = true;
    
    if (difficulty.distance <= 0) {
        gameOverInfoText.text = "Win";
    }
    else {
        gameOverInfoText.text = "Lose";
    }
}

protected function exitGameOverState(event:Event):void {
    
}

protected function slave1Click(event:MouseEvent):void {
    
    slaveMaster.doWhip(slave1, event.stageX, event.stageY);
    slave1.doWhip();
    
    if (slave1.isDead()) {
        
        removeChildSlave(slave1);
        
        if (slaveCount <= 0) {
            setCurrentState("GameOverState");
        }
    }
}

protected function slave2Click(event:MouseEvent):void {
    
    slaveMaster.doWhip(slave2, event.stageX, event.stageY);
    slave2.doWhip();
    
    if (slave2.isDead()) {
        
        removeChildSlave(slave2);
        
        if (slaveCount <= 0) {
            setCurrentState("GameOverState");
        }
    }
}

protected function slave3Click(event:MouseEvent):void {
    
    slaveMaster.doWhip(slave3, event.stageX, event.stageY);
    slave3.doWhip();
    
    if (slave3.isDead()) {
        
        removeChildSlave(slave3);
        
        if (slaveCount <= 0) {
            setCurrentState("GameOverState");
        }
    }
}

protected function slave4Click(event:MouseEvent):void {
    
    slaveMaster.doWhip(slave4, event.stageX, event.stageY);
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

protected function resumeTimers():void {
    difficulty.resume();
    drum.resume();
    slaveMaster.resume();
}

protected function pauseTimers():void {
    difficulty.pause();
    drum.pause();
    slaveMaster.pause();
}

override protected function keyDownHandler(event:KeyboardEvent):void {
    
    if (event.keyCode == Keyboard.ESCAPE) {
        setCurrentState("GameOverState");
    }
    else if (String.fromCharCode(event.charCode) == "p") {
        setCurrentState("PausedState");
    }
    else if (String.fromCharCode(event.charCode) == "z") {
        drum.doLeftBeat();
    }
    else if (String.fromCharCode(event.charCode) == "x") {
        drum.doRightBeat();
    }
    
}

protected function continueButtonClicked(event:MouseEvent):void {
    setCurrentState("PlayState");
}

protected function helpButtonClicked(event:MouseEvent):void {
    setCurrentState("HelpState");
}

protected function helpBackButtonClicked(event:MouseEvent):void {
    setCurrentState("StartState");
}

protected function creditsButtonClicked(event:MouseEvent):void {
    setCurrentState("CreditsState");
}

protected function creditsBackButtonClicked(event:MouseEvent):void {
    setCurrentState("StartState");
}

protected function playAgainButtonClicked(event:MouseEvent):void {
    setCurrentState("StartState");
}

protected function startButtonClicked(event:MouseEvent):void {
    setCurrentState("PlayState");
}

﻿package {		import assets.IntroSoundClass;		import fl.controls.Button;	import fl.controls.Label;		import flash.display.Sprite;	import flash.events.Event;	import flash.events.KeyboardEvent;	import flash.events.MouseEvent;	import flash.media.Sound;	import flash.media.SoundChannel;	import flash.media.SoundTransform;	import flash.text.TextFieldAutoSize;	import flash.text.TextFormat;	import flash.geom.Point;	import flash.ui.Keyboard;		import game.Text;	import game.library.objects.Bench;	import game.library.objects.Boat;	import game.library.objects.Difficulty;	import game.library.objects.Drum;	import game.library.objects.Environment;	import game.library.objects.Slave;	import game.library.objects.SlaveMaster;		public class Main extends flash.display.Sprite {				public static const TOP_LABEL_Y:Number = 150;		public static const LABEL_X:Number = 400;				public static const BUTTON_SPACE_Y:Number = 22;				public static const INFO_WIDTH:Number = 300;		public static const INFO_HEIGHT:Number = 200;				public static const LABEL_COLOUR:Number = 0x000000;		public static const INFO_LABEL_COLOUR:Number = 0x000000;		public static const BUTTON_COLOUR:Number = 0x000000;				public static const LABEL_SIZE:Number = 20;		public static const INFO_LABEL_SIZE:Number = 14;		public static const BUTTON_SIZE:Number = 12;				// +1 for full, 0 for silent        public static const START_SOUND_VOLUME:Number = 1.0;				// -1 left, 0 centre, +1 right		public static const START_SOUND_PAN:Number = 0.0;				//private const SPEED_BAR_WIDTH:int = 100;		private const BOAT_POS:Point = new Point(0, 100);		private const DRUM_POS:Point = new Point(300, 200);				protected const MAX_SLAVES_PER_BENCH:int = 3;        protected const BENCH_1:Point = new Point(150, 200);        protected const BENCH_2:Point = new Point(150, 200);        protected const BENCH_3:Point = new Point(150, 200);        protected const BENCH_4:Point = new Point(150, 200);				private var currentState:String;				private var labelFormat:TextFormat;		private var infoLabelFormat:TextFormat;		private var buttonFormat:TextFormat;				// Start screen		private var startLabel:Label;		private var startButton:Button;		private var creditsButton:Button;		private var helpButton:Button;				private var startSound:Sound = new IntroSoundClass();		private var startChannel:SoundChannel = new SoundChannel();				// Credits screen		private var creditsLabel:Label;		private var creditsInfoLabel:Label;		private var creditsBackButton:Button;				// Help screen		private var helpLabel:Label;		private var helpInfoLabel:Label;		private var helpBackButton:Button;				// Paused screen		private var pausedLabel:Label;		private var pausedInfoLabel:Label;		private var continueButton:Button;				// Game over screen		private var gameOverLabel:Label;		private var gameOverInfoLabel:Label;		private var playAgainButton:Button;				private var boat:Boat = null;		private var drum:Drum = null;		private var environment:Environment = null;		private var bench1:Bench = null;		private var bench2:Bench = null;		private var bench3:Bench = null;		private var bench4:Bench = null;		private var slave1:Slave = null;		private var slave2:Slave = null;		private var slave3:Slave = null;		private var slave4:Slave = null;		private var slaveMaster:SlaveMaster = null;				private var difficulty:Difficulty = null;				private var reset:Boolean = true;		private var slaveCount:int = 0;				public function Main() {		}				public function setup():void {			stage.addEventListener(Event.ENTER_FRAME, this.enterFrame);						labelFormat = new TextFormat();			labelFormat.color = LABEL_COLOUR;			labelFormat.size = LABEL_SIZE;						infoLabelFormat = new TextFormat();			infoLabelFormat.color = INFO_LABEL_COLOUR;			infoLabelFormat.size = INFO_LABEL_SIZE;						buttonFormat = new TextFormat();			buttonFormat.color = BUTTON_COLOUR;			buttonFormat.size = BUTTON_SIZE;						// Sets volume and panning (left or right)			// Sprite has its own sound transform			this.soundTransform = new SoundTransform(START_SOUND_VOLUME,												     START_SOUND_PAN);						setCurrentState("StartState");			//setCurrentState("PlayState");		}				private function enterFrame(event:Event):void {						if (currentState == "PlayState") {								// -- Slaves				slave1.update(stage.frameRate);				slave2.update(stage.frameRate);				slave3.update(stage.frameRate);				slave4.update(stage.frameRate);								// -- Drum				drum.update(stage.frameRate);								if (drum.startRow) {					drum.startRow = false;					slave1.startRow();					slave2.startRow();					slave3.startRow();					slave4.startRow();				}				else if (drum.stopRow) {					drum.stopRow = false;					slave1.stopRow();					slave2.stopRow();					slave3.stopRow();					slave4.stopRow();				}								// -- Environment				environment.update(boat.speed, stage.frameRate);								// -- Speed Bar				//speedBar.setProgress(boat.speed, Slave.MAX_OUTPUT * slaveCount);								// -- Distance to goal				difficulty.distance -= (boat.speed / stage.frameRate);								// Distance finished				if (difficulty.distance <= 0) {					this.setCurrentState("GameOverState");				}			}		}				private function enterStartState():void {						// Title			startLabel = new Label();						//startLabel.autoSize = TextFieldAutoSize.CENTER;			startLabel.setStyle("textFormat", labelFormat);						startLabel.text = "Slave Master";						startLabel.x = LABEL_X - (startLabel.width * 0.5);			startLabel.y = TOP_LABEL_Y - (startLabel.height * 0.5);						startLabel.width = INFO_WIDTH;						stage.addChild(startLabel);						// Start			startButton = new Button();						startButton.setStyle("textFormat", buttonFormat);						startButton.label = "Start";						startButton.x = LABEL_X - (startButton.width * 0.5);			startButton.y = startLabel.y + startLabel.height + BUTTON_SPACE_Y;						startButton.addEventListener(MouseEvent.CLICK, startButtonClicked);						stage.addChild(startButton);						// Credits			creditsButton = new Button();						creditsButton.setStyle("textFormat", buttonFormat);						creditsButton.label = "Credits";						creditsButton.x = startButton.x;			creditsButton.y = startButton.y + startButton.height + BUTTON_SPACE_Y;						creditsButton.addEventListener(MouseEvent.CLICK, creditsButtonClicked);						stage.addChild(creditsButton);						// Help			helpButton = new Button();						helpButton.setStyle("textFormat", buttonFormat);						helpButton.label = "Help";						helpButton.x = creditsButton.x;			helpButton.y = creditsButton.y + creditsButton.height + BUTTON_SPACE_Y;						helpButton.addEventListener(MouseEvent.CLICK, helpButtonClicked);						stage.addChild(helpButton);						// Sound			startChannel = startSound.play(0, 0, this.soundTransform);			startChannel.addEventListener(Event.SOUND_COMPLETE, onStartSoundComplete);		}				private function exitStartState():void {						stage.removeChild(startLabel);						startButton.removeEventListener(MouseEvent.CLICK, startButtonClicked);			stage.removeChild(startButton);						creditsButton.removeEventListener(MouseEvent.CLICK, creditsButtonClicked);			stage.removeChild(creditsButton);						helpButton.removeEventListener(MouseEvent.CLICK, helpButtonClicked);			stage.removeChild(helpButton);						// Stop sound			startChannel.stop();		}				private function enterHelpState():void {						// Title			helpLabel = new Label();						//helpLabel.autoSize = TextFieldAutoSize.CENTER;			helpLabel.setStyle("textFormat", labelFormat);						helpLabel.text = "Help";						helpLabel.x = LABEL_X - (helpLabel.width * 0.5);			helpLabel.y = TOP_LABEL_Y - (helpLabel.height * 0.5);						stage.addChild(helpLabel);						// Text			helpInfoLabel = new Label();						//helpInfoLabel.autoSize = TextFieldAutoSize.CENTER;			helpInfoLabel.setStyle("textFormat", infoLabelFormat);						helpInfoLabel.text = game.Text.HELP_STRING;						helpInfoLabel.width = INFO_WIDTH;			helpInfoLabel.height = INFO_HEIGHT;						helpInfoLabel.x = LABEL_X - (helpInfoLabel.width * 0.5);			helpInfoLabel.y = helpLabel.y + helpLabel.height + BUTTON_SPACE_Y;						stage.addChild(helpInfoLabel);						// Back			helpBackButton = new Button();						helpBackButton.setStyle("textFormat", buttonFormat);						helpBackButton.label = "Back";						helpBackButton.x = LABEL_X - (helpBackButton.width * 0.5);			helpBackButton.y = helpInfoLabel.y + helpInfoLabel.height + BUTTON_SPACE_Y;						helpBackButton.addEventListener(MouseEvent.CLICK, helpBackButtonClicked);						stage.addChild(helpBackButton);		}				private function exitHelpState():void {						stage.removeChild(helpLabel);			stage.removeChild(helpInfoLabel);						helpBackButton.removeEventListener(MouseEvent.CLICK, helpBackButtonClicked);			stage.removeChild(helpBackButton);		}				private function enterCreditsState():void {						// Title			creditsLabel = new Label();						//creditsLabel.autoSize = TextFieldAutoSize.CENTER;			creditsLabel.setStyle("textFormat", labelFormat);						creditsLabel.text = "Credits";						creditsLabel.x = LABEL_X - (creditsLabel.width * 0.5);			creditsLabel.y = TOP_LABEL_Y - (creditsLabel.height * 0.5);						stage.addChild(creditsLabel);						// Text			creditsInfoLabel = new Label();						//creditsInfoLabel.autoSize = TextFieldAutoSize.CENTER;			creditsInfoLabel.setStyle("textFormat", infoLabelFormat);						creditsInfoLabel.text = game.Text.CREDITS_STRING;						creditsInfoLabel.width = INFO_WIDTH;			creditsInfoLabel.height = INFO_HEIGHT;						creditsInfoLabel.x = LABEL_X - (creditsInfoLabel.width * 0.5);			creditsInfoLabel.y = creditsLabel.y + creditsLabel.height + BUTTON_SPACE_Y;						stage.addChild(creditsInfoLabel);						// Back			creditsBackButton = new Button();						creditsBackButton.setStyle("textFormat", buttonFormat);						creditsBackButton.label = "Back";						creditsBackButton.x = LABEL_X - (creditsBackButton.width * 0.5);			creditsBackButton.y = creditsInfoLabel.y + creditsInfoLabel.height + BUTTON_SPACE_Y;						creditsBackButton.addEventListener(MouseEvent.CLICK, creditsBackButtonClicked);						stage.addChild(creditsBackButton);		}				private function exitCreditsState():void {						stage.removeChild(creditsLabel);			stage.removeChild(creditsInfoLabel);						creditsBackButton.removeEventListener(MouseEvent.CLICK, creditsBackButtonClicked);			stage.removeChild(creditsBackButton);		}				private function enterPlayState():void {						// -- Reset scene			if (reset) {								reset = false;								// -- Boat				boat = new Boat();				boat.x = BOAT_POS.x;				boat.y = BOAT_POS.y;								// -- Difficulty				difficulty = new Difficulty(boat);								// -- Environment				environment = new Environment();								// -- Slaves				const START:Point = new Point(200, 100);				const ROW_WIDTH:Number = 250;								bench1 = new Bench();                bench1.start.x = BENCH_1.x;                bench1.start.y = BENCH_1.y;                                bench2 = new Bench();                bench2.start.x = BENCH_2.x;                bench2.start.y = BENCH_2.y;                                bench3 = new Bench();                bench3.start.x = BENCH_3.x;                bench3.start.y = BENCH_3.y;                                bench4 = new Bench();                bench4.start.x = BENCH_4.x;                bench4.start.y = BENCH_4.y;								// - Slave 1				slave1 = new Slave();								slave1.name = "slave1";								//slave1.x += START.x;				//slave1.y += START.y;				bench1.addSlave(slave1);								slave1.addEventListener(MouseEvent.CLICK, this.slave1Click);								// - Slave 2				slave2 = new Slave();								slave2.name = "slave2";								//slave2.x += START.x + ROW_WIDTH;				//slave2.y += START.y;				bench1.addSlave(slave2);								slave2.addEventListener(MouseEvent.CLICK, this.slave2Click);								// - Slave 3				slave3 = new Slave();								slave3.name = "slave3";								//slave3.x += START.x;				//slave3.y += START.y + slave1.height;				bench1.addSlave(slave3);								slave3.addEventListener(MouseEvent.CLICK, this.slave3Click);								// - Slave 4				slave4 = new Slave();								slave4.name = "slave4";								//slave4.x += START.x + ROW_WIDTH;				//slave4.y += START.y + slave1.height;				//bench2.addSlave(slave4);								slave4.addEventListener(MouseEvent.CLICK, this.slave4Click); 								// -- Slave Master				slaveMaster = new SlaveMaster();								//slaveMaster.x += START.x + ROW_WIDTH;				//slaveMaster.y += START.y + slave2.height + slave4.height;								// -- Drum				drum = new Drum();				drum.x = DRUM_POS.x;				drum.y = DRUM_POS.y;								boat.drum = drum;			}						// -- Add scene to stage			// Layered in order			stage.addChild(environment);			stage.addChild(boat);						stage.addChild(bench1);						boat.addItem(slave1);			stage.addChild(slave1);			++slaveCount;						boat.addItem(slave2);			stage.addChild(slave2);			++slaveCount;						boat.addItem(slave3);			stage.addChild(slave3);			++slaveCount;						boat.addItem(slave4);			stage.addChild(slave4);			++slaveCount;						stage.addChild(slaveMaster);			stage.addChild(drum);						// -- Start listening to keyboard			stage.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDownHandler);						// -- Start timer			resumeTimers();		}				private function exitPlayState():void {						stage.removeChild(environment);			stage.removeChild(boat);			stage.removeChild(slaveMaster);			stage.removeChild(drum);						//stage.removeChild(difficulty.distanceLeftText);			//stage.removeChild(difficulty.timeLeftText);						//stage.removeChild(drum.beatText);						// Important - need to check if slaves are children of the stage before			// attempting to remove them			if (slave1.parent != null) {				boat.removeItem(slave1);			    stage.removeChild(slave1);			    --slaveCount;			}			if (slave2.parent != null) {				boat.removeItem(slave2);			    stage.removeChild(slave2);			    --slaveCount;			}			if (slave3.parent != null) {				boat.removeItem(slave3);			    stage.removeChild(slave3);			    --slaveCount;			}			if (slave4.parent != null) {				boat.removeItem(slave4);			    stage.removeChild(slave4);			    --slaveCount;			}						// -- Stop timers			pauseTimers();		}				private function enterPausedState():void {						// Title			pausedLabel = new Label();						//pausedLabel.autoSize = TextFieldAutoSize.CENTER;			pausedLabel.setStyle("textFormat", labelFormat);						pausedLabel.text = "Paused";						pausedLabel.x = LABEL_X - (pausedLabel.width * 0.5);			pausedLabel.y = TOP_LABEL_Y - (pausedLabel.height * 0.5);						stage.addChild(pausedLabel);						// Text			pausedInfoLabel = new Label();						//pausedInfoLabel.autoSize = TextFieldAutoSize.CENTER;			pausedInfoLabel.setStyle("textFormat", infoLabelFormat);						pausedInfoLabel.text = "Level " + difficulty.level;						pausedInfoLabel.x = LABEL_X - (pausedInfoLabel.width * 0.5);			pausedInfoLabel.y = pausedLabel.y + pausedLabel.height + BUTTON_SPACE_Y;						stage..addChild(pausedInfoLabel);						// Back			continueButton = new Button();						continueButton.setStyle("textFormat", buttonFormat);						continueButton.label = "Continue";						continueButton.x = LABEL_X - (continueButton.width * 0.5);			continueButton.y = pausedInfoLabel.y + pausedInfoLabel.height + BUTTON_SPACE_Y;						continueButton.addEventListener(MouseEvent.CLICK, continueButtonClicked);						stage..addChild(continueButton);		}				private function exitPausedState():void {						stage.removeChild(pausedLabel);			stage.removeChild(pausedInfoLabel);						continueButton.removeEventListener(MouseEvent.CLICK, continueButtonClicked);			stage.removeChild(continueButton);		}				private function enterGameOverState():void {			reset = true;						// Title			gameOverLabel = new Label();						//gameOverLabel.autoSize = TextFieldAutoSize.CENTER;			gameOverLabel.setStyle("textFormat", labelFormat);						gameOverLabel.text = "Game Over";						gameOverLabel.x = LABEL_X - (gameOverLabel.width * 0.5);			gameOverLabel.y = TOP_LABEL_Y - (gameOverLabel.height * 0.5);						stage.addChild(gameOverLabel);						// Text			gameOverInfoLabel = new Label();						gameOverInfoLabel.setStyle("textFormat", infoLabelFormat);						if (difficulty.distance <= 0) {				gameOverInfoLabel.text = "Win";			}			else {				gameOverInfoLabel.text = "Lose";			}						gameOverInfoLabel.x = LABEL_X - (gameOverInfoLabel.width * 0.5);			gameOverInfoLabel.y = gameOverLabel.y + gameOverLabel.height + BUTTON_SPACE_Y;						stage.addChild(gameOverInfoLabel);						// Again			playAgainButton = new Button();						playAgainButton.setStyle("textFormat", buttonFormat);						playAgainButton.label = "Play Again";						playAgainButton.x = LABEL_X - (playAgainButton.width * 0.5);			playAgainButton.y = gameOverInfoLabel.y + gameOverInfoLabel.height + BUTTON_SPACE_Y;						playAgainButton.addEventListener(MouseEvent.CLICK, playAgainButtonClicked);						stage.addChild(playAgainButton);		}				private function exitGameOverState():void {						stage.removeChild(gameOverLabel);			stage.removeChild(gameOverInfoLabel);						playAgainButton.removeEventListener(MouseEvent.CLICK, playAgainButtonClicked);			stage.removeChild(playAgainButton);		}				private function slave1Click(event:MouseEvent):void {						slaveMaster.doWhip(slave1, event.stageX, event.stageY);			slave1.doWhip();						if (slave1.isDead()) {								boat.removeItem(slave1);			    stage.removeChild(slave1);			    --slaveCount;								if (slaveCount <= 0) {					setCurrentState("GameOverState");				}			}		}				private function slave2Click(event:MouseEvent):void {						slaveMaster.doWhip(slave2, event.stageX, event.stageY);			slave2.doWhip();						if (slave2.isDead()) {								boat.removeItem(slave2);			    stage.removeChild(slave2);			    --slaveCount;								if (slaveCount <= 0) {					setCurrentState("GameOverState");				}			}		}				private function slave3Click(event:MouseEvent):void {						slaveMaster.doWhip(slave3, event.stageX, event.stageY);			slave3.doWhip();						if (slave3.isDead()) {								boat.removeItem(slave3);			    stage.removeChild(slave3);			    --slaveCount;								if (slaveCount <= 0) {					setCurrentState("GameOverState");				}			}		}				private function slave4Click(event:MouseEvent):void {						slaveMaster.doWhip(slave4, event.stageX, event.stageY);			slave4.doWhip();						if (slave4.isDead()) {								boat.removeItem(slave4);			    stage.removeChild(slave4);			    --slaveCount;								if (slaveCount <= 0) {					setCurrentState("GameOverState");				}			}		}				private function resumeTimers():void {			difficulty.resume();			drum.resume();			environment.resume();		}				private function pauseTimers():void {			difficulty.pause();			drum.pause();			environment.pause();		}				private function keyDownHandler(event:KeyboardEvent):void {						if (event.keyCode == Keyboard.ESCAPE) {				setCurrentState("GameOverState");			}			else if (String.fromCharCode(event.charCode) == "p") {				setCurrentState("PausedState");			}			else if (String.fromCharCode(event.charCode) == "z") {				drum.doLeftBeat();			}			else if (String.fromCharCode(event.charCode) == "x") {				drum.doRightBeat();			}					}				private function continueButtonClicked(event:MouseEvent):void {			setCurrentState("PlayState");		}				private function helpButtonClicked(event:MouseEvent):void {			setCurrentState("HelpState");		}				private function helpBackButtonClicked(event:MouseEvent):void {			setCurrentState("StartState");		}				private function creditsButtonClicked(event:MouseEvent):void {			setCurrentState("CreditsState");		}				private function creditsBackButtonClicked(event:MouseEvent):void {			setCurrentState("StartState");		}				private function playAgainButtonClicked(event:MouseEvent):void {			setCurrentState("StartState");		}				private function startButtonClicked(event:MouseEvent):void {			setCurrentState("PlayState");		}				public function setCurrentState(myState:String):void {						// Exit previous state			if (currentState == "StartState") {				this.exitStartState();			}			else if (currentState == "HelpState") {				this.exitHelpState();			}			else if (currentState == "CreditsState") {				this.exitCreditsState();			}			else if (currentState == "PlayState") {				this.exitPlayState();			}			else if (currentState == "PausedState") {				this.exitPausedState();			}			else if (currentState == "GameOverState") {				this.exitGameOverState();			}						// Set new state			currentState = myState;		    		    // Enter new state			if (currentState == "StartState") {				this.enterStartState();			}			else if (currentState == "HelpState") {				this.enterHelpState();			}			else if (currentState == "CreditsState") {				this.enterCreditsState();			}			else if (currentState == "PlayState") {				this.enterPlayState();			}			else if (currentState == "PausedState") {				this.enterPausedState();			}			else if (currentState == "GameOverState") {				this.enterGameOverState();			}		}				private function onStartSoundComplete(event:Event):void {						trace("Start sound loop");						// Play sound in loop			startChannel = startSound.play(0, 0, this.soundTransform);			startChannel.addEventListener(Event.SOUND_COMPLETE, onStartSoundComplete);		}		}}
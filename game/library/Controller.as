package game.library {

	import flash.display.*;
	import flash.events.*;
	import game.library.objects.*;

	public class Controller extends flash.display.MovieClip {

		private var slave;
		private var gameTimer;
		private var difficulty;
		private var gameState:String;

		//public objects
		public var renderer;
		public var music;
		public var drum;
		public var slaves;

		public function Controller() {
			slaves = new Array();
			difficulty = new Difficulty();

			//create and set renderer
			renderer = new Renderer();
			
			//create and add drummer
			drum = new Drum();
			drum.x = 400;
			drum.y = 150;
			drum.width = 75;
			drum.height = 127;
			renderer.addChild(drum);

			//set slaves
			var slaveHeight = 80;
			for (var i=0; i < difficulty.getNumSlaves(); i++) {
				slave = new Slave();
				slaves.push(slave);
				//renderer.addSlave(); //this is how it should be called

				slave.x = 190 + ( 100 * (i % 6) );
				if (i%6 == 0) {
					slaveHeight += 90;
				}
				slave.y = slaveHeight;
				renderer.addChild(slave);//this is the temporary solution
				slave.setSpeed(1);
			}
			music = new Music("");

			gameTimer = 0;
		}
		public function doUpdate():void {
			//trace(gameTimer);
			//renderer.doUpdate();
			gameTimer++;
		}
		//seconds
		public function getTimeRemaining():int {
			return difficulty.getTimeLimit() - gameTimer / 30;
		}
		public function getState():String {
			return "";
		}
		public function setState(myState:String) {
			this.gameState = myState;
			trace(this.gameState);
		}
		public function doBeat(e:Event):void {
			drum.doBeat(gameTimer);
		}
	}
}
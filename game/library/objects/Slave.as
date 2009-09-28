package game.library.objects {
	import flash.display.*;
	import flash.events.*;
	//import library.objects.*;
	
	public class Slave extends flash.display.MovieClip {
		// ------- Properties -------
      	public var slaveName:String;
		private var position:Position;
		private var type:String; //type descriptor of slave
		private var numWhips:int; //number of times whipped
		private var maxWhips:int; //maximum number of whips
		private var thirst:int; //thirst as a percentage
		private var morale:int; //percentage
		private var emotion:String; //enum for emotion
		private var output:int; //all factors considered what is the slaves output(contribution)
		private var speed:int; //in milliseconds per frame
		private var myHands:Hands;
			  
		//constructor
		public function Slave(initialName:String = "", initialPosition:Position = null, initialType:String = "") {
			//TODO
			myHands = new Hands();
			myHands.x = -68.3;
			myHands.y = -17.3;
			myHands.scaleX = 0.436;
			myHands.scaleY = 0.489;
			myHands.rotation = 8.5;
			this.addChild(myHands);
			this.setChildIndex(myHands, 0);
		}
		
		//GET FUNCTIONS
		public function getPosition():Position {
			//TODO
			return null;
		}
		public function getEmotion():String {
			//TODO
			return "";
		}
		public function getMorale():int {
			//TODO
			return 0;
		}
		public function getOutput():int {
			//TODO
			return 0;
		}
		public function getNumWhips():int {
			//TODO
			return 0;
		}
		public function getMaxWhips():int {
			//TODO
			return 0;
		}
		public function getName():String {
			//TODO
			return "";
		}
		public function getType():String {
			//TODO
			return "";
		}
		public function getThirst():int {
			//TODO
			return 0;
		}
		public function getSpeed():int {
			return this.speed;
		}
		
		//SET FUNCTIONS
		public function setPosition(myPosition:Position):void {
		}
		public function setEmotion(myEmotion:String):void {
		}
		public function setMorale(myMorale:int):void {
		}
		public function setOutput(myOutput:int):void {
		}
		public function setNumWhips(myNumWhips:int):void {
		}
		public function setSpeed(mySpeed:int):void {
			this.speed = mySpeed;
			myHands.setSpeed(this.speed);
		}
		/*
			remove thirst by supplied amount
			(slave automatically gets thirsty on its own)
		*/
		public function recoverThirst(myThirst:int):void {
		}
		
		public function doWhip() {
			trace("ouch! i got whipped...");
		}
	}
}
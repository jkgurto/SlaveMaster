package library.objects {
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
			  
		//constructor
		public function Slave(initialName:String = "", initialPosition:Position = null, initialType:String = "") {
			//TODO
		}
		
		//GET FUNCTIONS
		public function getPosition():Position {
			//TODO
			return null;
		}
		public function getEmotion():String {
			//TODO
			return null;
		}
		public function getMorale():int {
			//TODO
			return null;
		}
		public function getOutput():int {
			//TODO
			return null;
		}
		public function getNumWhips():int {
			//TODO
			return null;
		}
		public function getMaxWhips():int {
			//TODO
			return null;
		}
		public function getName():String {
			//TODO
			return null;
		}
		public function getType():String {
			//TODO
			return null;
		}
		public function getThirst():int {
			//TODO
			return null;
		}
		
		//SET FUNCTIONS
		public function setPosition(myPosition:Position):void {
			//TODO
			return null;
		}
		public function setEmotion(myEmotion:String):void {
			//TODO
			return null;
		}
		public function setMorale(myMorale:int):void {
			//TODO
			return null;
		}
		public function setOutput(myOutput:int):void {
			//TODO
			return null;
		}
		public function setNumWhips(myNumWhips:int):void {
			//TODO
			return null;
		}
		/*
			remove thirst by supplied amount
			(slave automatically gets thirsty on its own)
		*/
		public function recoverThirst(myThirst:int):void {
			//TODO
			return null;
		}
	}
}
﻿package game.library.objects {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	//import library.objects.*;
	
	public class Hands extends flash.display.MovieClip {
		
		//properties
		private var delay:int;
		private var timer:Timer
		
		public function Hands() {
			delay = 5; //default 5ms
			addEventListener(Event.ENTER_FRAME, startTimer);
			timer = new Timer(this.delay); //default 5ms
			timer.repeatCount = 0;
		}
		
		public function setSpeed(speed:int) {
			this.delay = speed;
		}
		
		private function timelineFaster(e:TimerEvent) {
			//'trace(arguments[0] + " " + arguments[1]);
			if(this.currentFrame == 80) {
				gotoAndPlay(1);
			} else {
				nextFrame();
			}
		}
		
		private function startTimer(e:Event) {
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, timelineFaster);
		}

	}
}
﻿package game.library.objects {        import flash.display.MovieClip;        import game.library.objects.Drum;    import game.library.objects.Slave;        public class Boat extends flash.display.MovieClip {                // Stores slaves for adding up speeds        private var store:Array = new Array();        private var _drum:Drum = null;                public function Boat() {        }                public function addItem(slave:Slave):void {            store.push(slave);        }                public function removeItem(slave:Slave):void {                        var index:int;            var found:Boolean = false;                        for (index = 0; index < store.length; ++index) {                                if (slave == store[index]) {                    found = true;                    break;                }            }                        if (found) {				// Remove from array                store.splice(index, 0);            }        }                public function set drum(value:Drum):void {            _drum = value;        }                public function get speed():Number {                        var speed:Number = 0;            var slave:Slave;                        for each (slave in store) {                                speed += slave.output;            }                        // TODO boost when rowing            /*            if (_drum != null) {                            //if (_drum.rowing) {                                        //var percent:Number = _drum.rowTimer.currentCount;                    //trace("percent: " + percent);                    //percent /= _drum.rowTimeS;                    //trace("percent: " + percent);                //}                                trace("speed: " + speed);            }            */                        return speed;        }    }}
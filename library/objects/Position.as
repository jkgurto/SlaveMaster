package library.objects {
	public class Position {
		
		private var xPosition = 0;
		private var yPosition = 0;
		
		public function Position(xPos:int, yPos:int) {
			this.xPosition = xPos;
			this.yPosition = yPos;
		}
		
		public function setPos(xPos:int, yPos:int) {
			this.xPosition = xPos;
			this.yPosition = yPos;
		}
		
		public function getPosX():int {
			return xPosition;
		}
		
		public function getPosY():int {
			return yPosition;
		}
	}
}
			
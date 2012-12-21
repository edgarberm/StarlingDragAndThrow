package  
{
  import starling.core.Starling;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class StarlingDragAndThrow extends Sprite 
	{
		private var mStarling:Starling;
		
		public function StarlingDragAndThrow() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			  
			mStarling = new Starling(DragAndThrow, stage);
			mStarling.antiAliasing = 1;
			mStarling.start();
			
			var stats:Stats = new Stats();
			this.addChild(stats);
		}
	}
}

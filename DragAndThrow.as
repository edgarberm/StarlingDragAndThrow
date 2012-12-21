package 
{
  import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	import flash.display.Bitmap;
	import flash.geom.Point;

	/**
	 * @author BuiltByEdgar
	 */

	public class DragAndThrow extends Sprite 
	{
		[Embed(source = "../assets/dragger.png")]
		private static var Dragger : Class;
		
		private var container : Sprite;
		private var dragger : Image;
		private var draggerTexture:Texture;
		private var draggerBmp:Bitmap;
		private var position : Point;
		public var xSpeed : Number = 0;
		public var ySpeed : Number = 0;
		private const STAGE_WIDTH : int = 1024;
		private const STAGE_HEIGHT : int = 768;
		private const SPEED_MULTIPLIER : int = 1;
		private const FRICTION : int = 1;	
		private var newY : Number = 0;
		private var oldY : Number = 0;
		private var newX : Number = 0;
		private var oldX : Number = 0;

		public function DragAndThrow() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event : Event) : void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			initialize();
		}

		private function initialize() : void 
		{
			container = new Sprite();
			this.addChild(container);

			draggerBmp = new Dragger();
			draggerTexture = Texture.fromBitmap(draggerBmp);
			dragger = new Image(draggerTexture);
			dragger.x = 500;
			dragger.y = 500;
			dragger.pivotX = 50;
			dragger.pivotY = 50;
			container.addChild(dragger);

			dragger.addEventListener(TouchEvent.TOUCH, touchHandler);
		}

		private function touchHandler(event : TouchEvent) : void 
		{
			var touch : Touch = event.getTouch(stage);
			position = touch.getLocation(this);

			if (touch.phase == TouchPhase.BEGAN ) 
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
				
				xSpeed = 0;
				ySpeed = 0;
			}

			if (touch.phase == TouchPhase.MOVED ) 
			{
				dragger.x = position.x;
				dragger.y = position.y;
				
				//Calculate velocity
				newY = position.y;
				ySpeed = newY - oldY;
				oldY = newY;

				newX = position.x;
				xSpeed = newX - oldX;
				oldX = newX;
			}

			if (touch.phase == TouchPhase.ENDED ) 
			{
				addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			}
		}
		
		//Detecting collisions
		private function onEnterFrameHandler(event : Event) : void 
		{
			dragger.x += xSpeed * (SPEED_MULTIPLIER / 3);
			dragger.y += ySpeed * (SPEED_MULTIPLIER / 3);

			xSpeed *= FRICTION;
			ySpeed *= FRICTION;

			if (dragger.x > STAGE_WIDTH - 50) 
			{
				dragger.x = STAGE_WIDTH - 50;
				xSpeed *= -1;
			} 
			else if (dragger.y > STAGE_HEIGHT - 50) 
			{
				dragger.y = STAGE_HEIGHT - 50;
				ySpeed *= -1;
			}
			if (dragger.x < 50) 
			{
				dragger.x = 50;
				xSpeed *= -1;
			} 
			else if (dragger.y < 50) 
			{
				dragger.y = 50;
				ySpeed *= -1;
			}
		}
	}
}

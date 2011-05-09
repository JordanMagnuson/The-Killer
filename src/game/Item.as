package game 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.ColorTween;
	import rooms.MyWorld;

	public class Item extends Entity
	{
		/**
		 * Distance can be "close", "mid", or "far", and determines the speed
		 * at which the item passes the player. close items are in front of the player.
		 */
		public var distance:String;
		
		/**
		 * Movement. 
		 * These variables are used so that items never travel less than one pixel
		 * per frame, which keeps slow-moving items in sync. 
		 * See http://flashpunk.net/forums/index.php?topic=672.0
		 */
		public var moveDist:Number = 0;
		public var moveCounter:Number = 0;		
		public var offScreen:Boolean = false;
		
		/**
		 * Graphics
		 */
		public var rawSprite:Class;
		public var image:Image;		
		public var spriteMap:Spritemap;
		
		/**
		 * Whether this item can overlap others of its type.
		 * If not, it is removed from the world if overlapping.
		 */
		public var overlap:Boolean;
		
		public var fadeTween:ColorTween;	
		public var waitToFadeAlarm:Alarm;
		public var fading:Boolean = false;		
		
		/**
		 * 
		 * @param	imageSource		Raw image data for this item.
		 * @param	distance		'close', 'mid', or 'far'.
		 * @param	overlap			Whether it's okay for this item to overlap itself. 
		 */
		public function Item(imageSource:* = null, distance:String = 'mid', overlap:Boolean = true) 
		{
			this.distance = distance;			
			this.overlap = overlap;
			image = new Image(imageSource);	
			if (FP.random > 0.5)
			{
				image.flipped = true;
			}			
			graphic = image;
			
			// Hit box to bottom left, so we can place all items at same starting location
			image.originX = 0;
			image.originY = image.height;
			image.x = 0;
			image.y = -image.originY;	
			
			setHitbox(image.width, image.height, image.originX, image.originY);				
			
			// Create every item at the far right edge of the screen
			x = FP.screen.width + 10;
			y = Ground.y;		
			
			// Layer
			switch (distance)
			{
				case 'close':
					layer = FP.choose(-100, -101);
					break;
				case 'mid':
					layer = FP.choose(10, 11);
					break;
				case 'far':
					layer = FP.choose(100, 101);
					break;
			}
		}
		
		/**
		 * When an item is added to the world, check to see if it can overlap 
		 * others of its type. If not, and it is overlapping, remove it.
		 */
		override public function added():void
		{
			super.added();
			if (overlap == false)
			{
				if (this.collide(this.type, x, y))
				{
					FP.world.remove(this);
				}
			}			
		}
		
		override public function update():void 
		{
			super.update();
			
			if (fading)
			{
				image.alpha = fadeTween.alpha;	
				if (spriteMap) spriteMap.alpha = fadeTween.alpha;
			}
			
			// Destroy when off screen
			if (x < (0 - image.width) && !offScreen)
			{
				offScreen = true;
				offScreenAction();
			}
			
			// Item speed
			if (Global.player.walking)
			{
				switch (distance)
				{
					case 'mid':
						// Move mid distance objects exacly 1 pixel every other frame.
						if (MyWorld.oddFrame == 1)
						{
							x -= FP.rate * (Global.WALKING_SPEED / 100);
						}
						break;
					case 'close':
						// Move close distance objects exacly 1 pixel every frame.
						x -= FP.rate * (Global.WALKING_SPEED / 100);
						break;				
					case 'far':
						// Move close distance objects exacly 1 pixel every 3rd frame.
						if (MyWorld.thirdFrame == 1)
						{
							x -= FP.rate * (Global.WALKING_SPEED / 100);
						}
						break;										
				}
			}
		}		
		
		public function waitToFade(duration:Number = 3):void
		{
			waitToFadeAlarm = new Alarm(duration, fadeOutImage);
			addTween(waitToFadeAlarm, true);
		}
		
		public function fadeOutImage(duration:Number = 10):void
		{
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(duration, Colors.WHITE, Colors.WHITE, 1, 0);	
			fading = true;
		}
		
		public function offScreenAction():void
		{
			destroy();
		}
		
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
		/**
		 * Choose an image randomly from an array of sprite references
		 * @param	collection	An array of raw sprite references like private const PLAYER:Class;
		 * @return	A sprite chosen at random.
		 */
		public function chooseSprite(collection: Array): Class
		{
			var rand: int = collection.length * Math.random();

			return collection[rand];
		}		
		
	}

}
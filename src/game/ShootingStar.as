package game 
{
	import flash.display.ColorCorrection;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.FP;	

	public class ShootingStar extends Entity
	{
		public const MIN_SPEED:Number = 75;
		public const MAX_SPEED:Number = 150;
		public var speed:Number;
		
		public const FADE_IN_DURATION:Number = 0.5;
		public const FADE_OUT_DURATION:Number = 0.5;
		
		public const MAX_Y:int = 132;
		
		// Life time does not include fade out, but DOES include fade in
		public const MAX_LIFE:Number = 1.3;
		public const MIN_LIFE:Number = 0.5;
		
		/**
		 * Graphic
		 */
		[Embed(source='../../assets/shooting_star.png')] private const SPRITE:Class;
		public var image:Image = new Image(SPRITE);		
		
		public var fadeTween:ColorTween;
		
		public var lifeDuration:Number;
		public var lifeAlarm:Alarm;
		public var maxAlpha:Number;
		public var direction:int;
		
		/**
		 * 
		 * @param	direction	-1, or 1
		 */
		public function ShootingStar(direction:int = 1) 
		{
			// Image
			graphic = image;
			this.direction = direction;
			if (direction == 1)
			{
				image.flipped = true;
			}
			layer = 499;
			image.alpha = 0;
			
			// Luminance
			maxAlpha = 0.6 + FP.random * 0.4;
			
			// Starting position
			x = -image.width + int(FP.random * (FP.screen.width + 2*image.width));
			y = int(FP.random * MAX_Y);
			
			// Speed
			speed = MIN_SPEED + FP.random * (MAX_SPEED - MIN_SPEED);
			
			// Lifetime
			lifeDuration = MIN_LIFE + FP.random * (MAX_LIFE - MIN_LIFE);
			lifeAlarm = new Alarm(lifeDuration, fadeOut);
			addTween(lifeAlarm);
			lifeAlarm.start();
			
			// Start
			fadeIn();
		}
		
		override public function update():void
		{
			super.update();
			(graphic as Image).alpha = fadeTween.alpha;
			x += direction * speed * FP.elapsed;
		}
		
		public function fadeIn():void
		{
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, maxAlpha);
		}		
		
		public function fadeOut():void
		{
			clearTweens();
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(FADE_OUT_DURATION, Colors.WHITE, Colors.WHITE, image.alpha, 0);
		}			
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
	}

}
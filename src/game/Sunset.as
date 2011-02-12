package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image
	import flash.display.BlendMode;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.tweens.misc.Alarm;
	import rooms.MyWorld;

	public class Sunset extends Entity
	{
		/**
		 * Note that DURATION does not include fade out time.
		 */
		public const DURATION:int = 10;
		public const FADE_IN_DURATION:Number = 10;
		public const FADE_OUT_DURATION:Number = 20;
		public const MAX_ALPHA:Number = 0.8;
		
		public var fadeTween:ColorTween;
		public var durationAlarm:Alarm = new Alarm(DURATION, complete);		
		
		/**
		 * Image
		 */
		[Embed(source = '../../assets/sunset_cover.png')] private const SPRITE:Class;	
		public var image:Image = new Image(SPRITE);		
		
		public function Sunset() 
		{
			(FP.world as MyWorld).time = 'sunset';
			layer = -999;
			image.blend = BlendMode.MULTIPLY;
			image.alpha = 0;
			graphic = image;		
			if ((FP.world as MyWorld).soundController)
				(FP.world as MyWorld).soundController.startNight();
		}
		
		override public function added():void
		{
			trace('Sunset started');
			addTween(durationAlarm);
			durationAlarm.start();
			fadeIn();
		}
		
		override public function update():void
		{
			super.update();
			(graphic as Image).alpha = fadeTween.alpha;
		}
		
		public function fadeIn():void
		{
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, MAX_ALPHA);
		}		
		
		public function fadeOut():void
		{
			trace('starting sunset fade out');
			removeTween(fadeTween);
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(FADE_OUT_DURATION, Colors.WHITE, Colors.WHITE, image.alpha, 0);			
		}
		
		public function complete():void
		{
			FP.world.add(new Night);
			fadeOut();
		}
		
		/**
		 * Removes night from the world
		 */
		public function destroy():void
		{
			FP.world.remove(this);
		}		
	}
}
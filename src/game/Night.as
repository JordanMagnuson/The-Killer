package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image
	import flash.display.BlendMode;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import rooms.MyWorld;

	public class Night extends Entity
	{
		/**
		 * Note that DURATION does not include fade out time.
		 */		
		public static const DURATION:int = 30;
		public static const FADE_IN_DURATION:Number = 6;
		public static const FADE_OUT_DURATION:Number = 10;
		public static const MAX_ALPHA:Number = 0.7;
		
		public var fadeTween:ColorTween;
		public var durationAlarm:Alarm = new Alarm(DURATION, complete);	
		
		public var shouldFadeIn:Boolean;
		
		public var stars:Stars;
		
		/**
		 * Image
		 */
		[Embed(source = '../../assets/night_cover.png')] private const SPRITE:Class;	
		public var image:Backdrop = new Backdrop(SPRITE);
		//public var image:Image = new Image(SPRITE);		
		
		public function Night(world:World = null, shouldFadeIn:Boolean = true) 
		{
			this.shouldFadeIn = shouldFadeIn;
			if (world)
				(world as MyWorld).time = 'night';
			else
				(FP.world as MyWorld).time = 'night';
			layer = -999;
			image.blend = BlendMode.MULTIPLY;
			graphic = image;		
			graphic.scrollX = 0;
			graphic.scrollY = 0;
			
			if (shouldFadeIn)
				image.alpha = 0;
			else
				image.alpha = MAX_ALPHA;		
		}
		
		override public function added():void
		{
			addTween(durationAlarm);
			durationAlarm.start();
			if (shouldFadeIn)
			{
				fadeIn();
			}
			else 
			{
				FP.world.add(stars = new Stars(false));
				fadeTween = new ColorTween();
				addTween(fadeTween);		
				fadeTween.alpha = MAX_ALPHA;
				//fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, MAX_ALPHA);						
			}
		}
		
		override public function update():void
		{
			//x = FP.camera.x;
			//y = FP.camera.y;
			super.update();
			(graphic as Backdrop).alpha = fadeTween.alpha;
		}
		
		public function fadeIn():void
		{
			FP.world.add(stars = new Stars);
			stars.fadeIn();
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, MAX_ALPHA);				
		}		
		
		public function fadeOut():void
		{
			trace('starting fade out');
			stars.fadeOut();
			removeTween(fadeTween);
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(FADE_OUT_DURATION, Colors.WHITE, Colors.WHITE, image.alpha, 0);			
		}
		
		public function complete():void
		{
			if (Global.shotFired || Global.exploded)
				return;
			FP.world.add(new Day(FP.world));
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
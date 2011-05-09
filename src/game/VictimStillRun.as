package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class VictimStillRun extends Entity
	{
		[Embed(source='../../assets/victim_running_sheet.png')] private const VICTIM:Class;
		public var spritemap:Spritemap = new Spritemap(VICTIM, 20, 20);	
		
		public var shouldFadeIn:Boolean = true;
		
		public static const FADE_IN_DURATION:Number = 2;
		public static const FADE_OUT_DURATION:Number = 2;
		public var fadeTween:ColorTween;		
		
		public var displayAlarm:Alarm;
		
		public function VictimStillRun(x:Number, imageNumber:int, displayTime:Number, shouldFadeIn:Boolean = true) 
		{
			spritemap.add('stand', [imageNumber], 20, false);
			spritemap.play('stand');
			graphic = spritemap;
			
			displayAlarm = new Alarm(displayTime, fadeOut);
			
			if (this.shouldFadeIn = shouldFadeIn)
				spritemap.alpha = 0;
			
			// Hit box
			spritemap.originX = 0;
			spritemap.originY = spritemap.height;
			spritemap.x = 0;
			spritemap.y = -spritemap.originY;	
			
			setHitbox(spritemap.width, spritemap.height, spritemap.originX, spritemap.originY);				
			
			// Location
			this.x = x;
			y = Ground.y;			
		}
		
		override public function added():void
		{
			if (shouldFadeIn)
				fadeIn();
			else
			{
				fadeTween = new ColorTween(stayIn);
				addTween(fadeTween);		
				fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 1, 1);	
			}
		}
		
		override public function update():void
		{
			spritemap.alpha = fadeTween.alpha;
			super.update();
		}
		
		public function fadeIn():void
		{
			fadeTween = new ColorTween(stayIn);
			addTween(fadeTween);		
			fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, 1);			
		}
		
		public function stayIn():void
		{
			addTween(displayAlarm, true);
		}
		
		public function fadeOut():void
		{
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(FADE_OUT_DURATION, Colors.WHITE, Colors.WHITE, 1, 0);				
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
	}

}
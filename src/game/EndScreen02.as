package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.ColorTween;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class EndScreen02 extends Entity
	{
		public static const FADE_IN_DURATION:Number = 3;
		public static const FADE_OUT_DURATION:Number = 3;		
		public var fadeTween:ColorTween;	
		
		public function EndScreen02() 
		{
			graphic = new Image(Assets.END_SCREEN_02);
		}
		
		override public function added():void
		{
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
			fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, 1);
		}	
		
	}

}
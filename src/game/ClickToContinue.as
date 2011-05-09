package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.utils.Input;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class ClickToContinue extends Entity
	{
		public static const FADE_IN_DURATION:Number = 3;
		public static const FADE_OUT_DURATION:Number = 3;
		public var fadeTween:ColorTween;		
		
		public function ClickToContinue() 
		{
			graphic = new Image(Assets.CLICK_TO_CONTINUE_BLACK);

			(graphic as Image).originX = (graphic as Image).width / 2;
			(graphic as Image).originY = (graphic as Image).height / 2;
			(graphic as Image).x = -(graphic as Image).originX;
			(graphic as Image).y = -(graphic as Image).originY;		
			setHitbox((graphic as Image).width - 1, (graphic as Image).height - 1, (graphic as Image).originX, (graphic as Image).originY);					
			
			(graphic as Image).alpha = 0;
			
			y = FP.halfHeight;
			x = FP.halfWidth;
		}
		
		override public function added():void
		{
			fadeIn();
		}			
		
		override public function update():void
		{
			(graphic as Image).alpha = fadeTween.alpha;
			
			if (fadeTween.alpha >= 0.5)
				Mouse.show();
			
			if (Input.mouseReleased)
			{
				switch (Global.endScreen++)
				{
					case 0:
						FP.world.add(new FadeIn);
						FP.world.add(new Entity(0, 0, new Image(Assets.END_SCREEN_02)));
						FP.world.remove(this);
						break;
					case 1:
						FP.world.add(new FadeIn);
						FP.world.add(new Entity(0, 0, new Image(Assets.END_SCREEN_03)));
						FP.world.remove(this);
						break;						
				}
			}
		}
		
		public function fadeIn():void
		{
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, 1);
		}				
		
	}

}
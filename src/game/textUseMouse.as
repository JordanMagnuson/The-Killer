package game 
{
	import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.ColorTween;
	
	public class textUseMouse extends Entity
	{		
		public static const FADE_IN_DURATION:Number = 3;
		public static const FADE_OUT_DURATION:Number = 3;

		public static var text:Text;
		public static var fadeTween:ColorTween;
		
		public var fadeInAlarm:Alarm = new Alarm(3, fadeIn);
		public var fadeOutAlarm:Alarm = new Alarm(1, fadeOut);		
		
		public var started:Boolean = false;
		
		public function textUseMouse() 
		{
			text = new Text("Use the mouse to aim.");
			text.size = 8;
			text.alpha = 0;
			graphic = text;			
			x = 20;
			y = 130;
			fadeTween = new ColorTween();
			fadeTween.alpha = 0;
		}	
		
		override public function added():void
		{
			addTween(fadeInAlarm, true);
		}
		
		override public function update():void
		{
			super.update();
			text.alpha = fadeTween.alpha;
			
			if (Global.shotFired && !started)
			{
				started = true;
				FP.world.addTween(fadeOutAlarm);
				fadeOutAlarm.start();
			}
		}
		
		public function nextText():void
		{
			FP.world.add(new textLetGo(this));
		}
		
		public function fadeIn():void
		{
			if (Global.shotFired)
				return;
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, 1);
		}				
		
		public function fadeOut():void
		{
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(FADE_OUT_DURATION, Colors.WHITE, Colors.WHITE, text.alpha, 0);				
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
	}

}
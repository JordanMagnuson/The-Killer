package game 
{
	import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.ColorTween;
	
	public class textJordan extends Entity
	{		
		public static const FADE_IN_DURATION:Number = 3;		
		public static const FADE_OUT_DURATION:Number = 3;

		public static var text:Text;
		public static var fadeTween:ColorTween;
		
		public static var nextTextAlarm:Alarm;
		
		public static var started:Boolean = false;
		
		public function textJordan() 
		{
			text = new Text("Jordan Magnuson presents:");
			text.size = 8;
			text.alpha = 0;
			graphic = text;			
			x = 20;
			y = 100;
			nextTextAlarm = new Alarm(2, nextText);
		}	
		
		override public function added():void
		{
			fadeIn();
			FP.world.addTween(nextTextAlarm);
			nextTextAlarm.start();			
		}			
		
		override public function update():void
		{
			super.update();
			text.alpha = fadeTween.alpha;
		}
		
		public function nextText():void
		{
			FP.world.add(new textWalkOrDie(this));
		}
		
		public function fadeIn():void
		{
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, 1);
		}				
		
		public function fadeOut():void
		{
			removeTween(fadeTween);
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
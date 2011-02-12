package game 
{
	import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.ColorTween;
	
	public class textPress extends Entity
	{		
		public static const FADE_OUT_DURATION:Number = 3;

		public static var text:Text;
		public static var fadeTween:ColorTween;
		
		public static var nextTextAlarm:Alarm;
		
		public static var started:Boolean = false;
		
		public function textPress() 
		{
			text = new Text("Hold space to start walking.");
			text.size = 8;
			graphic = text;			
			x = 20;
			y = 100;
			fadeTween = new ColorTween();
			fadeTween.alpha = 1;
			nextTextAlarm = new Alarm(2, nextText);
		}	
		
		override public function update():void
		{
			super.update();
			text.alpha = fadeTween.alpha;
			
			if (Global.player.walking && started == false)
			{
				started = true;
				FP.world.addTween(nextTextAlarm);
				nextTextAlarm.start();
			}
		}
		
		public function nextText():void
		{
			FP.world.add(new textLetGo(this));
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
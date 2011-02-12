package game 
{
	import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.graphics.Text;
	
	public class textWalkOrDie extends Entity
	{		
		public var text:Text;
		public static const FADE_IN_DURATION:Number = 3;
		public static const FADE_OUT_DURATION:Number = 3;
		public var fadeTween:ColorTween;
		
		public var nextTextAlarm:Alarm
		
		public var started:Boolean = false;
		
		public var prevText:Entity;
		
		public function textWalkOrDie(prevText:Entity) 
		{
			this.prevText = prevText;
			text = new Text("Walk or Die");
			text.size = 8;
			text.alpha = 0;
			graphic = text;			
			x = 145;
			y = 100;
		}
		
		override public function added():void
		{
			fadeIn();
			nextTextAlarm = new Alarm(5, fadeOut);
			FP.world.addTween(nextTextAlarm);
			nextTextAlarm.start();
		}		
		
		override public function update():void
		{
			super.update();
			text.alpha = fadeTween.alpha;
		}
		
		public function fadeIn():void
		{
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, 1);
		}				
		
		public function fadeOut():void
		{
			//trace('starting fade out');
			(prevText as textJordan).fadeOut();
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
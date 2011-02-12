package game 
{
	import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.graphics.Text;
	import rooms.MyWorld;
	
	public class textLetGo extends Entity
	{		
		public var text:Text;
		public static const FADE_IN_DURATION:Number = 3;
		public static const FADE_OUT_DURATION:Number = 3;
		public var fadeTween:ColorTween;
		
		public var nextTextAlarm:Alarm = new Alarm(1);
		
		public var started:Boolean = false;
		
		public var prevText:Entity;
		
		public function textLetGo(prevText:Entity) 
		{
			this.prevText = prevText;
			text = new Text("Don't let go.");
			text.size = 8;
			text.alpha = 0;
			graphic = text;			
			x = 145;
			y = 100;
		}
		
		override public function added():void
		{
			fadeIn();
		}		
		
		override public function update():void
		{
			super.update();
			text.alpha = fadeTween.alpha;
		}
		
		public function fadeIn():void
		{
			fadeTween = new ColorTween(fadeOut);
			addTween(fadeTween);		
			fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, 1);
		}				
		
		public function fadeOut():void
		{
			//trace('starting fade out');
			(prevText as textPress).fadeOut();
			removeTween(fadeTween);
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(FADE_OUT_DURATION, Colors.WHITE, Colors.WHITE, 1, 0);			
		}
		
		public function destroy():void
		{
			(FP.world as MyWorld).titleTextAlarm = new Alarm(2, (FP.world as MyWorld).showTitle);
			FP.world.addTween((FP.world as MyWorld).titleTextAlarm);
			(FP.world as MyWorld).titleTextAlarm.start();
			FP.world.remove(this);
		}
		
	}

}
package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class VictimStillRunController extends Entity
	{
		public const DISPLAY_EACH_DURATION:Number = 0.5;
		public const TIME_BETWEEN_EACH:Number = 3;
		public const DISTANCE_BETWEEN_EACH:Number = 45;
		
		public var imageIndex:int = 1;
		public var showNextAlarm:Alarm = new Alarm(TIME_BETWEEN_EACH, showNext);
		//public var alarm01:Alarm = new Alarm(3, showNext);
		
		public function VictimStillRunController(x:Number = 130) 
		{
			this.x = x;
		}
		
		override public function added():void
		{
			FP.world.add(new VictimStillRun(x, imageIndex, DISPLAY_EACH_DURATION));
			addTween(showNextAlarm, true);
		}
		
		public function showNext():void
		{
			x += DISTANCE_BETWEEN_EACH;
			imageIndex += 1;
			if (imageIndex == 4) imageIndex = 0;
			FP.world.add(new VictimStillRun(x, imageIndex, DISPLAY_EACH_DURATION));
			showNextAlarm.reset(TIME_BETWEEN_EACH);
		}
		
	}

}
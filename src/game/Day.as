package game 
{
	import flash.net.IDynamicPropertyWriter;
	import net.flashpunk.Entity;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import rooms.MyWorld;

	public class Day extends Entity
	{
		/**
		 * Duration in seconds
		 */
		public const DURATION:int = 45;
		
		public var durationAlarm:Alarm = new Alarm(DURATION, complete);
		
		public function Day(world:World, changeSound:Boolean = true) 
		{
			(world as MyWorld).time = 'day';
			addTween(durationAlarm);
			durationAlarm.start();
			if (changeSound && (world as MyWorld).soundController)
			{
				(world as MyWorld).soundController.startDay();
			}
		}
		
		public function complete():void
		{
			FP.world.add(new Sunset);
			FP.world.remove(this);
		}
		
	}

}
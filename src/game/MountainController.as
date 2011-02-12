package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.Alarm;
	import game.MyAlarm;
	
	/**
	 * Class that controls how frequently mountains are released.
	 */
	public class MountainController extends Entity
	{	
		/**
		 * How mountain release rate changes
		 */
		public const MAX_MOUNTAIN_RELEASE_TIME:Number = 20;
		public const MIN_MOUNTAIN_RELEASE_TIME:Number = 0.5;
		public const MOUNTAIN_DENSITY_CHANGE_RATE:Number = 0.5;
		public const MOUNTAIN_DENSITY_CHANGE_TIME:Number = 5;
		
		/**
		 * When a mountain is released
		 */
		public var mountainReleaseTime:Number = 1;
		public var mountainAlarm:MyAlarm;
		
		/**
		 * Whether cloud cover is increasing or decreasing. 0, 1, or -1.
		 */
		public var mountainDensitySlope:int = 0;
		public var mountainDensityAlarm:Alarm;	
		
		public function MountainController() 
		{
			mountainReleaseTime = int(MIN_MOUNTAIN_RELEASE_TIME + FP.random * (MAX_MOUNTAIN_RELEASE_TIME - MIN_MOUNTAIN_RELEASE_TIME));
			mountainDensitySlope = FP.choose(1, -1);
			
			mountainAlarm = new MyAlarm(mountainReleaseTime, releaseMountain);
			addTween(mountainAlarm);
			mountainAlarm.start();
			
			mountainDensityAlarm = new Alarm(MOUNTAIN_DENSITY_CHANGE_TIME, changeMountainDensity);
			addTween(mountainDensityAlarm);
			mountainDensityAlarm.start();
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		public function releaseMountain():void
		{
			//trace('release cloud');
			mountainAlarm.reset(mountainReleaseTime);
			FP.world.add(new Mountain);
		}
		
		public function changeMountainDensity():void
		{
			//trace('Change Mountain density. Slope: ' + mountainDensitySlope);
			//trace('mountainReleaseTime: ' + mountainReleaseTime);
			mountainDensityAlarm.reset(MOUNTAIN_DENSITY_CHANGE_TIME);
			switch (mountainDensitySlope)
			{
				case 1:
					// Change mountain release time
					if (mountainReleaseTime > MIN_MOUNTAIN_RELEASE_TIME)
					{
						mountainReleaseTime -= MOUNTAIN_DENSITY_CHANGE_RATE;
					}
					// Change slope?
					if (mountainReleaseTime < MIN_MOUNTAIN_RELEASE_TIME * 3)
					{
						if (FP.random > 0.8)
						{
							//trace('Changing mountain density slope from 1 to -1');
							mountainDensitySlope = -1;
						}
					}
					break;
				case -1:
				default:
					// Change mountain release time
					if (mountainReleaseTime < MAX_MOUNTAIN_RELEASE_TIME)
					{
						mountainReleaseTime += MOUNTAIN_DENSITY_CHANGE_RATE;
					}
					// Change slope?				
					if (mountainReleaseTime > MAX_MOUNTAIN_RELEASE_TIME * 0.6)
					{
						if (FP.random > 0.8)
						{
							//trace('Changing mountain density slope from -1 to 1');
							mountainDensitySlope = 1;
						}		
					}
					break;
					
				if (mountainReleaseTime < MIN_MOUNTAIN_RELEASE_TIME)
				{
					mountainReleaseTime = MIN_MOUNTAIN_RELEASE_TIME;
				}
				else if (mountainReleaseTime > MAX_MOUNTAIN_RELEASE_TIME)
				{
					mountainReleaseTime = MAX_MOUNTAIN_RELEASE_TIME;
				}
			}
		}
	}
}
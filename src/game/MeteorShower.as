package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	
	public class MeteorShower extends Entity
	{
		public static var SEEN:Boolean = false;
		
		public const MAX_SHOOTING_STARS:int = 55;
		public const MIN_SHOOTING_STARS:int = 30;
		public var numOfStars:int;		
		
		public const MIN_TIME_BETWEEN:Number = 0.1;
		public const MAX_TIME_BETWEEN:Number = 0.7;
		public var timeBetween:Number;
		
		public var direction:int;
		
		public var releaseAlarm:Alarm;
		
		public var starsReleased:int = 0;
		
		public function MeteorShower() 
		{
			
			numOfStars = MIN_SHOOTING_STARS + int(FP.random * (MAX_SHOOTING_STARS - MIN_SHOOTING_STARS));
			trace('stars to release: ' + numOfStars);
			direction = FP.choose(-1, 1);
		}
		
		override public function added():void
		{
			changeTimeBetween();
			releaseAlarm = new Alarm(timeBetween, releaseStar);
			addTween(releaseAlarm);
			releaseAlarm.start();
		}
		
		public function releaseStar():void
		{
			starsReleased += 1;
			trace('stars released: ' + starsReleased);
			FP.world.add(new ShootingStar(direction));
			if (starsReleased < numOfStars)
			{
				changeTimeBetween();
				releaseAlarm.reset(timeBetween);
			}
			else
			{
				FP.world.remove(this);
			}
		}
		
		public function changeTimeBetween():void
		{
			timeBetween = MIN_TIME_BETWEEN + FP.random * (MAX_TIME_BETWEEN - MIN_TIME_BETWEEN);
		}
		
	}

}
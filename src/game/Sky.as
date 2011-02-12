package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.Alarm;
	
	public class Sky extends Entity
	{	
		/**
		 * How cloud release rate changes
		 */
		public const MAX_CLOUD_RELEASE_TIME:Number = 10;
		public const MIN_CLOUD_RELEASE_TIME:Number = 0.5;
		public const CLOUD_COVER_CHANGE_RATE:Number = 0.5;
		public const CLOUD_COVER_CHANGE_TIME:Number = 5;
		
		/**
		 * When a cloud is released
		 */
		public var cloudReleaseTime:Number = 1;
		public var cloudAlarm:Alarm;
		
		/**
		 * Whether cloud cover is increasing or decreasing. 0, 1, or -1.
		 */
		public var cloudCoverSlope:int = 0;
		public var cloudCoverAlarm:Alarm;
		
		/**
		 * Ground graphic
		 */
		[Embed(source = '../../assets/sky.png')] private const SKY:Class;
		public var image:Image = new Image(SKY);		
		
		public function Sky() 
		{
			cloudReleaseTime = int(MIN_CLOUD_RELEASE_TIME + FP.random * (MAX_CLOUD_RELEASE_TIME - MIN_CLOUD_RELEASE_TIME));
			cloudCoverSlope = FP.choose(1, -1);
			
			graphic = image;
			layer = 999;
			cloudAlarm = new Alarm(cloudReleaseTime, releaseCloud);
			addTween(cloudAlarm);
			cloudAlarm.start();
			
			cloudCoverAlarm = new Alarm(CLOUD_COVER_CHANGE_TIME, changeCloudCover);
			addTween(cloudCoverAlarm);
			cloudCoverAlarm.start();
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		public function releaseCloud():void
		{
			//trace('release cloud');
			cloudAlarm.reset(cloudReleaseTime);
			FP.world.add(new Cloud);
		}
		
		public function changeCloudCover():void
		{
			//trace('Change cloud cover. Slope: ' + cloudCoverSlope);
			//trace('cloudReleaseTime: ' + cloudReleaseTime);
			cloudCoverAlarm.reset(CLOUD_COVER_CHANGE_TIME);
			switch (cloudCoverSlope)
			{
				case 1:
					// Change cloud release time
					if (cloudReleaseTime > MIN_CLOUD_RELEASE_TIME)
					{
						cloudReleaseTime -= CLOUD_COVER_CHANGE_RATE;
					}
					// Change slope?
					if (cloudReleaseTime < MIN_CLOUD_RELEASE_TIME * 3)
					{
						if (FP.random > 0.8)
						{
							//trace('Changing cloud cover slope from 1 to -1');
							cloudCoverSlope = -1;
						}
					}
					break;
				case 0:
					// Change slope down
					if (FP.choose(1, 2) == 1)
					{
						if (FP.random > 0.6)
						{
							//trace('Changing cloud cover slope from 0 to -1');
							cloudCoverSlope = -1;
						}
					}
					// Change slope up
					else
					{
						if (FP.random > 0.8)
						{
							//trace('Changing cloud cover slope from 0 to 1');
							cloudCoverSlope = 1;
						}						
					}
					break;
				case -1:
					// Change cloud release time
					if (cloudReleaseTime < MAX_CLOUD_RELEASE_TIME)
					{
						cloudReleaseTime += CLOUD_COVER_CHANGE_RATE;
					}
					// Change slope?				
					if (cloudReleaseTime > MAX_CLOUD_RELEASE_TIME * 0.6)
					{
						if (FP.random > 0.8)
						{
							//trace('Changing cloud cover slope from -1 to 1');
							cloudCoverSlope = 1;
						}		
					}
					break;
					
				if (cloudReleaseTime < MIN_CLOUD_RELEASE_TIME)
				{
					cloudReleaseTime = MIN_CLOUD_RELEASE_TIME;
				}
				else if (cloudReleaseTime > MAX_CLOUD_RELEASE_TIME)
				{
					cloudReleaseTime = MAX_CLOUD_RELEASE_TIME;
				}
			}
		}
	}
}
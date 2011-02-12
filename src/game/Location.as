package game 
{
	import game.Item;
	import game.MyAlarm;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import game.Player;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;	
	import net.flashpunk.World;
	import rooms.MyWorld;

	public class Location extends Entity
	{
		/**
		 * Creation time is the amount of time between items being created in a location.
		 * As it varies, the "density" of items varies.
		 */
		public var maxCreationTime:Number;
		public var minCreationTime:Number;
		
		public var creationTimeIncreaseRate:Number;
		public var creationTimeDecreaseRate:Number;
		
		public var creationTime:Number;
		public var creationTimeAlarm:MyAlarm;
		
		/**
		 * Ambient sound
		 */
		public var daySound:Sfx;
		public var nightSound:Sfx;
		public var sound:Sfx;
		
		/**
		 * Determines wether density is increasing or decreasing or steady
		 * -1 = decreasing
		 * 0 = steady
		 * 1 = increasing
		 */
		public var creationTimeSlope:int = 1;
		
		public function Location(DAY_SOUND:Class, NIGHT_SOUND:Class, maxCreationTime:Number = 4, minCreationTime:Number = 0.5, creationTimeIncreaseRate:Number = 0.4, creationTimeDecreaseRate:Number = 0.4) 
		{
			daySound = new Sfx(DAY_SOUND);
			nightSound = new Sfx(NIGHT_SOUND);
			
			this.maxCreationTime = (maxCreationTime / (Global.WALKING_SPEED / 100));
			this.minCreationTime = (minCreationTime / (Global.WALKING_SPEED / 100));
			this.creationTimeIncreaseRate = (creationTimeIncreaseRate * (Global.WALKING_SPEED / 100));
			this.creationTimeDecreaseRate = (creationTimeDecreaseRate * (Global.WALKING_SPEED / 100));

			creationTime = maxCreationTime;
			creationTimeAlarm = new MyAlarm(creationTime, createItem);
			addTween(creationTimeAlarm);
			creationTimeAlarm.start();
		}
		
		override public function added():void
		{
			
		}
		
		override public function update():void
		{
			super.update();
		}
		
		public function createItem():void
		{		
			// Change the creation time, depending on whether items are
			// becoming more or less dense.
			if (FP.random > 0.25)
			{
				switch (creationTimeSlope)
				{
					case -1:
						if (creationTime < maxCreationTime)
						{
							creationTime += creationTimeIncreaseRate;
							if (creationTime > maxCreationTime)
							{
								creationTime = maxCreationTime;
							}							
						}
						break;
					case 1:
						if (creationTime > minCreationTime)
						{
							creationTime -= creationTimeDecreaseRate;
							if (creationTime < minCreationTime)
							{
								creationTime = minCreationTime;
							}
						}
						break;
					case 0:
						break;
				}
			}
			//trace('Create item. creationTime: ' + creationTime);
			creationTimeAlarm.reset(creationTime);
		}
		
		/**
		 * Stuff to set up at the beginning of the game. Override
		 * this function in each location.
		 * @param	world	Current world.
		 */
		public function gameStart(world:World):void
		{
			
		}
		
		/**
		 * Set up if this location is starting location.
		 * Called via super() from each location.
		 * @param	item	Item to place in the starting scene.
		 */
		public function gameStartItem(world:World, item:Item):void
		{
			var myItem:Item = item;	
			myItem.x = 150;				
			world.add(myItem);		
		}
		
	}

}
package rooms
{
	import flash.net.LocalConnection;
	import game.*;
	import game.beach.Beach;
	import game.plains.Plains;
	import game.snow.Snow;
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import game.forest.Forest;
	import game.desert.Desert;
	
	public class MyWorld extends World
	{
		/**
		 * How often to consider changing locations, also determined by
		 * how long we've been in a location.
		 */
		public const CHANGE_LOCATION_TIME:Number = 4;
		
		/**
		 * Used to move objects slower than one pixel per frame
		 */
		public static var oddFrame:int = 1;
		public static var thirdFrame:int = 1;
		public static var fourthFrame:int = 1;
		public static var forceClouds:Boolean = false;
		
		/**
		 * Location
		 */
		public var location:Location;
		public var lastLocation:Location;
		public var nextLocation:Location;
		public var changeLocationAlarm:MyAlarm;
		
		public var soundController:SoundController;
		
		/**
		 * 'day', 'night', or 'sunset'
		 */
		public var time:String;
		
		/**
		 * Ground
		 */
		public static var ground:Ground;
		public static var oldGround:Ground;
		
		/**
		 * Title text
		 */
		public var titleTextAlarm:Alarm;
		
		/**
		 * Size of the room (so it knows where to keep the player + camera in).
		 */
		public var width:uint;
		public var height:uint;
		
		/**
		 * Music
		 */
		public var music:Sfx = new Sfx(Assets.MUSIC);			
		public var musicEnd:Sfx = new Sfx(Assets.MUSIC_END);
		
		public function MyWorld()      
		{
			// World size
			width = 300;
			height = 200;		
		
			// Set location
			location = FP.choose(new Desert, new Forest, new Snow, new Plains, new Beach);	
			//location = new Desert;
			add(location);
			changeLocationAlarm = new MyAlarm(CHANGE_LOCATION_TIME, changeLocationChance);
			addTween(changeLocationAlarm);
			changeLocationAlarm.start();
			
			// Sound controller
			add(soundController = new SoundController(location));			
			
			// Ground and sky
			add(ground = new Ground(location));
			ground.x = -ground.image.width/2;
			add(new Sky);
			
			// Mountain controller
			add(new MountainController);
			
			// Night-day cycle
			add(new Day(this, false));
			
			
			// Player
			add(Global.player = new Player);
			add(Global.victim = new Victim);
			
			// Starting text
			add(new textPress);
			
			// Start of game changes
			location.gameStart(this);
			location.creationTime = 2;
			location.creationTimeAlarm.reset(0.1);
		}
		
		override public function begin():void
		{
//			music.loop();
		}
		
		/**
		 * Update the room.
		 */
		override public function update():void 
		{
			// Testing
			if (Input.pressed(Key.C))
 			{
				trace('c presesd');
				this.changeLocation();
			}
			else if (Input.pressed(Key.N))
 			{
				trace('n presesd');
				advanceTime();
			}			
			
			// Update entities
			super.update();
			
			// Flip oddFrame every frame
			oddFrame *= -1;
			
			// Update thirdFrame
			if (thirdFrame == 3)
			{
				thirdFrame = 1;
			}
			else 
			{
				thirdFrame += 1;
			}
			
			// Update fourthFrame
			if (fourthFrame == 4)
			{
				fourthFrame = 1;
			}
			else 
			{
				fourthFrame += 1;
			}
			
		}		
		
		//public function changeWalkingSpeed(newSpeed:Number):void
		//{
			//Global.WALKING_SPEED = newSpeed;
			//Global.victim
		//}
		
		/**
		 * Change location now.
		 */
		public function changeLocation():void
		{
			//trace('Changing location');
			var newLocation:Location;
			do 
			{
				newLocation = FP.choose(new Forest, new Desert, new Plains, new Snow, new Beach);
				//newLocation = FP.choose(new Forest, new Beach);
			} 
			while (newLocation.type == this.location.type);
			if (soundController)
				soundController.changeLocation(newLocation);
			remove(location);
			add(location = newLocation);
			oldGround = ground;
			add(ground = new Ground(location));			
			//trace('new location: ' + location);
		}
		
		/**
		 * Chance of changing location, or changing the location slope.
		 */
		public function changeLocationChance():void
		{
			//trace('change location chance');
			//trace('Slope: ' + location.creationTimeSlope);
			changeLocationAlarm.reset(CHANGE_LOCATION_TIME);
			switch (location.creationTimeSlope)
			{
				case 1:
					if (location.creationTime < (location.minCreationTime * 2))
					{
						if (FP.random > 0.6)
						{
							//trace('Changing slope from 1 to 0');
							location.creationTimeSlope = 0;
						}
					}
					break;
				case 0:
					if (FP.random > 0.6)
					{
						//trace('Changing slope from 0 to -1');
						location.creationTimeSlope = -1;
					}
					break;
				case -1:
					if (location.creationTime > (location.maxCreationTime * 0.75))
					{
						if (FP.random > 0.6)
						{
							changeLocation();
						}		
					}
					break;
			}
		}
		
		public function advanceTime():void
		{
			switch (time)
			{
				case 'day':
					add(new Sunset);
					break;
				case 'sunset':
					add(new Night);
					break;
				case 'night':
					add(new Day(this));
					break;
			}
		}
		
		public function showTitle():void
		{
			add(new textJordan);
		}

	}
}
 
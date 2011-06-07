package rooms
{
	import flash.net.LocalConnection;
	import game.*;
	import game.beach.Beach;
	import game.jungle.Jungle;
	import game.jungle.StartingScene;
	import game.plains.Plains;
	import game.snow.Snow;
	import game.textReachedFields;
	import net.flashpunk.Entity;
	import net.flashpunk.Screen;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.sound.Fader;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import game.forest.Forest;
	import game.desert.Desert;
	import flash.ui.Mouse;
	
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
		public var textPressAlarm:Alarm = new Alarm(3, showTextPress);
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
		public var musicFader:SfxFader = new SfxFader(music, musicFaderComplete);
		public var musicEnd:Sfx = new Sfx(Assets.MUSIC_END);
		public var musicStarted:Boolean = false;
		
		public var reachedPlainsAlarm:Alarm = new Alarm(15, reachedPlains);
		
		public var explosionAlarm:Alarm;
		
		public var fadeItemAlarm:Alarm = new Alarm(6, fadeAllItemsAfterExplosion);
		
		public var startFallingCameraAlarm:Alarm;
		
		public function MyWorld()      
		{
			// Reset screen
			FP.height = 200;
			FP.width = 300;
			FP.screen = new Screen;
			FP.screen.scale = 2;
			//FP.screen.update();
			
			// World size
			width = 300;
			height = 200;		
		
			// Set location
			//location = FP.choose(new Desert, new Forest, new Snow, new Plains, new Beach);	
			location = new Jungle;
			//add(new StartingScene);
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
			//add(new Day(this, false));
			add(new Night(this, false));
			time = 'night';
			//var night:Night;
			//add(night = new Night(this));
			//night.image.alpha = 1;
			
			// Time counter
			add(Global.timeCounter = new TimeCounter);
			
			
			// Player
			add(Global.player = new Player);
			add(Global.victim = new Victim);
			
			// Starting text
			addTween(textPressAlarm, true);
			//add(new textPress);
			
			// Start of game changes
			location.gameStart(this);
			location.creationTime = 0.6;
			location.creationTimeAlarm.reset(0.1);
			
			// Explosion?
			if (FP.random <= Global.EXPLOSION_CHANCE)
				Global.shouldExplode = true;
			if (Global.shouldExplode)
			{
				Global.explosionTime = Global.EARLIEST_EXPLOSION + FP.random * (Global.LATEST_EXPLOSION - Global.EARLIEST_EXPLOSION);
				explosionAlarm = new Alarm(Global.explosionTime, explode);
				addTween(explosionAlarm, true);
				trace('explosion set to: ' + Global.explosionTime);
			}
			else
				trace('no explosion this time');
		}
		
		override public function begin():void
		{	
			Mouse.hide();
			addTween(musicFader);
			
			trace('time in jungle: ' + Global.timeInJungle);
			trace('time in forest: ' + Global.timeInForest);
			trace('time in beach: ' + Global.timeInBeach);
//			advanceTime();
//			music.loop();
		}
		
		/**
		 * Update the room.
		 */
		override public function update():void 
		{
		//	trace('Global.playSounds: ' + Global.playSounds);
		
			//trace('time: ' + Global.timeCounter.timePassed);
			
			//if (Global.timeCounter.timePassed >= Global.START_MUSIC_IN && !musicStarted)
			//{
				//fadeMusicIn(Global.MUSIC_IN_DURATION);				
			//}
			
			// Testing
			if (Input.pressed(Key.F12))
			{
				Global.shouldExplode = true;
				Global.explosionTime = Global.EARLIEST_EXPLOSION + FP.random * (Global.LATEST_EXPLOSION - Global.EARLIEST_EXPLOSION);
				//Global.explosionTime = 2;
				explosionAlarm = new Alarm(Global.explosionTime, explode);
				addTween(explosionAlarm, true);
				trace('explosion set to: ' + Global.explosionTime);
			}
			if (Input.pressed(Key.F11))
			{
				Global.shouldExplode = false;
				Global.explosionTime = 5000;
				//Global.explosionTime = 2;
				if (explosionAlarm) removeTween(explosionAlarm);
				trace('explosion canceled');
			}			
			
			if (Input.pressed(Key.F7))
 			{
				explode();
			}

			if (Input.pressed(Key.F6))
 			{
				trace('c presesd');
				this.changeLocation();
			}

			if (Input.pressed(Key.F5) && !musicStarted)
			{
				trace('music fading in');
				Global.playSounds = false;
				Global.fadeSounds = true;
				musicStarted = true;
				soundController.fadeOut();
				music.loop(0);
				musicFader.fadeTo(1, Global.MUSIC_IN_DURATION);
			}			
			
			//if (Input.pressed(Key.N))
 			//{
				//trace('n presesd');
				//advanceTime();
			//}			
			
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
			
			// Time to swtich out of jungle?
			if (Global.locationChanges == 0 && Global.timeCounter.timePassedSinceLastLocationChange >= Global.timeInJungle)
			{
				trace('exceeded time in jungle - change out');
				changeLocation(); 
				Global.stillInJungle = false;
			}
			else if (Global.locationChanges == 1 && Global.timeCounter.timePassedSinceLastLocationChange >= Global.timeInForest)
			{
				trace('exceeded time in forest - change out');
				changeLocation();
			}			
			else if (Global.locationChanges == 2 && Global.timeCounter.timePassedSinceLastLocationChange >= Global.timeInBeach)
			{
				trace('exceeded time in beach - change out');
				changeLocation();
			}				
			
		}		
		
		public function explode():void
		{
			if (!Global.player.walking)
			{
				explosionAlarm.reset(1);
				return;
			}
			FP.rate = 0.4;
			Global.exploded = true;
			add(new Explosion);
			add(new ExplodedPlayer(Global.player.x - 10, Global.player.y));
			add(new ExplodedVictim(Global.victim.x + 10, Global.victim.y));
			remove(Global.player);
			remove(Global.victim);		
			//fadeAllItems();
			music.stop();
			Global.playSounds = false;
			addTween(fadeItemAlarm, true);
			FP.world.add(Global.deadUnderground = new DeadUnderground);
		}
		
		public function startFallingCamera():void
		{
			add(new FallingCameraGuide());
		}
		
		public function fadeMusicIn(duration:Number = 10):void
		{
				trace('music fading in');
				soundController.fadeOut();
				Global.playSounds = false;
				Global.fadeSounds = true;
				music.loop(0);
				musicFader.fadeTo(1, duration);
		}
		
		public function musicFaderComplete():void
		{
			trace('music fader complete');
			Global.fadeSounds = false;
		}
		
		public function fadeAllItemsAfterExplosion():void
		{	
			if (Global.MUSIC_WHILE_WALKING)
			{
				music.play(0);
				musicFader.fadeTo(1, 10);
				startFallingCameraAlarm = new Alarm(13, startFallingCamera);
			}
			else
			{
				startFallingCameraAlarm = new Alarm(8, startFallingCamera);
			}
			addTween(startFallingCameraAlarm, true);
			var itemList:Array = [];
			getClass(Item, itemList);		
			for each (var i:Item in itemList)
			{
				if (i.type != 'cloud')
					i.fadeOutImage(10);
			}				
		}
		
		public function fadeAllItemsGeneric(duration:Number = 10):void
		{
			var itemList:Array = [];
			getClass(Item, itemList);		
			for each (var i:Item in itemList)
			{
				if (i.type != 'cloud')
					i.fadeOutImage(duration);
			}				
		}		
		
		public function fadeItem():void
		{
			trace('fade item');
			var itemList:Array = [];
			getClass(Item, itemList);
			//for each (var e:Item in itemList)
			//{
				//if (e.type == 'cloud')
				//{
					//itemList.pop();
				//}
			//}	
			if (itemList)
			{
				shuffle(itemList);
				do 
				{
					if (itemList[0]) 
						var e:Item = itemList.pop();
					else 
						break;
				} while (e.type == 'cloud');
				e.fadeOutImage(3);			
				fadeItemAlarm.reset(3);
			}
		}
		
		public function shuffle(a:Array):void
		{
			for (var i: int = a.length - 1; i > 0; i--)
			{
				var j: int = Math.random() * (i+1);
				
				var tmp: * = a[i];
				a[i] = a[j];
				a[j] = tmp;
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
		public function changeLocation(newLocation:Location = null):void
		{
			trace('change location');
			trace('location changes: ' + Global.locationChanges);
			trace('time: ' + Global.timeCounter.timePassed);
			trace('time since last location: ' + Global.timeCounter.timePassedSinceLastLocationChange);
			Global.timeCounter.timePassedSinceLastLocationChange = 0;
			
			// First few location changes are deteremined
			switch (Global.locationChanges)
			{
				case 0: 
					newLocation = new Forest; 	// Forest
					break;
				case 1:			
					if (Global.MUSIC_WHILE_WALKING)
						fadeMusicIn(Global.MUSIC_IN_DURATION);			
					newLocation = new Beach;	// Beach
					break;
				case 2:
					Global.touchedPlains = true;				
					addTween(reachedPlainsAlarm, true);
					trace('reached plains alarm set');
					newLocation = new Plains;
					break;
			}
			
			if (newLocation == null)
			{
				var newLocation:Location;
				do 
				{
					newLocation = FP.choose(new Jungle, new Forest, new Plains, new Beach);
					//newLocation = new Beach;
				} 
				while (newLocation.type == this.location.type);
			}
			if (soundController)
				soundController.changeLocation(newLocation);
			remove(location);
			add(location = newLocation);
			oldGround = ground;
			add(ground = new Ground(location));			
			//trace('new location: ' + location);

			Global.locationChanges++;			
		}
		
		public function reachedPlains():void
		{
			trace('reached plains');
			if (Global.player.walking)
				add(new textReachedFields);
			Global.reachedPlains = true;
		}
		
		/**
		 * Chance of changing location, or changing the location slope.
		 */
		public function changeLocationChance():void
		{
			//trace('change location chance');
			//trace('Slope: ' + location.creationTimeSlope);
			changeLocationAlarm.reset(CHANGE_LOCATION_TIME);
			
			if (Global.locationChanges == 0 && Global.timeCounter.timePassedSinceLastLocationChange < Global.timeInJungle)
			{
				//trace('too early to change out of jungle');
				return;
			}
			else if (Global.locationChanges == 1 && Global.timeCounter.timePassedSinceLastLocationChange < Global.timeInForest)
			{
				//trace('too early to change out of forest');
				return;
			}
			else if (Global.locationChanges == 2 && Global.timeCounter.timePassedSinceLastLocationChange < Global.timeInBeach)
			{
				//trace('too early to change out of beach');
				return;
			}			
			
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
		
		public function showTextPress():void
		{
			if (!Global.startedWalking)
				add(new textPress);
		}
		
		public function showTitle():void
		{
			add(new textJordan);
		}
		
		//public function stopAllSounds():void
		//{
			//Global.playSounds = false;
			//var soundControllers:Array = [];
			//getClass(SoundController, soundControllers);
			//for each (var e:SoundController in soundControllers)
			//{
				//e.removeTween((e.fader));
				//e.fader.fadeTo(0, 0.01);
				//e.currentSound.stop();
				//e.newSound.stop();
				//remove(e);
			//}
		//}

	}
}
 
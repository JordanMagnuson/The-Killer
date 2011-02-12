package game.desert 
{

	import game.*;
	import net.flashpunk.FP;
	import game.Player;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import net.flashpunk.Sfx;
	import rooms.MyWorld;
	
	public class Desert extends Location
	{		
		public var creationNumber:Number;
		
		/**
		 * Sound
		 */
		[Embed(source='../../../assets/sounds.swf', symbol='silence.wav')] private const DAY_SOUND:Class;
		[Embed(source='../../../assets/sounds.swf', symbol='silence.wav')] private const NIGHT_SOUND:Class;
		
		[Embed(source='../../../assets/sounds.swf', symbol='wind_burst.wav')] private const SND_WIND:Class;
		public var sndWind:Sfx = new Sfx(SND_WIND);		
		
		[Embed(source='../../../assets/sounds.swf', symbol='wolf.wav')] private const SND_WOLF:Class;
		public var sndWolf:Sfx = new Sfx(SND_WOLF);		
		
		public function Desert() 
		{
			super(DAY_SOUND, NIGHT_SOUND, 5, 2);
			type = 'desert';
		}
		
		override public function update():void
		{
			super.update();
		}
		
		/**
		 * Controls item creation for this location.
		 */		
		override public function createItem():void
		{
			super.createItem();
			
			creationNumber = FP.random;			
			
			// Mid Distance
			if (FP.random > 0.25)
			{
				if (creationNumber < 0.01 && Pyramids.seen == false)
				{
					FP.world.add(new Pyramids);
					Pyramids.seen = true;
				}
				else if (creationNumber < 0.05)
				{
					FP.world.add(new GiantCactus);
				}		
				else if (creationNumber < 0.1)
				{
					FP.world.add(new Butte);
				}						
				else if (creationNumber < 0.15)
				{
					FP.world.add(new Tumbleweed);
				}					
				else if (creationNumber < 1)
				{
					FP.world.add(new Cactus);
				}
			}
			
			// Sounds
			if (FP.random > 0.4 && Global.playSounds)
			{
				var pan:Number = FP.choose( -1, 1) * FP.random;
				var vol:Number = 0.2 + 0.7 * FP.random;
				// Night sounds
				if ((FP.world as MyWorld).time == 'night')
				{
					if (creationNumber < 0.1 && !sndWolf.playing)
					{
						sndWolf.play(vol, pan)
					}
					else if (creationNumber < 0.5 && !sndWind.playing)
					{
						sndWind.play(vol, pan);
					}
				}
				// Day sounds
				else
				{
					if (creationNumber < 0.5 && !sndWolf.playing)
					{
						sndWolf.play(vol, pan)
					}					
					else if (creationNumber < 0.5 && !sndWind.playing)
					{
						sndWind.play(vol, pan);
					}					
				}
			}	
		}

		/**
		 * Stuff to set up at the beginning of the game.
		 * @param	world	Current world.
		 */
		override public function gameStart(world:World):void
		{
			super.gameStartItem(world, new Cactus);	
		}
		
	}

}
package game.jungle 
{
	import game.Location;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import game.Global;
	import rooms.MyWorld;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Jungle extends Location
	{
		public var creationNumber:Number;
		
		/**
		 * Sound
		 */
		//[Embed(source='../../../assets/jungle_sounds.swf', symbol='jungle_night_loop_106973.wav')] private const NIGHT_SOUND:Class;	
		//[Embed(source='../../../assets/jungle_sounds.swf', symbol='jungle_day_1_minute_34348.wav')] private const DAY_SOUND:Class;
		
		[Embed(source='../../../assets/jungle_sounds.swf', symbol='jungle_day_1_minute_34348.wav')] private const DAY_SOUND:Class;
		[Embed(source='../../../assets/jungle_sounds.swf', symbol='jungle_night_106973.wav')] private const NIGHT_SOUND:Class;
		
		[Embed(source='../../../assets/sounds.swf', symbol='cicadas.wav')] private const SND_CICADAS:Class;
		public var sndCicadas:Sfx = new Sfx(SND_CICADAS);			
		
		[Embed(source='../../../assets/jungle_sounds.swf', symbol='kookaburra')] private const SND_KOOKA:Class;
		public var sndKooka:Sfx = new Sfx(SND_KOOKA);					
		
		[Embed(source='../../../assets/jungle_sounds.swf', symbol='little_parot')] private const SND_PARROT:Class;
		public var sndParrot:Sfx = new Sfx(SND_PARROT);			
		
		[Embed(source='../../../assets/jungle_sounds.swf', symbol='macaw')] private const SND_MACAW:Class;
		public var sndMacaw:Sfx = new Sfx(SND_MACAW);		
		
		[Embed(source='../../../assets/jungle_sounds.swf', symbol='monkey')] private const SND_MONKEY:Class;
		public var sndMonkey:Sfx = new Sfx(SND_MONKEY);			
		
		public function Jungle() 
		{
			super(DAY_SOUND, NIGHT_SOUND, 0.6, 0.4);
			type = 'jungle';     
		}
		
		override public function added():void
		{
			FP.world.add(new StartingScene);			
		}
		
		override public function createItem():void
		{
			super.createItem();
			
			creationNumber = FP.random;	
			
			if (FP.random > 0.05)
			{
				if (creationNumber < 0.1)
				{
					FP.world.add(new JungleTree);
				}
				else if (creationNumber < 0.5)
				{
					FP.world.add(new Bush);
				}
				else if (creationNumber < 1)
				{
					FP.world.add(new Palm);
				}
			}		
			
			// Sounds
			if (FP.random > 0.6 && Global.playSounds)
			{
				var pan:Number = FP.choose(-1, 1) * FP.random;
				var vol:Number = 0.2 + 0.7 * FP.random;
				
				// Night sounds
				if ((FP.world as MyWorld).time != 'day')
				{
					if (creationNumber < 0.01 && !sndMonkey.playing)
					{
						trace('jungle play sndMonkey');
						sndMonkey.play(vol, pan);
					}							
					else if (creationNumber < 0.05 && !sndCicadas.playing)
					{
						trace('jungle play sndCicadas');
						sndCicadas.play(2, pan);
					}		
					//else if (creationNumber < 0.1 && !sndKooka.playing)
					//{
						//trace('jungle play sndKooka');
						//sndKooka.play(vol, pan);
					//}					
					else if (creationNumber < 0.1 && !sndMacaw.playing)
					{
						trace('jungle play sndMacaw');
						sndMacaw.play(vol, pan);
					}					
				}
				// Day sounds
				else
				{
					if (creationNumber < 0.01 && !sndMonkey.playing)
					{
						trace('jungle day play sndMonkey');
						sndMonkey.play(vol, pan);
					}							
					if (creationNumber < 0.1 && !sndKooka.playing)
					{
						trace('jungle day play sndKooka');
						sndKooka.play(vol, pan);
					}					
					else if (creationNumber < 0.15 && !sndMacaw.playing)
					{
						trace('jungle day play sndMacaw');
						sndMacaw.play(vol, pan);
					}	
					else if (creationNumber < 0.3 && !sndParrot.playing)
					{
						trace('jungle day play sndParrot');
						sndParrot.play(vol, pan);
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
			//FP.world.add(new StartingScene);
		}			
		
	}

}
package game.forest 
{

	import game.*;
	import game.forest.*;
	import net.flashpunk.FP;
	import game.Player;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import net.flashpunk.Sfx;
	import rooms.MyWorld;
	
	public class Forest extends Location
	{	
		public var creationNumber:Number;
		
		/**
		 * Sound
		 */
		[Embed(source='../../../assets/sounds.swf', symbol='forest_ambient')] private const DAY_SOUND:Class;
		[Embed(source='../../../assets/sounds.swf', symbol='forest_night_ambient')] private const NIGHT_SOUND:Class;
		
		[Embed(source='../../../assets/sounds.swf', symbol='owl.wav')] private const SND_OWL:Class;
		public var sndOwl:Sfx = new Sfx(SND_OWL);
		
		[Embed(source='../../../assets/sounds.swf', symbol='wolf.wav')] private const SND_WOLF:Class;
		public var sndWolf:Sfx = new Sfx(SND_WOLF);
		
		[Embed(source='../../../assets/sounds.swf', symbol='creaking.wav')] private const SND_CREAKING:Class;
		public var sndCreaking:Sfx = new Sfx(SND_CREAKING);		
		
		[Embed(source='../../../assets/sounds.swf', symbol='cicadas.wav')] private const SND_CICADAS:Class;
		public var sndCicadas:Sfx = new Sfx(SND_CICADAS);			
		
		public function Forest() 
		{
			super(DAY_SOUND, NIGHT_SOUND, 2);
			type = 'forest';
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
			
			// Mid distance
			if (FP.random > 0.2)
			{
				//if (creationNumber < 0.005 && GiantPine.seen == false)
				//{
					//FP.world.add(new GiantPine);
					//GiantPine.seen = true;
				//}
				if (creationNumber < 0.02)
				{
					FP.world.add(new River);
				}
				else if (creationNumber < 0.05)
				{
					FP.world.add(new PinetreeSideways);
				}
				//else if (creationNumber < 0.2)
				//{
					//FP.world.add(new ForestPalm);
				//}				
				else if (creationNumber < 1)
				{
					FP.world.add(new Pinetree);
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
					if (creationNumber < 0.05 && !sndOwl.playing)
					{
						sndOwl.play(vol, pan);
					}
					//else if (creationNumber < 0.2 && !sndWolf.playing)
					//{
						//sndWolf.play(vol, pan);
					//}
					else if (creationNumber < 0.15 && !sndCreaking.playing)
					{
						sndCreaking.play(vol, pan);
					}
					else if (creationNumber < 0.4 && !sndCicadas.playing)
					{
						sndCicadas.play(vol, pan);
					}					
				}
				// Day sounds
				else
				{
					if (creationNumber < 0.01 && !sndCicadas.playing)
					{
						sndCicadas.play(vol, pan);
					}					
					else if (creationNumber < 0.015 && !sndOwl.playing)
					{
						sndOwl.play(vol, pan);				
					}
					//else if (creationNumber < 0.03 && !sndWolf.playing)
					//{
						//sndWolf.play(vol, pan);
					//}
					else if (creationNumber < 0.15 && !sndCreaking.playing)
					{
						sndCreaking.play(vol, pan);
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
			super.gameStartItem(world, new Pinetree);	
		}		
		
	}

}
package game.plains 
{

	import game.*;
	import game.forest.River;
	import net.flashpunk.FP;
	import game.Player;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import net.flashpunk.Sfx;
	import rooms.MyWorld;
	
	public class Plains extends Location
	{		
		public var creationNumber:Number;
		
		/**
		 * Sound
		 */
		[Embed(source='../../../assets/sounds.swf', symbol='forest_ambient')] private const DAY_SOUND:Class;
		[Embed(source='../../../assets/sounds.swf', symbol='forest_night_ambient')] private const NIGHT_SOUND:Class;
		
		[Embed(source='../../../assets/sounds.swf', symbol='bee.wav')] private const SND_BEE:Class;
		public var sndBee:Sfx = new Sfx(SND_BEE);	
		
		[Embed(source='../../../assets/sounds.swf', symbol='cicadas.wav')] private const SND_CICADAS:Class;
		public var sndCicadas:Sfx = new Sfx(SND_CICADAS);			
		
		public function Plains() 
		{
			super(DAY_SOUND, NIGHT_SOUND, 3, 0.3);
			type = 'plains';
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
				//if (creationNumber < 0.005 && FlowerTree.seen == false)
				//{
					//FP.world.add(new FlowerTree);
					//FlowerTree.seen = true;
				//}				
				if (creationNumber < 0.03)
				{
					FP.world.add(new River);
				}
				else if (creationNumber < 0.1)
				{
					FP.world.add(new Tree);
				}	
				else if (creationNumber < 0.2)
				{
					FP.world.add(new PlainsPalm);
				}								
				else if (creationNumber < 1)
				{
					FP.world.add(new Flowers);
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
					if (creationNumber < 0.01 && !sndBee.playing)
					{
						sndBee.play(vol, pan);
					}
					else if (creationNumber < 0.06 && !sndCicadas.playing)
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
					else if (creationNumber < 0.06 && !sndBee.playing)
					{
						sndBee.play(vol, pan);
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
			super.gameStartItem(world, new Flowers);	
		}
		
	}

}
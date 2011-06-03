package game.jungle 
{
	import game.Location;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
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
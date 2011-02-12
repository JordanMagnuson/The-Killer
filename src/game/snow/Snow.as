package game.snow 
{

	import game.*;
	import net.flashpunk.FP;
	import game.Player;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import net.flashpunk.Sfx;
	
	public class Snow extends Location
	{		
		public var creationNumber:Number;
		
		/**
		 * Sound
		 */
		[Embed(source='../../../assets/sounds.swf', symbol='wind_ambient')] private const DAY_SOUND:Class;
		[Embed(source = '../../../assets/sounds.swf', symbol = 'wind_ambient')] private const NIGHT_SOUND:Class;
		
		public function Snow() 
		{
			super(DAY_SOUND, NIGHT_SOUND, 5, 0.5);
			type = 'snow';
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
				if (creationNumber < 0.01 && SnowMan.seen == false)
				{
					FP.world.add(new SnowMan);
					SnowMan.seen = true;
				}
				else if (creationNumber < 0.05)
				{
					FP.world.add(new FrozenRiver);
				}					
				else if (creationNumber < 0.09)
				{
					FP.world.add(new Igloo);
				}						
				else if (creationNumber < 0.3)
				{
					FP.world.add(new BarrenTree);
				}				
				else if (creationNumber < 1)
				{
					FP.world.add(new SnowDrift);
				}
			}			
		}

		/**
		 * Stuff to set up at the beginning of the game.
		 * @param	world	Current world.
		 */
		override public function gameStart(world:World):void
		{
			super.gameStartItem(world, new SnowDrift);	
		}
		
	}

}
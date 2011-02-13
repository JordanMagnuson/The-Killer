package game 
{
	import game.beach.Beach;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import rooms.MyWorld;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class DeadUnderground extends Entity
	{
		public var image:Image = new Image(Assets.DEAD_UNDERGROUND);
		
		public function DeadUnderground() 
		{
			graphic = image;
			x = 0;
			y = Ground.y;
			layer = -999;
		}
		
		override public function added():void
		{
			// Make the color of the ground match the current location
			switch((FP.world as MyWorld).location.type)
			{
				case 'beach':
					image.color = Colors.BEACH_YELLOW;
					//((FP.world as MyWorld).location as Beach).waves.fadeOut();
					break;
				case 'desert':
					image.color = Colors.DESERT_ORANGE;
					break;
				case 'forest':
					image.color = Colors.FOREST_BROWN;
					break;
				case 'plains':
					image.color = Colors.PLAINS_GREEN;
					break;
				case 'snow':
					image.color = Colors.SNOW_WHITE;
					break;
			}
		}
		
	}

}
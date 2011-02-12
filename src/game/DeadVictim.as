package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class DeadVictim extends Entity
	{
		
		/**
		 * Player graphic
		 */
		[Embed(source='../../assets/victim_dying.png')] private const VICTIM:Class;
		public var spritemap:Spritemap = new Spritemap(VICTIM, 30, 20);			
		
		public function DeadVictim() 
		{
			spritemap.add("die", [0, 1, 2, 3, 4, 5], 2, false);
			graphic = spritemap;
			
			// Hit box
			spritemap.originX = 0;
			spritemap.originY = spritemap.height;
			spritemap.x = 0;
			spritemap.y = -spritemap.originY;	
			
			setHitbox(spritemap.width, spritemap.height, spritemap.originX, spritemap.originY);					
		}
		
		override public function added():void
		{
			spritemap.play('die');
		}
		
	}

}
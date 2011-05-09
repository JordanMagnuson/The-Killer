package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class ExplodedVictim extends Entity
	{
		[Embed(source='../../assets/victim_dead.png')] private const SPRITE:Class;
		public var image:Image = new Image(SPRITE);			
		
		public function ExplodedVictim(x:Number, y:Number) 
		{
			super(x, y);
			graphic = image;
			// Hit box
			image.originX = 0;
			image.originY = image.height;
			image.x = 0;
			image.y = -image.originY;	
			
			setHitbox(image.width, image.height, image.originX, image.originY);						
		}
		
	}

}
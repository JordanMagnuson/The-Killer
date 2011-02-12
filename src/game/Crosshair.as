package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Crosshair extends Entity
	{
		
		[Embed(source='../../assets/crosshair.png')] private const SPRITE:Class;
		public var image:Image = new Image(SPRITE);		
		
		public function Crosshair() 
		{
			graphic = image;
			image.centerOO();
		}
		
		override public function update():void
		{
			x = FP.world.mouseX;
			y = FP.world.mouseY;
			super.update();
		}
		
	}

}
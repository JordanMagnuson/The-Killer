package game.beach 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class WaterCover extends Entity
	{
		public var backdrop:Backdrop = new Backdrop(Assets.WATER_COVER, false, false);
		
		public function WaterCover() 
		{
			graphic = backdrop;
			x = 0;
			y = FP.height;
		//	layer = 9998;
		//	y = FP.height;
		//	layer = -999;
			//graphic.scrollX = 0;
			//graphic.scrollY = 0;
		}
		
	}

}
package game 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import rooms.GameOver;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class FallingCameraGuide extends Entity
	{
		
		public const MAX_FALL_SPEED:Number = 1;
		public var fallSpeed:Number = 0.2;		
		
		public function FallingCameraGuide(fallSpeed:Number = 0.5) 
		{
			x = FP.halfWidth;
			y = FP.halfHeight;
			this.fallSpeed = fallSpeed;
		}
		
		override public function added():void
		{
			FP.world.add(Global.view = new View(this, new Rectangle(0, 0, FP.width, 1200), 1));			
		}
		
		override public function update():void
		{	
			y += fallSpeed * FP.rate;
			
			if (y > 1175) // 1175
				FP.world = new GameOver;
		}		
		
	}

}
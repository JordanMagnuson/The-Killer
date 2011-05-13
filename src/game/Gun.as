package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Gun extends Entity
	{
		[Embed(source='../../assets/gun.png')] private const SPRITE:Class;
		public var image:Image = new Image(SPRITE);		
		
		public function Gun() 
		{
			graphic = image;
			image.smooth = false;
			
			image.originX = 1;
			image.originY = 2;
			image.x = -originX;
			image.y = -image.originY;				
			
			x = Global.playerShooting.x + 7;
			y = Global.playerShooting.y - 8;
		}
		
		override public function update():void
		{
		//	if (!Global.shotFired || Global.mercifulShot)
			if (!Global.shotFired)
				image.angle = FP.angle(x,y,FP.world.mouseX,FP.world.mouseY);
			super.update();
		}
		
	}

}
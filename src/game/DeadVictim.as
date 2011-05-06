package game 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import rooms.GameOver;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class DeadVictim extends Entity
	{
		
		public const MAX_FALL_SPEED:Number = 1;
		public var fallSpeed:Number = 0.2;
		
		/**
		 * Player graphic
		 */
		[Embed(source='../../assets/victim_dying.png')] private const VICTIM:Class;
		public var spritemap:Spritemap = new Spritemap(VICTIM, 30, 20);			
		
		public function DeadVictim() 
		{
			spritemap.add("die", [0, 1, 2, 3], 2, false);
			graphic = spritemap;
			
			// Hit box
			spritemap.originX = 10;
			spritemap.originY = spritemap.height - 5;
			spritemap.x = 0;
			spritemap.y = -spritemap.originY - 5;	
			
			setHitbox(spritemap.width, spritemap.height, spritemap.originX, spritemap.originY);		
			
			FP.world.add(Global.view = new View(this, new Rectangle(0, 0, FP.width, 1200), 1));
		}
		
		override public function added():void
		{
			spritemap.play('die');
		}
		
		override public function update():void
		{
			spritemap.angle -= 1 * FP.rate;		
			y += 0.5 * FP.rate;
			
			//trace(y);
			if (y > 1175) // 1175
				FP.world = new GameOver();
			
			//if (fallSpeed < MAX_FALL_SPEED)
			//{
				//fallSpeed += 0.001;
			//}
			//trace(fallSpeed);
			//if (spritemap.index == 1 || spritemap.complete)
			//{
				//y += 0.5;
			//}
		}
		
	}

}
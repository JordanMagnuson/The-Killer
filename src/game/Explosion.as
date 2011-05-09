package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Explosion extends Entity
	{
		
		[Embed(source='../../assets/explosion.png')] private const SPRITE:Class;
		public var spritemap:Spritemap = new Spritemap(SPRITE, 64, 64);	
		
		[Embed(source = '../../assets/explosion.swf', symbol = 'explosion_01.wav')] private const SND_EXPLODE:Class;
		public var sndExplosion:Sfx = new Sfx(SND_EXPLODE);
		
		public function Explosion() 
		{
			spritemap.add("explode", [0, 1, 2, 3, 4, 5], 30, false);	// Rate: 20
			graphic = spritemap;
			layer = -1000;
			
			// Hit box
			spritemap.centerOO();
			//spritemap.originX = 0;
			//spritemap.originY = spritemap.height;
			//spritemap.x = 0;
			//spritemap.y = -spritemap.originY;	
			//
			//setHitbox(spritemap.width, spritemap.height, spritemap.originX, spritemap.originY);				
			
			// Location
			x = Global.victim.x;
			y = Ground.y - 10;			
		}
		
		override public function added():void
		{
			spritemap.play('explode');
			sndExplosion.play(0.8);
		}
		
		override public function update():void
		{
			if (spritemap.complete)
				FP.world.remove(this);
		}
		
	}

}
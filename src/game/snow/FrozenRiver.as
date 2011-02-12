package game.snow
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import game.Global;
	
	public class FrozenRiver extends Item
	{	
		/**
		 * Graphics
		 */
		[Embed(source = '../../../assets/snow/frozen_river.png')] private const SPRITE01:Class;			
		
		/**
		 * Sound
		 */
		[Embed(source='../../../assets/sounds.swf', symbol='ice_creaking')] private const SND_CREAKING:Class;
		public var sndCreaking:Sfx = new Sfx(SND_CREAKING);		
		
		public function FrozenRiver() 
		{	
			super(SPRITE01, 'mid', false);
			type = 'frozen_river';
			
			layer = 9;
			
			// Hit box to bottom left, so we can place all items at same starting location
			image.originX = 0;
			image.originY = 3;
			image.x = 0;
			image.y = -image.originY;	
			
			setHitbox(image.width, image.height,image.originX, image.originY);				
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Global.playSounds && x <= 52 && x > 45 && !sndCreaking.playing)
			{
				var vol:Number = 0.2 + 0.5 * FP.random;
				sndCreaking.play(vol);
			}
		}
	}
}
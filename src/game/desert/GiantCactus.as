package game.desert
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class GiantCactus extends Item
	{	
		/**
		 * Graphics
		 */
		[Embed(source = '../../../assets/desert/cactus_giant.png')] private const SPRITE01:Class;				
		
		public function GiantCactus() 
		{	
			super(SPRITE01, 'mid', true);
			type = 'giant_cactus';
		}
		
		override public function update():void 
		{
			super.update();
		}
	}
}
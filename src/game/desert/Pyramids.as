package game.desert
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class Pyramids extends Item
	{	
		/**
		 * Tracks whether this item has yet appeared in the game. 
		 * Most wonders can only be seen once.
		 */
		public static var seen:Boolean = false;
		
		/**
		 * Graphics
		 */
		[Embed(source = '../../../assets/desert/pyramids.png')] private const SPRITE01:Class;				
		
		public function Pyramids() 
		{	
			super(SPRITE01, 'far', true);
			type = 'pyramids';
			
			layer = 99;
		}
		
		override public function update():void 
		{
			super.update();
		}
	}
}
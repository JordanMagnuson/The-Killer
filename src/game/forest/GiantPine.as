package game.forest
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class GiantPine extends Item
	{	
		/**
		 * Tracks whether this item has yet appeared in the game. 
		 * Most wonders can only be seen once.
		 */
		public static var seen:Boolean = false;
		
		/**
		 * Graphics
		 */
		[Embed(source = '../../../assets/forest/giant_pine01.png')] private const SPRITE01:Class;				
		public var mySpriteCollection:Array = new Array(SPRITE01);
		
		
		public function GiantPine() 
		{
			// Random image
			rawSprite = chooseSprite(mySpriteCollection);			
			super(rawSprite, 'mid', true);
			type = 'giant_pine';
		}
		
		override public function update():void 
		{
			super.update();
		}
	}
}
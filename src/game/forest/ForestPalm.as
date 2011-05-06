package game.forest
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class ForestPalm extends Item
	{	
		/**
		 * Graphics
		 */
		[Embed(source = '../../../assets/forest/forest_palm01.png')] private const SPRITE01:Class;	
		[Embed(source = '../../../assets/forest/forest_palm02.png')] private const SPRITE02:Class;	
		public var mySpriteCollection:Array = new Array(SPRITE01, SPRITE02);
		
		
		public function ForestPalm() 
		{
			// Random image
			rawSprite = chooseSprite(mySpriteCollection);			
			super(rawSprite, 'mid', true);
			type = 'tall_palm';
		}
		
		override public function update():void 
		{
			super.update();
		}
	}
}
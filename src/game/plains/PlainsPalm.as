package game.plains
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class PlainsPalm extends Item
	{	
		/**
		 * Graphics
		 */
		[Embed(source = '../../../assets/plains/plains_palm01.png')] private const SPRITE01:Class;	
		[Embed(source = '../../../assets/plains/plains_palm02.png')] private const SPRITE02:Class;		
		public var mySpriteCollection:Array = new Array(SPRITE01, SPRITE02);
		
		
		public function PlainsPalm() 
		{
			// Random image
			rawSprite = chooseSprite(mySpriteCollection);			
			super(rawSprite, 'mid', true);
			type = 'plains_palm';
		}
		
		override public function update():void 
		{
			super.update();
		}
	}
}
package game.beach
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class BeachPalm extends Item
	{	
		/**
		 * Graphics
		 */
		[Embed(source = '../../../assets/beach/beach_palm01.png')] private const SPRITE01:Class;	
		[Embed(source = '../../../assets/beach/beach_palm02.png')] private const SPRITE02:Class;	
		public var mySpriteCollection:Array = new Array(SPRITE01, SPRITE02);
		
		
		public function BeachPalm() 
		{
			// Random image
			rawSprite = chooseSprite(mySpriteCollection);			
			super(rawSprite, 'mid', true);
			type = 'beach_palm';
		}
		
		override public function update():void 
		{
			super.update();
		}
	}
}
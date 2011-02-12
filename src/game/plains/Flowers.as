package game.plains
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class Flowers extends Item
	{	
		/**
		 * Graphics
		 */
		[Embed(source = '../../../assets/plains/orange_flowers.png')] private const SPRITE01:Class;	
		[Embed(source = '../../../assets/plains/blue_flowers.png')] private const SPRITE02:Class;	
		[Embed(source = '../../../assets/plains/yellow_flowers.png')] private const SPRITE03:Class;			
		[Embed(source = '../../../assets/plains/red_flowers.png')] private const SPRITE04:Class;
		[Embed(source = '../../../assets/plains/purple_flowers.png')] private const SPRITE05:Class;		
		public var mySpriteCollection:Array = new Array(SPRITE01, SPRITE02, SPRITE03, SPRITE04, SPRITE05);
		
		
		public function Flowers() 
		{
			// Random image
			rawSprite = chooseSprite(mySpriteCollection);			
			super(rawSprite, 'mid', true);
			type = 'flowers';
		}
		
		override public function update():void 
		{
			super.update();
		}
	}
}
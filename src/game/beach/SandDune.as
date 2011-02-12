package game.beach
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class SandDune extends Item
	{	
		/**
		 * Graphics
		 */
		[Embed(source = '../../../assets/beach/dune01.png')] private const SPRITE01:Class;	
		[Embed(source = '../../../assets/beach/dune02.png')] private const SPRITE02:Class;	
		[Embed(source = '../../../assets/beach/dune03.png')] private const SPRITE03:Class;	
		[Embed(source = '../../../assets/beach/dune04.png')] private const SPRITE04:Class;	
		public var mySpriteCollection:Array = new Array(SPRITE01, SPRITE02, SPRITE03, SPRITE04);
		
		
		public function SandDune() 
		{
			// Random image
			rawSprite = chooseSprite(mySpriteCollection);			
			super(rawSprite, 'mid', true);
			type = 'sand_dune';
		}
		
		override public function update():void 
		{
			super.update();
		}
	}
}
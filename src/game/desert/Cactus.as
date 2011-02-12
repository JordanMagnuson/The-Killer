package game.desert
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class Cactus extends Item
	{	
		/**
		 * Graphics
		 */
		[Embed(source = '../../../assets/desert/cactus01.png')] private const CAC01:Class;	
		[Embed(source = '../../../assets/desert/cactus02.png')] private const CAC02:Class;
		[Embed(source = '../../../assets/desert/cactus03.png')] private const CAC03:Class;
		[Embed(source = '../../../assets/desert/cactus04.png')] private const CAC04:Class;
		[Embed(source = '../../../assets/desert/cactus_round.png')] private const CAC05:Class;
		public var mySpriteCollection:Array = new Array(CAC01, CAC02, CAC03, CAC04, CAC05);
		
		public function Cactus() 
		{
			// Random image
			rawSprite = chooseSprite(mySpriteCollection);			
			super(rawSprite, 'mid', false);
			type = 'cactus';
		}
		
		override public function update():void 
		{
			super.update();
		}
	}
}
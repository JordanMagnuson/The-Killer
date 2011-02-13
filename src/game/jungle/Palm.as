package game.jungle 
{
	import game.Item;
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Palm extends Item
	{
		/**
		 * Graphics
		 */
		[Embed(source = '../../../assets/jungle/palm01.png')] private const SPRITE01:Class;
		[Embed(source = '../../../assets/jungle/palm02.png')] private const SPRITE02:Class;	
		[Embed(source = '../../../assets/jungle/palm03.png')] private const SPRITE03:Class;	
		public var mySpriteCollection:Array = new Array(SPRITE01, SPRITE02, SPRITE03);		
		
		public function Palm() 
		{
			// Random image
			rawSprite = chooseSprite(mySpriteCollection);			
			super(rawSprite, 'mid', true);
			type = 'palm';			
		}
		
	}

}
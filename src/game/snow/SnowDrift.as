package game.snow
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class SnowDrift extends Item
	{	
		/**
		 * Graphics
		 */
		[Embed(source='../../../assets/snow/snow_pile01.png')] private const SPRITE01:Class;	
		[Embed(source='../../../assets/snow/snow_pile02.png')] private const SPRITE02:Class;	
		[Embed(source='../../../assets/snow/snow_pile03.png')] private const SPRITE03:Class;				
		public var mySpriteCollection:Array = new Array(SPRITE01, SPRITE02, SPRITE03);
		
		
		public function SnowDrift() 
		{
			// Random image
			rawSprite = chooseSprite(mySpriteCollection);			
			super(rawSprite, 'mid', true);
			type = 'snow_drift';
		}
		
		override public function update():void 
		{
			super.update();
		}
	}
}
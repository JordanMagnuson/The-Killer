package game.forest
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class PinetreeSideways extends Item
	{	
		/**
		 * Graphics
		 */
		[Embed(source = '../../../assets/forest/pine_sideways01.png')] private const SPRITE01:Class;			
		[Embed(source='../../../assets/forest/pine_sideways04.png')] private const SPRITE02:Class;			
		public var mySpriteCollection:Array = new Array(SPRITE01, SPRITE02);
		
		
		public function PinetreeSideways() 
		{
			// Random image
			rawSprite = chooseSprite(mySpriteCollection);			
			super(rawSprite, 'mid', true);
			type = 'pinetree_sideways';
		}
		
		override public function update():void 
		{
			super.update();
		}
	}
}
package game.desert
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	public class Tumbleweed extends Item
	{	
		/**
		 * Graphics
		 */
		[Embed(source = '../../../assets/desert/tumbleweed.png')] private const SPRITE01:Class;	
		public var spriteMap:Spritemap = new Spritemap(SPRITE01, 13, 12);
		
		public function Tumbleweed() 
		{	
			rawSprite = SPRITE01;		
			super(rawSprite, 'close', false);
			spriteMap.add("tumble", [0, 1, 2, 3], 5, true);
			graphic = spriteMap;
			type = 'tumbleweed';
			
			//speed = 1 + FP.rand(3);
			
			// Hit box to bottom left, so we can place all items at same starting location
			spriteMap.originX = 0;
			spriteMap.originY = spriteMap.height;
			spriteMap.x = 0;
			spriteMap.y = -spriteMap.originY;	
			
			setHitbox(spriteMap.width, spriteMap.height, spriteMap.originX, spriteMap.originY);					
		}
		
		override public function update():void 
		{
			super.update();
			spriteMap.play("tumble");
		}
	}
}
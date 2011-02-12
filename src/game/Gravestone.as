package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.graphics.Spritemap;
	import rooms.MyWorld;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class Gravestone extends Entity
	{
		public const animationSpeed:Number = 0.05;
		public const FADE_IN_DURATION:Number = 5;
		
		public var fadeTween:ColorTween;	
		
		/**
		 * Image
		 */
		[Embed(source='../../assets/gravestone.png')] private const SPRITE:Class;	
		public var spriteMap:Spritemap = new Spritemap(SPRITE, 9, 10);
				
		public function Gravestone() 
		{
			spriteMap.add("forest", [0, 1, 2, 3, 4], animationSpeed, false);
			spriteMap.add("snow", [5, 6, 7, 8, 9], animationSpeed, false);
			spriteMap.add("desert", [10, 11, 12, 13, 14], animationSpeed, false);
			spriteMap.add("plains", [15, 16, 17, 18, 19], animationSpeed, false);
			spriteMap.add("beach", [20, 21, 22, 23, 24], animationSpeed, false);
			
			graphic = spriteMap;
			spriteMap.alpha = 0;
			
			// Hit box
			spriteMap.originX = 0;
			spriteMap.originY = spriteMap.height;
			spriteMap.x = 0;
			spriteMap.y = -spriteMap.originY;	
			
			setHitbox(spriteMap.width, spriteMap.height, spriteMap.originX, spriteMap.originY);				
			
			// Location
			x = 57;
			y = Ground.y;			
			
			fadeIn();
			spriteMap.play((FP.world as MyWorld).location.type);
			
		}
		
		override public function update():void 
		{
			super.update();
			(graphic as Spritemap).alpha = fadeTween.alpha;
		}		
		
		public function fadeIn():void
		{
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, 1);
		}				
		
	}

}
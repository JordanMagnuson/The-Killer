package game
{
	import game.forest.Forest;
	import game.Location;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import rooms.MyWorld;
	
	public class Ground extends Entity
	{	
		public static const y:Number = 175;
		
		/**
		 * Ground graphic
		 */
		[Embed(source = '../../assets/desert/ground_desert.png')] private const GROUND_DESERT:Class;
		[Embed(source = '../../assets/forest/ground_forest.png')] private const GROUND_FOREST:Class;
		[Embed(source = '../../assets/snow/ground_snow.png')] private const GROUND_SNOW:Class;
		[Embed(source = '../../assets/plains/ground_plains.png')] private const GROUND_PLAINS:Class;
		[Embed(source = '../../assets/beach/ground.png')] private const GROUND_BEACH:Class;
		[Embed(source = '../../assets/jungle/ground_jungle.png')] private const GROUND_JUNGLE:Class;
		public var image:Image;	
		
		/**
		 * 
		 * @param	location	The location for this ground, which determines its image.
		 */
		public function Ground(location:Location) 
		{
			// Choose image based on location
			switch (location.type)
			{
				case 'forest':
					image = new Image(GROUND_FOREST);
					break;
				case 'desert':
					image = new Image(GROUND_DESERT);
					break;
				case 'snow':
					image = new Image(GROUND_SNOW);
					break;
				case 'plains':
					image = new Image(GROUND_PLAINS);
					break;		
				case 'beach':
					image = new Image(GROUND_BEACH);
					break;				
				case 'jungle':
					image = new Image(GROUND_JUNGLE);
					break;
			}
			graphic = image;
			
			// Hit box
			image.originX = 0;
			image.originY = 0;
			image.x = -image.originX;
			image.y = -image.originY;	
			
			setHitbox(image.width, image.height, image.originX, image.originY);					
			
			// Starting location
			x = FP.screen.width;
			y = Ground.y;
			
			layer = 12;
		}
		
		override public function update():void 
		{
			super.update();
			// Move ground left
			if (x > -image.width/2)
			{
				if (Global.player.walking)
				{
					if (MyWorld.fourthFrame == 1)
					{
						x -= (Global.WALKING_SPEED / 50);
					}
				}				
			}
			// Remove old ground
			else if (MyWorld.oldGround)
			{
				if (this == MyWorld.ground)
				{
					FP.world.remove(MyWorld.oldGround);
				}
			}
		}
	}
}
package game.jungle 
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import rooms.MyWorld;
	import game.Global;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class StartingScene extends Entity
	{
		[Embed(source = '../../../assets/jungle/starting_scene.png')] public var SPRITE:Class;	
		public var image:Image = new Image(SPRITE);
		
		/**
		 * Distance can be "close", "mid", or "far", and determines the speed
		 * at which the item passes the player. close items are in front of the player.
		 */
		public var distance:String;		
		
		/**
		 * Movement. 
		 * These variables are used so that items never travel less than one pixel
		 * per frame, which keeps slow-moving items in sync. 
		 * See http://flashpunk.net/forums/index.php?topic=672.0
		 */
		public var moveDist:Number = 0;
		public var moveCounter:Number = 0;		
		public var offScreen:Boolean = false;		
		
		public function StartingScene() 
		{
			graphic = image;
			type = 'starting_scene';		
			distance = 'mid';
			
			// Layer
			switch (distance)
			{
				case 'close':
					layer = FP.choose(-100, -101);
					break;
				case 'mid':
					layer = FP.choose(10, 11);
					break;
				case 'far':
					layer = FP.choose(100, 101);
					break;
			}			
		}
		
		override public function update():void 
		{
			super.update();
			
			// Destroy when off screen
			if (x < (0 - image.width) && !offScreen)
			{
				offScreen = true;
				offScreenAction();
			}
			
			// Item speed
			if (Global.player.walking)
			{
				switch (distance)
				{
					case 'mid':
						// Move mid distance objects exacly 1 pixel every other frame.
						if (MyWorld.oddFrame == 1)
						{
							x -= FP.rate * (Global.WALKING_SPEED / 100);
						}
						break;
					case 'close':
						// Move close distance objects exacly 1 pixel every frame.
						x -= FP.rate * (Global.WALKING_SPEED / 100);
						break;				
					case 'far':
						// Move close distance objects exacly 1 pixel every 3rd frame.
						if (MyWorld.thirdFrame == 1)
						{
							x -= FP.rate * (Global.WALKING_SPEED / 100);
						}
						break;										
				}
			}
		}		
		
		public function offScreenAction():void
		{
			destroy();
		}
		
		
		public function destroy():void
		{
			FP.world.remove(this);
		}		
		
	}

}
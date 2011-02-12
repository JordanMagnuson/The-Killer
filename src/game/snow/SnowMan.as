package game.snow
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class SnowMan extends Item
	{	
		public static var seen:Boolean = false;
		
		/**
		 * Graphics
		 */
		[Embed(source = '../../../assets/snow/snow_man.png')] private const SPRITE01:Class;				
		
		public function SnowMan() 
		{	
			super(SPRITE01, 'mid', false);
			type = 'snow_man';		
		}
		
		override public function update():void 
		{
			super.update();
		}
	}
}
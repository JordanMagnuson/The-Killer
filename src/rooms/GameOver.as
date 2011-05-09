package rooms 
{
	import game.EndScreen02;
	import game.FadeIn;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Screen;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import game.Colors;
	import game.Global;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class GameOver extends World
	{
		public var request:URLRequest;
		public var learnMoreGameTrekkingCambodiaURL:String = "http://www.gametrekking.com/blog/cambodia-like-no-place-ive-been";
		public var learnMoreKillingFieldsURL:String = "http://en.wikipedia.org/wiki/The_killing_fields";
		public var learnMoreCambodiaURL:String = "http://en.wikipedia.org/wiki/Cambodia";
		
		public function GameOver() 
		{
			FP.width = 600;
			FP.height = 400;
			FP.screen = new Screen();	
		}
		
		override public function begin():void
		{
			FP.rate = 0.4;
			add(new FadeIn(Colors.BLACK, 6));
			if (Global.mercifulShot)
				add(new Entity(0, 0, new Image(Assets.END_SCREEN_01_MERCY)));
			else if (Global.exploded)
				add(new Entity(0, 0, new Image(Assets.END_SCREEN_01_EXPLOSION)));
			else
				add(new Entity(0, 0, new Image(Assets.END_SCREEN_01_KILLER)));				
		}
		
		override public function update():void
		{
			//if (Global.endScreenFades == 1 && Input.mouseReleased)
			//{
				//add(new EndScreen02);
			//}
			if (Global.endScreen >= 2 && Input.pressed(Key.SPACE))
			{  
				request = new URLRequest(learnMoreGameTrekkingCambodiaURL);
				try {
				  navigateToURL(request, '_blank'); // second argument is target
				} catch (e:Error) {
				  trace("Error occurred!");
				}
			}
			//if (Global.endScreen >= 2 && Input.pressed(Key.X))
			//{
				//request = new URLRequest(learnMoreCambodiaURL);
				//try {
				  //navigateToURL(request, '_blank'); // second argument is target
				//} catch (e:Error) {
				  //trace("Error occurred!");
				//}
			//}
			super.update();
		}		
		
	}

}
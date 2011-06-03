package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import rooms.MyWorld;
	import rooms.MusicChoice;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class MusicSelectorButton extends Entity
	{
		public var image:Image = Image.createRect(179, 93, Colors.OFF_WHITE);
		
		public function MusicSelectorButton(x:Number, y:Number) 
		{
			super(x, y, image);
			image.alpha = 0.5;
			image.visible = false;
			setHitboxTo(image);
			layer = 100;
		}
		
		override public function update():void
		{
			if (collidePoint(x, y, Input.mouseX, Input.mouseY))
			{
				image.visible = true;
				if (Input.mousePressed)
				{
					Global.MUSIC_WHILE_WALKING = true;
					Global.server.sendMusicChoice();
					FP.world = new MyWorld;
				}
			}
			else
			{
				image.visible = false;
			}
		}
		
	}

}
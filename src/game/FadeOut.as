package game
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.ColorTween;
	import rooms.GameOver;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class FadeOut extends Entity
	{
		private const BLACK:uint = 0xFF000000;
		
		// use ColorTween to control the alpha fading
		private var _alphaTween:ColorTween;
		private var _bufferAlarm:Alarm;
		private var _fadeComplete:Boolean = false;
		private var _goto:World;
		private var _buffer:Number;
		
		/**
		 * Constructor. Can be used to set the time and time for the fade out.
		 * @param	goto		The world to go to after the fade finishes.		
		 * @param	color		The color to fade out to.		
		 * @param	time		The number of seconds to fade over.
		 * @param 	buffer		The number of seconds to wait after the fade, before switching worlds.
		 */		
		public function FadeOut(goto:World, color:uint = BLACK, time:Number = 3, buffer:Number = 0) 
		{
			_goto = goto;
			_buffer = buffer;
			
			// create a rectangle the size of the screen.
			graphic = Image.createRect(FP.width, FP.height, color);
			(graphic as Image).alpha = 0;
			layer = -1000;
			
			// set the buffer alarm.
			_bufferAlarm = new Alarm(buffer, switchWorlds);
			addTween(_bufferAlarm);
			
			// start the fading.
			_alphaTween = new ColorTween(startBuffer);
			addTween(_alphaTween);		
			_alphaTween.tween(time, 0x000000, color, 0, 1);		
		}
		
		/**
		 * Update the fade.
		 */		
		override public function update():void 
		{		
			super.update();
	
			// update our alpha.
			(graphic as Image).alpha = _alphaTween.alpha;			
		}
		
		/**
		 * Start Buffer
		 */
		public function startBuffer():void
		{
			if (_buffer > 0)
			{
				_bufferAlarm.start();
			}
			else	
				switchWorlds();
		}
		
		/**
		 * Switch worlds
		 */
		public function switchWorlds():void
		{		
			trace('switch worlds');
			FP.world = new GameOver;
		}
	}
}
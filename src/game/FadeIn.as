package game
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class FadeIn extends Entity
	{
		private const BLACK:uint = 0xFF000000;
		
		// use ColorTween to control the alpha fading
		private var _alphaTween:ColorTween;
		private var _bufferAlarm:Alarm;
		private var _color:uint;
		private var _time:Number;
		private var _bufferComplete:Boolean = false;		
		
		/**
		 * Constructor. Can be used to set the time and time for the fade out.
		 * @param	color		The color to fade in from.		
		 * @param	time		The number of seconds to fade over.
		 * @param 	buffer		The number of seconds to wait before starting the fade in.
		 */		
		public function FadeIn(color:uint = BLACK, time:Number = 3, buffer:Number = 0) 
		{
			_color = color;
			_time = time;
			
			// create a rectangle the size of the screen.
			graphic = Image.createRect(FP.width, FP.height, color);
			layer = -1000;
			
			// start the buffer alarm.
			_bufferAlarm = new Alarm(buffer, startFade);
			addTween(_bufferAlarm);
			if (buffer > 0)
				_bufferAlarm.start();
			else
			{
				startFade();
			}
		}
		
		/**
		 * Update the fade.
		 */		
		override public function update():void 
		{		
			super.update();
	
			// update our alpha.
			if (_bufferComplete)
				(graphic as Image).alpha = _alphaTween.alpha;			
		}
		
		/**
		 * Start fade.
		 */
		public function startFade():void
		{
			_alphaTween = new ColorTween(destroy);
			addTween(_alphaTween);		
			_alphaTween.tween(_time, _color, 0x000000, 1, 0, Ease.quadIn);	
			_bufferComplete = true;
		}
		
		/**
		 * Destroy after fade in.
		 */
		public function destroy():void
		{
			FP.world.add(new ClickToContinue);
			FP.world.remove(this);
		}
		
	}
}
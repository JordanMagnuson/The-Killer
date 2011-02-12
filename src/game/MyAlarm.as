package game 
{
	import net.flashpunk.tweens.misc.Alarm;
	import game.Player;
	
	/**
	 * Same as Alarm class, but only updates if the player is walking
	 */
	public class MyAlarm extends Alarm
	{
		
		public function MyAlarm(duration:Number, complete:Function = null, type:uint = 0) 
		{
			super(duration, complete, type);
		}
		
		override public function update():void
		{
			// Only update the myAlarms if the player is walking
			if (Global.player.walking) 
			{ 
				super.update();
			}		
		}
		
	}

}
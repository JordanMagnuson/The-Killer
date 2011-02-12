package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class PlayerDying extends Entity
	{
		public const FADE_OUT_DURATION:Number = 5;		
		
		public var graveStoneAlarm:Alarm;
		public var fadeTween:ColorTween;
		
		/**
		 * Player graphic
		 */
		[Embed(source='../../assets/player_dying.png')] private const PLAYER_DYING:Class;
		public var sprPlayer:Spritemap = new Spritemap(PLAYER_DYING, 22, 17);		
		
		public function PlayerDying() 
		{
			// Graphic
			sprPlayer.add("die", [0, 1, 2, 3, 4], 2, false);
			graphic = sprPlayer;
			sprPlayer.play("die");
			
			// Hit box
			sprPlayer.originX = 0;
			sprPlayer.originY = sprPlayer.height;
			sprPlayer.x = 0;
			sprPlayer.y = -sprPlayer.originY;	
			
			setHitbox(sprPlayer.width, sprPlayer.height, sprPlayer.originX, sprPlayer.originY);				
			
			// Gravestone alarm
			graveStoneAlarm = new Alarm(5, fadeOut);
			addTween(graveStoneAlarm);
			graveStoneAlarm.start();
			
			fadeTween = new ColorTween;
			fadeTween.alpha = 1;
		}
		
		override public function update():void 
		{
			super.update();
			(graphic as Spritemap).alpha = fadeTween.alpha;
		}
		
		public function fadeOut():void
		{
			FP.world.add(new Gravestone);
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(FADE_OUT_DURATION, Colors.WHITE, Colors.WHITE, 1, 0);			
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
	}
}
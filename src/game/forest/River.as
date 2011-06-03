package game.forest
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import game.Ground;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	import game.Global;
	
	public class River extends Item
	{	
		/**
		 * Graphics
		 */
		[Embed(source='../../../assets/river.png')] private const SPRITE01:Class;		
		
		/**
		 * Sound
		 */
		[Embed(source='../../../assets/killer_sounds.swf', symbol='stream_30_loop_7138.wav')] private const SND_RIVER:Class;
		public var sndRiver:Sfx = new Sfx(SND_RIVER);
		public var fadeIn:SfxFader = new SfxFader(sndRiver);
		public var fadeOut:SfxFader = new SfxFader(sndRiver, destroy);	
		public var fadeStarted:Boolean = false;
		
		
		public function River() 
		{
			spriteMap = new Spritemap(SPRITE01, 24, 28);
			
			rawSprite = SPRITE01;		
			super(rawSprite, 'mid', false);
			spriteMap.add("flow", [0, 1, 2], 10, true);
			graphic = spriteMap;
			type = 'river';
			
			layer = 9;			
			
			// Hit box to bottom left, so we can place all items at same starting location
			spriteMap.originX = 0;
			spriteMap.originY = 3;
			spriteMap.x = 0;
			spriteMap.y = -spriteMap.originY;	
			
			setHitbox(spriteMap.width, spriteMap.height, spriteMap.originX, spriteMap.originY);	
			
			// Sound
			//sndRiver.volume = 0;
			sndRiver.loop(0, 1);
			//addTween(fadeIn);
			//fadeIn.fadeTo(1, 3);
		}
		
		override public function update():void 
		{
			super.update();
			spriteMap.play("flow");
			
			if (Global.playSounds)
			{
				sndRiver.pan = FP.scale(x, 0, FP.screen.width, -1, 1);
				if (x <= 0 && !fadeStarted)
				{
					trace('start river fade out');
					fadeStarted = true;
					addTween(fadeOut);
					fadeOut.fadeTo(0, 5);
				}
				if (!fadeStarted)
				{
					sndRiver.volume = FP.scale(x, 40, FP.screen.width, 0.7, 0.1);
				}
			}
			else
				sndRiver.volume = 0;
		}
		
		override public function offScreenAction():void
		{
		}
	}
}
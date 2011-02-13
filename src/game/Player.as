package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import rooms.MyWorld;
	
	public class Player extends Entity
	{
		
		public const PUSH_DISTANCE:Number = 10;
		
		/**
		 * Player speed determines how fast items approach,
		 * as well as animation speed. 100 is normal.
		 */
		public var animSpeed:Number;
		
		public var walking:Boolean = false;
		
		public var canPush:Boolean = true;
		
		/**
		 * Player graphic
		 */
		[Embed(source='../../assets/killer.png')] private const KILLER:Class;
		public var spritemap:Spritemap = new Spritemap(KILLER, 20, 20);			
		
		/**
		 * Sound
		 */
		[Embed(source='../../assets/sounds.swf', symbol='walking.wav')] private const SND_WALKING:Class;
		public var sndWalking:Sfx = new Sfx(SND_WALKING);			
		
		public function Player() 
		{
			// Graphic
			spritemap.add("stand", [0], 20, false);
			animSpeed = Global.WALKING_SPEED / 10;
			spritemap.add("push", [0, 1, 2, 3], animSpeed * 0.8, false);
			spritemap.add("walk", [4, 5, 6, 7], animSpeed, true);
			spritemap.add("standing_push", [8, 9, 10, 11], animSpeed * 0.8, false);
			graphic = spritemap;
			spritemap.play("stand");
			
			// Hit box
			spritemap.originX = 0;
			spritemap.originY = spritemap.height;
			spritemap.x = 0;
			spritemap.y = -spritemap.originY;	
			
			setHitbox(spritemap.width, spritemap.height, spritemap.originX, spritemap.originY);				
			
			// Location
			x = 50;
			y = Ground.y;
			
			// Input
			Input.define("X", Key.SPACE);
		}
		
		override public function update():void 
		{
			//trace('current anim:' + spritemap.currentAnim);
			super.update();
			if (Global.playSounds && walking && !sndWalking.playing)
			{
				sndWalking.loop(0.5);
			}
			
			if (Input.check("X"))
			{
				if (!Global.startedWalking)
				{
					Global.playSounds = false;
					(FP.world as MyWorld).soundController.currentSound.stop();
					FP.world.remove((FP.world as MyWorld).soundController);
					(FP.world as MyWorld).music.loop();
					standingPush();
					Global.startedWalking = true;
					walking = false;
				}
				if (spritemap.currentAnim == 'standing_push' && spritemap.complete)
				{
					spritemap.play('walk');
					walking = true;
				}
				if (spritemap.currentAnim == 'stand')
				{
					spritemap.play('walk');
					walking = true;
				}
				else if (spritemap.currentAnim == 'walk')
				{
					if (Global.victim.x - x <= PUSH_DISTANCE)
						push();
					
					
					// Reset canPush on the 3rd frame of the walking animation
					if (spritemap.index == 3)
					{
						canPush = true;
					}
					// Allow a push every time the walking animation cycles back to the 0 frame
					else if (spritemap.index == 0 && canPush)
					{
						if (FP.random < 0)
						{
							push();
						}
						canPush = false;
					}
					walking = true;
				}
				else if (spritemap.currentAnim == 'push' && spritemap.complete)
				{
					spritemap.play('walk');
					canPush = true;
					walking = true;
				}
			}
			else
			{
				walking = false;
				spritemap.play("stand");
			}
			
			if (Input.released("X") && !Global.stillInJungle)
			{
				FP.world.add(Global.playerShooting = new PlayerShooting);
				Global.playerShooting.x = x;
				Global.playerShooting.y = y;
				FP.world.add((FP.world as MyWorld).soundController = new SoundController((FP.world as MyWorld).location));
				if ((FP.world as MyWorld).time == 'night')
					(FP.world as MyWorld).soundController.startNight();
				(FP.world as MyWorld).music.stop();
				Global.playSounds = true;
				FP.world.remove(this);
				
				
				//spritemap.play('push');
				//graphic = pushing;
				//pushing.play();
				//sndWalking.stop();
				//var playerDying:PlayerDying = new PlayerDying;
				//FP.world.add(playerDying);
				//playerDying.x = x;
				//playerDying.y = y;
				//FP.world.remove(this);
			}
		}
		
		public function standingPush():void
		{
			spritemap.play('standing_push');
			Global.victim.stumbleAlarm.reset(Global.victim.STUMBLE_TIME);
		}
		
		public function push():void
		{
			trace('push');
			spritemap.play('push');
			Global.victim.stumbleAlarm.reset(Global.victim.STUMBLE_TIME);			
		}
		
	}
}
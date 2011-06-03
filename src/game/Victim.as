package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import rooms.MyWorld;
	
	public class Victim extends Entity
	{
		public static const FADE_OUT_DURATION:Number = 2;
		
		public const WALK_DELAY_TIME:Number = 1;
		public const STOP_DELAY_TIME:Number = 0.7;
		public const STUMBLE_TIME:Number = 0.2;
		public const FAST_WALK_TIME:Number = 3;
		
		public const DEFAULT_WALKING_SPEED:Number = 0.5;
		public const WALK_FAST_SPEED:Number = 0.6;
		public const RUN_SPEED:Number = 1.3;
		public var walkingSpeed:Number = DEFAULT_WALKING_SPEED;
		
		public const DEFAULT_ANIM_SPEED:Number = 10;
		public var animSpeed:Number = DEFAULT_ANIM_SPEED;
		
		public var walking:Boolean = false;
		public var stumbling:Boolean = false;
		public var fastWalking:Boolean = false;
		public var kneeling:Boolean = false;
		public var runningAway:Boolean = false;
		
		
		public var walkingAlarm:Alarm =  new Alarm(WALK_DELAY_TIME, slowWalk);
		public var stoppingAlarm:Alarm = new Alarm(STOP_DELAY_TIME, stop);
		
		public var stumbleAlarm:Alarm = new Alarm(STUMBLE_TIME, stumble);
		public var fastWalkAlarm:Alarm = new Alarm(FAST_WALK_TIME, slowWalk);
		
		public var fadeTween:ColorTween;	
		public var waitToFadeAlarm:Alarm;
		public var fading:Boolean = false;
		
		/**
		 * Graphic
		 */
		[Embed(source='../../assets/victim.png')] private const VICTIM:Class;
		public var spritemap:Spritemap = new Spritemap(VICTIM, 20, 20);	
		
		/**
		 * Sound
		 */
		[Embed(source = '../../assets/killer_sounds.swf', symbol = 'walk_fast_15562_modified.wav')] private const SND_WALK_FAST:Class;
		public var sndWalkFast:Sfx = new Sfx(SND_WALK_FAST);
				
		
		public function Victim() 
		{
			// Graphic
			spritemap.add("stand", [0], 20, false);
			spritemap.add("stumble", [0, 1, 2, 3], animSpeed, false);
			spritemap.add("walk", [5, 6, 7, 4], animSpeed * 0.8, true);
			spritemap.add("fast_walk", [5, 6, 7, 4], animSpeed * 1.2, true);
			spritemap.add("run", [5, 6, 7, 4], animSpeed * 1.4, true);
			spritemap.add("kneel", [8, 9, 10, 11], 1, false);
			graphic = spritemap;
			spritemap.play("stand");
			
			// Hit box
			spritemap.originX = 0;
			spritemap.originY = spritemap.height;
			spritemap.x = 0;
			spritemap.y = -spritemap.originY;	
			
			setHitbox(spritemap.width, spritemap.height, spritemap.originX, spritemap.originY);				
			
			// Location
			x = Global.player.x + 10;
			y = Ground.y;
			
			addTween(walkingAlarm);
			addTween(stoppingAlarm);
			
			addTween(stumbleAlarm);
			addTween(fastWalkAlarm);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (fading)
				spritemap.alpha = fadeTween.alpha;
						
			if (spritemap.currentAnim == 'stumble' && spritemap.complete)
			{
				//Global.WALKING_SPEED = 100;
				stumbling = false;
				fastWalk();
			}
			
			if (!walking)
			{
				walkingSpeed = DEFAULT_WALKING_SPEED;
			}
			
			if (stumbling)
			{
				//trace('stumbling');
				spritemap.play('stumble');
				x += 0.2;
			}
			else if (walking)
			{
				//trace('walking');
				spritemap.play("walk");
				walkingSpeed -= 0.0001;
				if (Global.player.walking)
					x -= (DEFAULT_WALKING_SPEED - walkingSpeed);
				else if (!Global.player.walking)
				{
					x += walkingSpeed;
					if (!stoppingAlarm.active)
					{
						stoppingAlarm.active = true;
						stoppingAlarm.reset(STOP_DELAY_TIME);
					}
				}
			}
			else if (fastWalking)
			{
				//trace('fast walking');
				spritemap.play("fast_walk");
				if (Global.player.walking)
					x += WALK_FAST_SPEED - DEFAULT_WALKING_SPEED;
				else
					slowWalk();
			}
			else if (runningAway)
			{
				//trace('fast walking');
				spritemap.play("run");
				x += RUN_SPEED;
			}			
			else if (kneeling)
			{
				spritemap.play('kneel');
			}
			else
			{
				//trace('standing');
				spritemap.play("stand");
				if (Global.player.walking)
				{
					if (MyWorld.oddFrame)
						x -= 0.5;
					if (!walkingAlarm.active && (x - Global.player.x <= 30))
					{
						walkingAlarm.active = true;
						walkingAlarm.reset(WALK_DELAY_TIME * FP.random);
					}
				}
			}
			
		}
		
		public function kneel():void
		{
			walking = false;
			fastWalking = false;
			kneeling = true;
		}
		
		public function stop():void
		{
			if (sndWalkFast.playing)
				sndWalkFast.stop();			
			walking = false;
			stoppingAlarm.active = false;
		}
		
		public function slowWalk():void
		{
			if (fastWalking)
			{
				walking = true;
				fastWalking = false;
				walkingAlarm.active = false;
			}
		}
		
		public function fastWalk():void
		{
			fastWalkAlarm.reset(FAST_WALK_TIME);
			walking = false;
			fastWalking = true;
			walkingAlarm.active = false;
		}
		
		public function runAway():void
		{
			walking = false;
			fastWalking = false;
			runningAway = true;
			walkingAlarm.active = false;			
		}
		
		public function stumble():void
		{
			//Global.WALKING_SPEED *= 0.5;
			spritemap.play('stumble');
			stumbling = true;
			
			var vol:Number = 0.5 + 0.5 * FP.random;
			if (Global.playSounds)
				sndWalkFast.play(vol);
		}
		
		public function waitToFade():void
		{
			waitToFadeAlarm = new Alarm(Global.victimStillRun.DISPLAY_EACH_DURATION, fadeOut);
			addTween(waitToFadeAlarm, true);
		}
		
		public function fadeOut():void
		{
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(FADE_OUT_DURATION, Colors.WHITE, Colors.WHITE, 1, 0);	
			fading = true;
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
				
		
	}
}
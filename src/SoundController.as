package  
{
	import flash.net.LocalConnection;
	import game.Location;
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import rooms.MyWorld;
	import game.Global;

	public class SoundController extends Entity
	{
		public const FADE_DURATION:Number = 10;
		
		public var location:Location;
		public var currentSound:Sfx;
		public var newSound:Sfx;
		public var fader:SfxFader;
		public var newSoundFader:SfxFader
		public var inProcess:Boolean = false;
		public var soundsStopped:Boolean = false;
		
		public var fadingOut:Boolean = false;
		
		public var time:String;

		
		public function SoundController(location:Location) 
		{
			trace('sound controller init');
			this.location = location;
		}
		
		override public function added():void
		{
			if ((FP.world as MyWorld).time == 'day')
				currentSound = location.daySound;
			else
				currentSound = location.nightSound;
			currentSound.loop(1);
			fader = new SfxFader(currentSound, fadeComplete);
			addTween(fader);			
		}
		
		override public function update():void
		{
			//trace('play sounds? ' + Global.playSounds)
			if (!Global.playSounds && !Global.fadeSounds && !soundsStopped)
				stopSounds();
			super.update();
			//trace('in process: ' + inProcess);
		}
		
		public function fadeOut(duration:Number = 15):void
		{
			if (inProcess)
			{
				trace("sc in process - can't fade");
				return;
			}
			
			Global.fadeSounds = true;
			Global.playSounds = false;
			fader.fadeTo(0, duration);
			//if (newSound)
				//newSound.stop();
			fadingOut = true;
			
		}		
		
		public function stopSounds():void
		{
			trace('sc stop sounds immediately');
			if (!Global.fadeSounds)
			{
				trace('stopping sounds');
				fadingOut = true;
				if (inProcess) fader.fadeTo(0, 0.01);
				if (newSound) newSound.stop();
				if (currentSound) currentSound.stop();
				soundsStopped = true;
			}
			
			//Global.playSounds = false;
			//if (!inProcess && !fadingOut)
			//{
				//fadingOut = true;
				//fader.a
				//trace('stop sounds going');
				//if (newSound) newSound.stop();
				//fader.fadeTo(0, 3);
				//if (currentSound) currentSound.stop();
//				if (fader) removeTween(fader);
				//FP.world.remove(this);
			//}
		}
		
		public function changeLocation(newLocation:Location):void
		{
			trace('change location');
			if (!Global.playSounds || Global.fadeSounds)
				return;
			if (inProcess == true)
			{
				trace('in process');
				trace('current sound vol: ' + currentSound.volume);
				trace('new sound vol: ' + newSound.volume);
			}
			else
			{
				if ((FP.world as MyWorld).time == 'day')
				{
					newSound = newLocation.daySound;
				}
				else 
				{
					newSound = newLocation.nightSound;
				}
				fader.crossFade(newSound, true, FADE_DURATION, 1);
				currentSound = newSound;
				inProcess = true;
			}
		}
		
		public function fadeComplete():void
		{
			trace('sc fade complete');
			trace('time of day: ' + (FP.world as MyWorld).time);
			inProcess = false;
			
			if (fadingOut)
			{
				fadingOut = false;
				Global.fadeSounds = false;
			}			
			
			if (Global.fadeSounds && !fadingOut)
				fadeOut();
			
			if (Global.fadeSounds)
				return;
				
			if (!Global.playSounds)
			{
				stopSounds();
			}
			
			if ((FP.world as MyWorld).time == 'day' && currentSound != (FP.world as MyWorld).location.daySound)
			{
				trace('catching up with day');
				startDay();
			}
			else if ((FP.world as MyWorld).time != 'day' && currentSound != (FP.world as MyWorld).location.nightSound)
			{
				trace('catching up with night');
				startNight();
			}
			else 
			{
				trace('no need to catch up');
			}
		}
		
		public function startNight():void
		{
			if (!Global.playSounds || Global.fadeSounds)
				return;
				
			trace('start night');
			time = 'night';
			if (inProcess == true)
			{
				trace('in process');
				trace('current sound vol: ' + currentSound.volume);
				trace('new sound vol: ' + newSound.volume);
			}			
			else
			{			
				newSound = (FP.world as MyWorld).location.nightSound;
				fader.crossFade(newSound, true, FADE_DURATION, 1);
				currentSound = newSound;	
				inProcess = true;
			}
		}
		
		public function startDay():void
		{
			if (!Global.playSounds || Global.fadeSounds)
				return;
				
			trace('start day');
			time = 'day';
			if (inProcess == true)
			{
				trace('in process');
				trace('current sound vol: ' + currentSound.volume);
				trace('new sound vol: ' + newSound.volume);
			}			
			else
			{					
				newSound = (FP.world as MyWorld).location.daySound;
				fader.crossFade(newSound, true, FADE_DURATION, 1);
				currentSound = newSound;	
				inProcess = true;
			}
		}
		
	}

}
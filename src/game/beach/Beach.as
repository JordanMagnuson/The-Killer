package game.beach 
{

	import flash.geom.Point;
	import game.*;
	import game.desert.Cactus;
	import game.forest.ForestPalm;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import game.Player;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import net.flashpunk.Sfx;
	import rooms.MyWorld;
	
	public class Beach extends Location
	{		
		public var creationNumber:Number;
		public var waves:Waves;
		
		//public var waterCover:Backdrop = new Backdrop(Assets.WATER_COVER, false, false);
		//public var waterCover:WaterCover = new WaterCover;
		
		/**
		 * Sound
		 */
		[Embed(source='../../../assets/sounds.swf', symbol='waves_ambient.wav')] private const DAY_SOUND:Class;
		[Embed(source='../../../assets/sounds.swf', symbol='waves_ambient.wav')] private const NIGHT_SOUND:Class;
		
		[Embed(source='../../../assets/sounds.swf', symbol='wind_burst.wav')] private const SND_WIND:Class;
		public var sndWind:Sfx = new Sfx(SND_WIND);				
		
		[Embed(source='../../../assets/sounds.swf', symbol='gulls_01.wav')] private const SND_GULLS01:Class;
		public var sndGulls01:Sfx = new Sfx(SND_GULLS01);	
		[Embed(source='../../../assets/sounds.swf', symbol='gulls_02.wav')] private const SND_GULLS02:Class;
		public var sndGulls02:Sfx = new Sfx(SND_GULLS02);	
		[Embed(source='../../../assets/sounds.swf', symbol='gulls_03.wav')] private const SND_GULLS03:Class;
		public var sndGulls03:Sfx = new Sfx(SND_GULLS03);		
		public var sndGullsRandom:Sfx = FP.choose(new Sfx(SND_GULLS01), new Sfx(SND_GULLS02), new Sfx(SND_GULLS03));
				
		
		public function Beach() 
		{
			super(DAY_SOUND, NIGHT_SOUND);
			type = 'beach';
			waves = new Waves;
		}
		
		override public function added():void
		{
			FP.world.add(waves);
			//FP.world.add(waterCover);
		}
		
		override public function update():void
		{
			//waterCover.backdrop.alpha = waves.image.alpha;
			super.update();
		}
		
		/**
		 * Controls item creation for this location.
		 */		
		override public function createItem():void
		{
			super.createItem();
			
			creationNumber = FP.random;	
			
			// Mid Distance
			if (FP.random > 0.25)
			{		
				//if (creationNumber < 0.005 && Castle.seen == false)
				//{
					//FP.world.add(new Castle);
					//Castle.seen = true;
				//}
				if (creationNumber < 0.05)
				{
					FP.world.add(new BeachPalm);
				}
				else if (creationNumber < 0.4)
				{
					FP.world.add(new BeachGrass);
				}
				else if (creationNumber < 1)
				{
					FP.world.add(new SandDune);
				}
			}			
			
			// Sounds
			if (FP.random > 0.4 && Global.playSounds)
			{
				var pan:Number = FP.choose( -1, 1) * FP.random;
				var vol:Number = 0.3 + 0.7 * FP.random;
				// Night sounds
				if ((FP.world as MyWorld).time == 'night')
				{
					if (creationNumber < 0.05 && !sndGullsRandom.playing)
					{
						sndGullsRandom = FP.choose(sndGulls01, sndGulls02, sndGulls03);
						sndGullsRandom.play(vol, pan);
					}					
					else if (creationNumber < 0.15 && !sndWind.playing)
					{
						sndWind.play(vol, pan);
					}		
				}
				// Day sounds
				else
				{
					if (creationNumber < 0.1 && !sndWind.playing)
					{
						sndWind.play(vol, pan);
					}						
					else if (creationNumber < 0.6 && !sndGullsRandom.playing)
					{
						sndGullsRandom = FP.choose(sndGulls01, sndGulls02, sndGulls03);
						sndGullsRandom.play(vol, pan);
					}					
				}
			}	
			
		}	
		
		override public function removed():void
		{
			waves.fadeOut();		
		}

		/**
		 * Stuff to set up at the beginning of the game.
		 * @param	world	Current world.
		 */
		override public function gameStart(world:World):void
		{
			super.gameStartItem(world, new SandDune);	
		}
		
		//override public function render():void
		//{
			//super.render();
			//waterCover.render(FP.buffer, new Point(0, FP.height), FP.camera);
		//}
		
	}

}
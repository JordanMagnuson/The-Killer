package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Input;
	import rooms.MyWorld;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class PlayerShooting extends Entity
	{
		public const MAX_TIME_TILL_KNEEL:Number = 8;
		public const MIN_TIME_TILL_KNEEL:Number = 4;
		
		public var kneelAlarm:Alarm;
		
		/**
		 * Player graphic
		 */
		[Embed(source='../../assets/killer_no_gun.png')] private const SPRITE:Class;
		public var image:Image = new Image(SPRITE);
		
		public function PlayerShooting() 
		{
			graphic = image;
			
			// Hit box
			image.originX = 0;
			image.originY = image.height;
			image.x = 0;
			image.y = -image.originY;	
			
			setHitbox(image.width, image.height, image.originX, image.originY);
			
			// Victim kneels
			kneelAlarm = new Alarm(MAX_TIME_TILL_KNEEL * FP.random + MIN_TIME_TILL_KNEEL, makeVictimKneel);
		}
		
		override public function added():void
		{
			FP.world.add(new Gun);
			FP.world.add(Global.crossHair = new Crosshair);
			addTween(kneelAlarm, true);
		}
		
		override public function update():void
		{
			if (Input.mousePressed && !Global.shotFired)
			{
				Global.shotFired = true;
				
				// Stop sounds
				Global.playSounds = false;
				(FP.world as MyWorld).soundController.currentSound.stop();
				FP.world.remove((FP.world as MyWorld).soundController);		
				
				// Play music
				(FP.world as MyWorld).musicEnd.play();
				
				// get rid of crosshairs
				FP.world.remove(Global.crossHair);
				
				// Slow everything down (clouds)
				FP.rate = 0.2;
				
				// Kill victim
				FP.world.add(Global.deadVictim = new DeadVictim);
				Global.deadVictim.x = Global.victim.x;
				Global.deadVictim.y = Global.victim.y;
				FP.world.remove(Global.victim);
			}
			super.update();
		}
		
		public function makeVictimKneel():void
		{
			Global.victim.kneel();
		}
		
	}

}
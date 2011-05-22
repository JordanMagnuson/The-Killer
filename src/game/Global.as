package game 
{
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Global
	{
		// Global constants
		public static const WALKING_SPEED:Number = 100;
		public static const TIME_IN_JUNGLE:Number = 115; // 115
		public static const TIME_IN_FOREST:Number = 30; // 115
		public static const TIME_IN_BEACH:Number = 30; // 115
		public static const EARLIEST_EXPLOSION:Number = 100;
		public static const LATEST_EXPLOSION:Number = 175;
		public static const EXPLOSION_CHANCE:Number = 0.25;
		
		// Global variables
		public static var shouldExplode:Boolean = false;
		public static var explosionTime:Number = 0;
		public static var exploded:Boolean = false;
		public static var startedWalking:Boolean = false;
		public static var firstPush:Boolean = false;
		public static var farEnough:Boolean = true;
		public static var playSounds:Boolean = true;
		public static var shotFired:Boolean = false;
		public static var mercifulShot:Boolean = false;
		public static var stillInJungle:Boolean = true;
		public static var touchedPlains:Boolean = false;
		public static var reachedPlains:Boolean = false;
		public static var numberOfStops:int = 0;
		public static var locationChanges:int = 0;
		
		public static var endScreen:int = 0;
		
		public static var server:DataToServer;
		public static var player:Player;
		public static var playerShooting:PlayerShooting;
		public static var gun:Gun;
		public static var victim:Victim;
		public static var victimStillRun:VictimStillRunController;
		public static var deadVictim:DeadVictim;
		public static var deadUnderground:DeadUnderground;
		public static var crossHair:Crosshair;
		public static var view:View;
		public static var timeCounter:TimeCounter;
	}

}
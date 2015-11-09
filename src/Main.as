package  
{
	import net.flashpunk.*;
	import rooms.*;
	import game.*;
	import flash.ui.Mouse;
	//import flash.display.StageScaleMode;
	//import flash.geom.Rectangle;
	//import flash.display.StageDisplayState;
	
	public class Main extends Engine
	{
		public function Main() 
		{
			// Initiate the game with a 300x200 screen.
			super(600, 400, 60, false);
			
			// Scale by 200%, resulting in a 600x400 display.
			FP.screen.scale = 1;		
			FP.screen.color = Colors.WHITE;
			
			// Console for debugging
			//FP.console.enable();					
			
			
			Global.server = new DataToServer();
			FP.world = new MusicChoice;
			//FP.world = new GameOver;
			//Mouse.hide();
		}
		
		override public function init():void
		{
			// Full screen
			//FP.stage.scaleMode = StageScaleMode.SHOW_ALL;
			//FP.stage.fullScreenSourceRect = new Rectangle(0, 0, 600, 400);
			//FP.stage.displayState = StageDisplayState.FULL_SCREEN;				
			super.init();
		}
	}
}
package  
{
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Assets
	{
		[Embed(source = '../assets/music.swf', symbol = 'jonsi_tornado')] public static const MUSIC:Class;
		[Embed(source='../assets/music.swf', symbol='jonsi_tornado_end')] public static const MUSIC_END:Class;
		[Embed(source = '../assets/dead_underground.png')] public static const DEAD_UNDERGROUND:Class;
		[Embed(source = '../assets/beach/water_cover.png')] public static const WATER_COVER:Class;
		
		[Embed(source = '../assets/gunshot.swf', symbol = 'DarkoZL__Barret50_amp.wav')] public static const GUNSHOT:Class;
		[Embed(source = '../assets/sounds.swf', symbol = 'silence.wav')] public static const SILENCE:Class;
		
		// Game Over
		[Embed(source = '../assets/end_screen_01_killer.jpg')] public static const END_SCREEN_01_KILLER:Class;
		[Embed(source = '../assets/end_screen_01_mercy.jpg')] public static const END_SCREEN_01_MERCY:Class;	
		[Embed(source = '../assets/end_screen_01_explosion.jpg')] public static const END_SCREEN_01_EXPLOSION:Class;	
		[Embed(source = '../assets/end_screen_02.jpg')] public static const END_SCREEN_02:Class;
		[Embed(source = '../assets/end_screen_03.png')] public static const END_SCREEN_03:Class;
		[Embed(source = '../assets/click_to_continue_black.png')] public static const CLICK_TO_CONTINUE_BLACK:Class;
	}

}
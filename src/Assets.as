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
		[Embed(source='../assets/sounds.swf', symbol='silence.wav')] public static const SILENCE:Class;
	}

}
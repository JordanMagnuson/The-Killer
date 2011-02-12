package game.snow
{
	import game.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import game.Global;
	
	public class BarrenTree extends Item
	{	
		/**
		 * Graphics
		 */
		[Embed(source='../../../assets/snow/barren_tree01.png')] private const SPRITE01:Class;	
		[Embed(source='../../../assets/snow/barren_tree02.png')] private const SPRITE02:Class;	
		[Embed(source='../../../assets/snow/barren_tree03.png')] private const SPRITE03:Class;				
		public var mySpriteCollection:Array = new Array(SPRITE01, SPRITE02, SPRITE03);
		
		[Embed(source='../../../assets/sounds.swf', symbol='creaking.wav')] private const SND_CREAKING:Class;
		public var sndCreaking:Sfx = new Sfx(SND_CREAKING);				
		
		public function BarrenTree() 
		{
			// Random image
			rawSprite = chooseSprite(mySpriteCollection);			
			super(rawSprite, 'mid', true);
			type = 'barren_tree';
		}
		
		override public function update():void 
		{
			super.update();
			
			// Play sound
			if (Global.playSounds && FP.random < 0.002 && !sndCreaking.playing)
			{
				var pan:Number = FP.scale(x, 0, FP.screen.width, -1, 1);
				var vol:Number = 0.2 + 0.8 * FP.random;
				sndCreaking.play(vol, pan);
			}			
		}
	}
}
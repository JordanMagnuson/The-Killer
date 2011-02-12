package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;

	public class Counter extends Entity
	{
		public var elapsed:Number;
		
		public function Counter() 
		{
			this.reset();
		}
		
		public function reset():void
		{
			this.elapsed = 0;
		}
		
		override public function update():void
		{
			super.update();
			this.elapsed += FP.elapsed;
		}
		
	}

}
package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	
	public class textEntity extends Entity
	{
		public var text:Text;
		
		public function textEntity(string:String) 
		{
			text = new Text(string);
			text.size = 8;
			graphic = text;
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}
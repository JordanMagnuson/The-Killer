package game 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class View extends Entity
	{
		
		public var _tofollow:Entity;
		public var _within:Rectangle;
		public var _speed:Number;
		
		public function View(tofollow:Entity, within:Rectangle = null, speed:Number = 1) 
		{
			//set x to current camera position so we don't "jump" to 0,0 on creation
			x = FP.camera.x;
			y = FP.camera.y;
			
			setView(tofollow, within, speed);
		}
		
		
		/**
		 * Sets the view (camera) to follow a particular entity within a rectangle, at a set speed
		 * @param	tofollow	The entity to follow
		 * @param	within		The rectangle that the view should stay within (if any)
		 * @param	speed		Speed at which to follow the entity (1=static with entity, >1=follows entity)
		 * @return	void
		 */
		public function setView(tofollow:Entity, within:Rectangle = null, speed:Number = 1):void
		{
			_tofollow = tofollow;
			_within = within;
			_speed = speed;
		}
		
		override public function update():void
		{
			//follow the entity
			
			var dist:Number = FP.distance(_tofollow.x - FP.screen.width / 2, _tofollow.y - 68 - FP.screen.height / 2, FP.camera.x, FP.camera.y);
			var spd:Number = dist / _speed;
			
			FP.stepTowards(this, _tofollow.x - FP.screen.width / 2, _tofollow.y - 68 - FP.screen.height / 2, spd);
			
			FP.camera.x = int(x);
			FP.camera.y = int(y);
			
			//stay within contstraints
			if(_within != null) {
				if (FP.camera.x < _within.x) { FP.camera.x = _within.x; }
				if (FP.camera.y < _within.y) { FP.camera.y = _within.y; }
				
				if (FP.camera.x + FP.screen.width > _within.x + _within.width) { FP.camera.x = _within.x + _within.width - FP.screen.width; }
				if (FP.camera.y + FP.screen.height > _within.y + _within.height) { FP.camera.y = _within.y + _within.height - FP.screen.height; }
			}
		}
		
	}

}
package  
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	import flash.events.Event;
	import game.Global;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class DataToServer 
	{
		
		public function DataToServer() 
		{
			
		}
		
		public function sendData():void
		{
			var request:URLRequest = new URLRequest("http://www.gametrekking.com/my-games/cambodia/the-killer/save-data");
			request.method = URLRequestMethod.POST;
							
			var variables:URLVariables = new URLVariables();

			variables.exploded = 0;
			variables.shot_victim = 0;
			variables.mercy_shot = 0;
			if (Global.exploded)
				variables.exploded = 1;
			else if (Global.mercifulShot)
				variables.mercy_shot = 1;
			else
				variables.shot_victim = 1;
			request.data = variables;
							
			var loader:URLLoader = new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.dataFormat = "VARIABLES";
			try {
				loader.load(request);
			} catch (e:Error) {
				trace("Error saving play data to server.");
			}
		}
						
				
		public function onComplete (event:Event):void{
			//statusTxt1.text = event.target.data;
		}  		
		
	}

}
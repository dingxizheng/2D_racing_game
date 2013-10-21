package state
{
	import citrus.core.CitrusEngine;
	import citrus.core.State;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class myState extends State
	{
		protected var mainClass:Project1;
		
		protected var screen:MovieClip;
		
		public function myState()
		{
			mainClass = CitrusEngine.getInstance() as Project1;
		}
		
		override public function initialize():void
		{
			super.initialize();		
			initScreen();
		}
		
		protected function initScreen():void
		{
			if (screen == null)
			{
				throw new Error("ERROR: You forgot to instantiate new screen object :)");
			}	
			addChild(screen);
		}
		
		protected function buttonClicked(event:MouseEvent):void
		{
			//a concrete implementation of this method  need to be defined in child classes
		}
		
		protected function buttonOver(event:MouseEvent):void
		{
			var button:MovieClip = event.target as MovieClip;
			
			button.gotoAndStop(2);
		}
		
		protected function buttonOut(event:MouseEvent):void
		{
			var button:MovieClip = event.target as MovieClip;	
			button.gotoAndStop(1);
		}
		
		override public function destroy():void
		{
			
			removeChild(screen);
			screen = null;			
			mainClass = null;		
			super.destroy();
		}
	}
}
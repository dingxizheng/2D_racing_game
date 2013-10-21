package state
{
	import citrus.core.State;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	
	public class BaseState extends State
	{
		protected var screen:MovieClip;
		protected var myTM:TransitionManager;
		
		public function BaseState()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
//			myTM = new TransitionManager(this._frim);
//			myTM.startTransition({type: Fly, direction: Transition.IN, duration: 1, easing: Back.easeOut});
//			myTM.addEventListener("allTransitionsInDone", doneTrans);
		}
		
		private function doneTrans(event:Event):void
		{
			myTM.removeEventListener("allTransitionsInDone", doneTrans);
			myTM = null;
		}
	}
}
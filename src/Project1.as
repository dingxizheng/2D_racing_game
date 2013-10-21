package
{
	import citrus.core.CitrusEngine;
	
	import data.CurrentLevelData;
	import data.LevelData;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.URLRequest;
	
	import state.GameOverState;
	import state.GameState;
	import state.MenuState;
	import state.SelectionState;
	
	[SWF(width="600", height="400", frameRate="30",backgroundColor = "#cccccc")]
	public class Project1 extends CitrusEngine
	{
		
		public static const MENU_STATE:String = "menu_state";
		public static const GAME_STATE:String = "level_select_state";
		public static const GAME_OVER_STATE:String = "game_over_state";
		public static const GAME_SELECT_STATE:String = "game_select_state";
		public static var changeState:Function = null;
		
		public function Project1()
		{
			super();
			var levelDat:CurrentLevelData = CurrentLevelData.getInstance();
			levelDat.loadData();
			state = new MenuState(setState);
			changeState = setState;
		}
		
		public function setState(newState:String):void{
			switch(newState)
			{
				case MENU_STATE:
					state = new MenuState(setState);
					break;
				
				case GAME_STATE:
					state = new GameState(setState)
					break;
				
				case GAME_SELECT_STATE:
					state = new SelectionState(setState);
					break;
				
				case GAME_OVER_STATE:
					state = new GameOverState(setState)
					break;
			}
		}
		
		private function handleSWFLoadComplete(evt:Event):void {
			var levelObjectsMC:MovieClip = evt.target.loader.content;
			state = new GameState(setState);
			evt.target.removeEventListener(Event.COMPLETE, handleSWFLoadComplete);
			evt.target.loader.unloadAndStop();
		}
	}
}
package state
{
	import citrus.core.CitrusEngine;
	import citrus.core.State;
	
	import data.CurrentLevelData;
	import data.LevelData;
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class GameOverState extends State
	{
		private var backSwf:MovieClip;
		private var LevelBtn:MovieClip;
		private var levelDat:LevelData;
		
		[Embed(source="../bin-debug/states/GameOverState.swf")]
		private var GameOverSate:Class;
		
		private var changeState:Function
		public function GameOverState(changeState_:Function)
		{
			changeState = changeState_;
			super();
			
		} 
		
		override public function initialize():void{
			super.initialize();	
			setBack();			
		}
		
		public function setBack():void{
			backSwf = new GameOverSate();
			backSwf.x = 0;
			backSwf.y = 0;
			this.addChild(backSwf);
			var timer:Timer = new Timer(3000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, changeState);
			timer.start();
			function changeState(evt:TimerEvent):void{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE,changeState);
				Project1.changeState(Project1.GAME_SELECT_STATE);
			}
		}
	}
	
	
}
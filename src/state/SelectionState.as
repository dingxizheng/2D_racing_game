package state
{
	import citrus.core.CitrusEngine;
	import citrus.core.State;
	
	import data.LevelData;
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.text.TextField;

	/**
	 *@author Xizheng Ding 
	 */
	public class SelectionState extends State
	{
		private var backSwf:MovieClip;
		private var LevelBtn:MovieClip;
		private var levelDat:LevelData;
		
		[Embed(source="../bin-debug/states/LevelSate.swf")]
		private var LevelMenu:Class;
		
		[Embed(source="../bin-debug/states/LevelSate.swf",symbol="LevelBtn")]
		private var LevelBtnMc:Class;
		
		private var changeState:Function
		private var _ce:CitrusEngine;
		public function SelectionState(changeState_:Function)
		{
			changeState = changeState_;
			super();
			_ce = CitrusEngine.getInstance();
			levelDat = LevelData.getInstance();
			levelDat.loadData();
			
			backSwf = new LevelMenu();
			backSwf.x = 0;
			backSwf.y = 0;
			this.addChild(backSwf);
			
			for(var i = 0; i < 3; i ++){
				LevelBtn = new LevelBtnMc();
				var tf:TextField = LevelBtn.getChildByName("LevelName") as TextField;
				tf.text = "Level" + (i+1);
				LevelBtn.x = 100;
				LevelBtn.y = 200 + (58 + 20) * i;
				LevelBtn.gotoAndStop(1);
				setClickAble(LevelBtn, levelDat.isLevelUnlocked(i+1));
				this.addChild(LevelBtn);
			}
		}
		
		public function setClickAble(btn:MovieClip, enable:Boolean):void{
			if(enable){
				btn.gotoAndStop(2);
				btn.addEventListener(MouseEvent.MOUSE_OVER, function(e:Event){
					btn.buttonMode = true;
				});
			
				btn.addEventListener(MouseEvent.MOUSE_OUT, function(e:Event){
					btn.buttonMode = false;
				});
				btn.addEventListener(MouseEvent.CLICK, function(e:Event){
					changeState(Project1.GAME_STATE);
				});
			}
		}
	}
}
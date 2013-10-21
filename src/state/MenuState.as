package state
{
	import citrus.core.CitrusEngine;
	import citrus.core.State;
	import citrus.objects.CitrusSprite;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.*;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import iobjects.Helicoper;

	public class MenuState extends State
	{
		private var _ce:CitrusEngine;
		private var _levelObjectsMC:MovieClip;
		private var changeState:Function;
		public function MenuState(changeState_:Function)
		{
			super();
			changeState = changeState_;
			var objects:Array = [CitrusSprite];
			var loader:Loader = new Loader();
			loader.load(new URLRequest("states/Menu.swf"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleSWFLoadComplete);
		}
		
		private function handleSWFLoadComplete(evt:Event):void {
			
			var levelObjectsMC:MovieClip = evt.target.loader.content;	
			
			var objects:Array = [CitrusSprite, Helicoper];
			_ce = CitrusEngine.getInstance();	
			_levelObjectsMC = levelObjectsMC;
			_initialize();
			
			evt.target.removeEventListener(Event.COMPLETE, handleSWFLoadComplete);
			evt.target.loader.unloadAndStop();
		}

		
		public function _initialize():void
		{
			
			var box2d:Box2D = new Box2D("Box2D");
			//box2d.visible = true;
			add(box2d);
			
			view.loadManager.onLoadComplete.addOnce(handleLoadComplete);
			
			ObjectMaker2D.FromMovieClip(_levelObjectsMC);
			
			var sprte: CitrusSprite = CitrusSprite(this.getObjectByName("startBtn"));
			var startArt:DisplayObject = view.getArt(sprte) as DisplayObject;
			startArt.addEventListener(MouseEvent.MOUSE_OVER, function(e:Event){
				_ce.buttonMode = true;
			});
			startArt.addEventListener(MouseEvent.MOUSE_OUT, function(e:Event){
				_ce.buttonMode = false;
			});
			startArt.addEventListener(MouseEvent.CLICK, function(e:Event){
				changeState(Project1.GAME_SELECT_STATE);
			});
				
		}
		
		override public function update(timeDelta:Number):void{
			super.update(timeDelta);
		}
		
		private function handleLoadComplete():void {
		}
	}
}
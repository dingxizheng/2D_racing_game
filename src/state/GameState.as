package state
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import citrus.core.CitrusEngine;
	import citrus.core.State;
	import citrus.math.MathVector;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.MovingPlatform;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	
	import data.CurrentLevelData;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import iobjects.*;
	import iobjects.SeeSaw;
	
	import sensors.*;
	
	public class GameState extends State
	{
		private var _ce:CitrusEngine;
		private var _levelObjectsMC:MovieClip;
		private var changeState:Function;
		private var mapNum:int = 0;
		private var mapsUrl:String = "levels/carLevel1_";
		
		private var velocity_:TextField;
		private var distance_:TextField;
		private var life_:TextField;
		private var car:CarBody;
		
		private var backMC:MovieClip;
		[Embed(source="../bin-debug/states/StatusScreen.swf")]
		private var StatusScreen:Class;
		
		[Embed(source="../bin-debug/states/StatusScreen.swf",symbol="StatusMC")]
		private var StatusMC:Class;
		
		public function GameState(changeState_:Function)
		{
			super();
			_ce = CitrusEngine.getInstance();
			changeState = changeState_;
			loadMap(0);
		}
		
		override public function initialize():void{
			SetStatus();
			super.initialize();	
		}
		
		public function SetStatus():void{
			backMC = new StatusScreen();
			var statusMC= new StatusMC();
			statusMC.x = 0;
			statusMC.y = 0;
			this.addChild(statusMC);		
			
			velocity_= statusMC.getChildByName("VelocityTf") as TextField;
			distance_ = statusMC.getChildByName("DistanceTf") as TextField;
			life_ = statusMC.getChildByName("LifeTf") as TextField;
			velocity_.text = "Velocity:" + 10;
			var life:TextField = statusMC.getChildByName("LifeTf") as TextField;
			life.text = "Life:x" + 3;	
		}
		
		public function _initialize():void
		{
			var box2d:Box2D = new Box2D("Box2D");
			//box2d.visible = true;
			add(box2d);
			
			view.loadManager.onLoadComplete.addOnce(handleLoadComplete);
			var levelDat:CurrentLevelData = CurrentLevelData.getInstance();
			var parentObj = MovieClip(_levelObjectsMC.getChildByName("carBody")) as MovieClip;
			parentObj.x = levelDat.getData("preRecorder_x");
			parentObj.y = levelDat.getData("preRecorder_y") + 150;
			
			ObjectMaker2D.FromMovieClip(_levelObjectsMC);
			//var hero:Hero = Hero(getFirstObjectByType(Hero));
			car = CarBody(getFirstObjectByType(CarBody));
			
			//set the viewing camera...
			view.camera.setUp(car, new MathVector(120, 250), new Rectangle(0, -300, 16000, 3000), new MathVector(.25, .05));
			loadMap(1);
		}
		
		public function loadMap(mapNum_:int):void{
			mapNum = mapNum_;
			var loader:Loader = new Loader();
			loader.load(new URLRequest("levels/carLevel1_" + mapNum + ".swf"));
			var objects:Array = [CitrusSprite,Helicoper,CarBody,CarWheel1,CarWheel2,CannonJoint,MovingPlatform,Hero,SeeSaw,Box2DPhysicsObject,Blade,Accelerator,Recorder,WinSensor,Boundary];	
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleSWFLoadComplete );
		}
		
		private function handleSWFLoadComplete(evt:Event):void {	
			_ce = CitrusEngine.getInstance();	
			_levelObjectsMC = evt.target.loader.content;
			var i = 0;
			while (i >= 0)
			{
				var parentObj:MovieClip;
				try{
					parentObj = MovieClip(_levelObjectsMC.getChildAt(i)) as MovieClip;
				}catch(e:*){
					break;
				}
				parentObj.x += 8000 * mapNum;
				i++;				
			}
			if(mapNum == 0){
				_initialize();
			}else{
				view.loadManager.onLoadComplete.addOnce(handleLoadComplete);
				ObjectMaker2D.FromMovieClip(_levelObjectsMC);
			}
			evt.target.removeEventListener(Event.COMPLETE, handleSWFLoadComplete);
			evt.target.loader.unloadAndStop();
		}
		
		override public function update(timeDelta:Number):void
		{
			try{
			    super.update(timeDelta);
			    if(car == null)
				   return;
			}catch(e:*){
				
			}
			
			velocity_.text = "Velocity:" + int(car.body.GetLinearVelocity().x)+ "m/s";
			distance_.text = "Distance:" + int(car.x / 10) + "m";
			var levelDat:CurrentLevelData = CurrentLevelData.getInstance();
			life_ .text = "LIFE: x " + levelDat.getData(CurrentLevelData.TIMES); 
		}
		
		private function handleLoadComplete():void {
			
		}
	}
}
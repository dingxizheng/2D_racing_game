package sensors
{
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.CitrusEngine;
	import citrus.objects.platformer.box2d.Sensor;
	
	import data.CurrentLevelData;
	
	import iobjects.CarBody;
	
	import state.GameOverState;
	
	public class WinSensor extends Sensor
	{
		public function WinSensor(name:String, params:Object=null)
		{
			params["view"] = "img/winFlag.png";
			super(name, params);
			_ce.sound.addSound("win", "sounds/win.mp3");
		}
		
		override public function handleBeginContact(contact:b2Contact):void{
			super.handleBeginContact(contact);
		}
		
		override public function handleEndContact(contact:b2Contact):void{
			super.handleEndContact(contact);
			if (contact.GetFixtureA().GetBody().GetUserData() is CarBody){
				var car:CarBody = CarBody(_ce.state.getFirstObjectByType(CarBody));
				_ce.sound.playSound("win",1, 1);
				var levelDat:CurrentLevelData = CurrentLevelData.getInstance();
				levelDat.loadData();
				levelDat.resetData();
				levelDat.saveData();
				Project1.changeState(Project1.GAME_SELECT_STATE);
			}
		}
	}
}
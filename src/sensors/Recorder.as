package sensors
{
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.CitrusEngine;
	import citrus.objects.platformer.box2d.Sensor;
	
	import iobjects.CarBody;
	import data.CurrentLevelData;

	public class Recorder extends Sensor
	{
		
		public function Recorder(name:String, params:Object = null) {
			_ce = CitrusEngine.getInstance();
			super(name, params);
			_ce.sound.addSound("Mi", "sounds/mi.mp3");
		}
		
		override public function handleBeginContact(contact:b2Contact):void{
			super.handleBeginContact(contact);
		}
		
		override public function handleEndContact(contact:b2Contact):void{
			super.handleEndContact(contact);
			if (contact.GetFixtureA().GetBody().GetUserData() is CarBody){
				var car:CarBody = CarBody(_ce.state.getFirstObjectByType(CarBody));
				_ce.sound.playSound("Mi",1, 1);
				var levelDat:CurrentLevelData = CurrentLevelData.getInstance();
				levelDat.loadData();
				levelDat.setRecorder(car.x - 300, car.y - 200);
				levelDat.saveData();
			}
		}
		
	}
}
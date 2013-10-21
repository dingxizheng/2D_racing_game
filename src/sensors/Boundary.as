package sensors
{
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.objects.platformer.box2d.Sensor;
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.CitrusEngine;
	import citrus.objects.platformer.box2d.Sensor;
	
	import iobjects.CarBody;
	import data.CurrentLevelData;
	import state.GameState;
	import state.GameOverState;
	
	public class Boundary extends Sensor
	{
		public function Boundary(name:String, params:Object=null)
		{
			super(name, params);
			_ce.sound.addSound("lose", "sounds/lose.mp3");
			
		}
		
		override public function handleBeginContact(contact:b2Contact):void{
			//super.handleBeginContact(contact);//contact.GetFixtureA().GetBody().GetUserData()
			if (contact.GetFixtureA().GetBody().GetUserData() is CarBody){
				_ce.sound.playSound("lose",1, 1);
				GameOver();
			}
		}
		
		private function GameOver():void{
			var levelDat:CurrentLevelData = CurrentLevelData.getInstance();
			if(levelDat.getData(CurrentLevelData.TIMES) == 1){
				levelDat.resetData();
				levelDat.saveData();
				Project1.changeState(Project1.GAME_OVER_STATE);
			}else{
				levelDat.decreaseData(CurrentLevelData.TIMES, 1);
				levelDat.saveData();
				Project1.changeState(Project1.GAME_STATE);
			}
		}
	}
}
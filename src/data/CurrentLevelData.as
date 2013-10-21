package data
{
	import flash.net.SharedObject;
	
	public class CurrentLevelData
	{
		private static var instance:CurrentLevelData;
		
		private var times = 3;
		private var money = 0;
		private var death = 0;
		private var score = 0;
		private var preRecorder_x = 200;
		private var preRecorder_y = 100;
		private var enemies_killed:int = 0;
		
		public static const SCORE:String = "score";
		public static const MONEY:String = "money";
		public static const DEATH:String = "death";
		public static const TIMES:String = "times";
		public static const RECORDER_x:String = "preRecorder_x";
		public static const RECORDER_Y:String = "preRecorder_y";
		public static const ENEMIES_KILLED:String = "enemies_killed";
		
		private var sharedObject:SharedObject;
		
		public function CurrentLevelData(enforcer:SingletonEnforcer)
		{
			sharedObject = SharedObject.getLocal("saved_data");
		}
		
		public static function getInstance():CurrentLevelData
		{
			if (instance == null)
			{
				instance = new CurrentLevelData(new SingletonEnforcer);
			}
			
			return instance;
		}
		
		public function loadData():void
		{
			if (!sharedObject.data.hasOwnProperty("score"))
			{
				return;
			}
			
			score = sharedObject.data.score;
			money = sharedObject.data.money;
			death = sharedObject.data.death;
			times = sharedObject.data.times;
			preRecorder_x = sharedObject.data.preRecorder_x;
			preRecorder_y = sharedObject.data.preRecorder_y;
			enemies_killed = sharedObject.data.enemies_killed;
		}
		
		public function saveData():void
		{
			sharedObject.data.score = score;
			sharedObject.data.money = money;
			sharedObject.data.death = death;
			sharedObject.data.enemies_killed = enemies_killed;
			sharedObject.data.times = times;
			sharedObject.data.preRecorder_x = preRecorder_x;
			sharedObject.data.preRecorder_y = preRecorder_y;
			
			sharedObject.flush();
		}
		
		public function resetData():void
		{
			score = 0;
			money = 0;
			death = 0;
			enemies_killed = 0;
			times = 3;
			preRecorder_x = 200;
			preRecorder_y = 100;
			saveData();
		}
		
		public function setRecorder(x_:int, y_:int):void{
			preRecorder_x = x_;
			preRecorder_y = y_;
		}
		
		public function increaseData(data:String, value:int):void
		{
			this[data] += value;
		}
		
		public function decreaseData(data:String, value:int):void
		{
			this[data] -= value;
		}
		
		public function getData(data:String):int
		{
			return this[data];
		}
	}
}

class SingletonEnforcer
{	}
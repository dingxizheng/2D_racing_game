package data 
{
	import flash.net.SharedObject;
	
	public class PlayerData 
	{
		private static var instance:PlayerData;
		
		private var score:int = 0;
		private var money:int = 0;
		private var death:int = 0;
		private var enemies_killed:int = 0;
		
		public static const SCORE:String = "score";
		public static const MONEY:String = "money";
		public static const DEATH:String = "death";
		public static const ENEMIES_KILLED:String = "enemies_killed";
		
		private var sharedObject:SharedObject;
		
		public function PlayerData(enforcer:SingletonEnforcer) 
		{
			sharedObject = SharedObject.getLocal("saved_data");
		}	
		
		public static function getInstance():PlayerData
		{
			if (instance == null)
			{
				instance = new PlayerData(new SingletonEnforcer);
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
			enemies_killed = sharedObject.data.enemies_killed;
		}
		
		public function saveData():void
		{
			sharedObject.data.score = score;
			sharedObject.data.money = money;
			sharedObject.data.death = death;
			sharedObject.data.enemies_killed = enemies_killed;
			
			sharedObject.flush();
		}
		
		public function resetData():void
		{
			score = 0;
			money = 0;
			death = 0;
			enemies_killed = 0;
			
			saveData();
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
{
	
}
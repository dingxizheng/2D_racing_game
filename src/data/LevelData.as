package data 
{
	import flash.net.SharedObject;
	
	public class LevelData 
	{
		private static var instance:LevelData;
		
		private var level_1_unlocked:Boolean = true;
		private var level_2_unlocked:Boolean = false;
		private var level_3_unlocked:Boolean = false;
		
		private var sharedObject:SharedObject;
		
		public function LevelData(enforcer:SingletonEnforcer) 
		{
			sharedObject = SharedObject.getLocal("saved_data");
		}		
		
		public static function getInstance():LevelData
		{
			if (instance == null)
			{
				instance = new LevelData(new SingletonEnforcer);
			}
			
			return instance;
		}
		
		public function loadData():void
		{
			if (!sharedObject.data.hasOwnProperty("level_1_unlocked"))
			{
				return;
			}
			
			for (var i:int = 1; i <= 3; i++)
			{
				this["level_" + String(i) + "_unlocked"] = sharedObject.data["level_" + String(i) + "_unlocked"];
			}
		}
		
		public function saveData():void
		{
			for (var i:int = 1; i <= 3; i++)
			{
				sharedObject.data["level_" + String(i) + "_unlocked"] = this["level_" + String(i) + "_unlocked"];
			}
			
			sharedObject.flush();
		}
		
		public function resetData():void
		{
			level_1_unlocked = true;
			
			for (var i:int = 2; i <= 3; i++)
			{
				this["level_" + String(i) + "_unlocked"] = false;
			}
			
			saveData();
		}
		
		public function unlockAll():void
		{
			for (var i:int = 1; i <= 3; i++)
			{
				this["level_" + String(i) + "_unlocked"] = true;
			}
		}
		
		public function unlockLevel(level:int):void
		{
			if (level < 1 || level > 3)
			{
				return;
			}
			
			this["level_" + String(level) + "_unlocked"] = true;
		}
		
		public function isLevelUnlocked(level:int):Boolean
		{
			if (level < 1 || level > 3)
			{
				return false;
			}
			
			return this["level_" + String(level) + "_unlocked"];
		}
	}
}

class SingletonEnforcer
{
	
}
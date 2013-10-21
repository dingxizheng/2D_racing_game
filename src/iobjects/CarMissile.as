package iobjects
{
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.objects.platformer.box2d.Missile;

	public class CarMissile extends Missile
	{
		public function CarMissile(name:String, params:Object=null)
		{
			params["view"] = "img/Missile.swf"
			params["explodeDuration"] = 30;
			params["speed"] = 70;
			super(name, params);
			_ce.sound.addSound("si", "sounds/si.mp3");
		}
		
		override protected function defineFixture():void{
			super.defineFixture();
		}
	}
}
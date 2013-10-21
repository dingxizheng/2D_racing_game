package iobjects
{
	import citrus.objects.Box2DPhysicsObject;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Joints.*;
	import citrus.objects.Box2DPhysicsObject;
	import Box2D.Dynamics.b2Body;
	
	public class Wheel extends Box2DPhysicsObject
	{
		private var LevelMenu:Class;
		
		public function Wheel(name:String, params:Object=null)
		{
			params["view"] =  "img/Wheel.png";
			super(name, params);
		}
		
		override protected function defineBody():void{
			super.defineBody();
		}
		
		override protected function defineFixture():void{
			super.defineFixture();
			_fixtureDef.density = 3;
			_fixtureDef.friction = 15;
		}
		
		override protected function createShape():void{
			super.createShape();
			_shape = new b2CircleShape(5 / this._box2D.scale);
		}
	}
}
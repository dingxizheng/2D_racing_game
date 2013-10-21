package iobjects 
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.b2Body;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.platformer.box2d.Missile;
	
	public class SeeSaw extends Box2DPhysicsObject
	{
		public var scale = 30;
		
		public function SeeSaw(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		override public function initialize(poolObjectParams:Object=null):void{
			super.initialize(poolObjectParams);
			addAxle();
		}
		
		override protected function defineFixture():void{
			super.defineFixture();
			_fixtureDef.density = 10;
			_fixtureDef.friction = 5;
		}
		
		public function addAxle():void{
			var axle:Axle = new Axle("axle", {x:this.x + 2, y:this.y});
			
			var revoluteJointDef = new b2RevoluteJointDef();
			var axle_body:b2Body = axle.getBody();
			//axle_body.GetWorldCenter().Add(new b2Vec2(30,0));
			revoluteJointDef.Initialize(axle_body,_body, axle_body.GetWorldCenter());
			var revoluteJoint = _box2D.world.CreateJoint(revoluteJointDef) as b2RevoluteJoint;
		}
	}
}
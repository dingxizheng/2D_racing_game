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
	
	public class Blade extends Box2DPhysicsObject
	{
		public var scale = 30;
		private const degreesToRadians:Number = 0.0174532925;
		private var axleAngle:Number = 0;
		private var speed:int = 1;
		
		public function Blade(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		override public function initialize(poolObjectParams:Object=null):void{
			super.initialize(poolObjectParams);
			addAxle();
		}
		
		override protected function defineBody():void{
			super.defineBody();
			_bodyDef.type = b2Body.b2_kinematicBody;
		}
		
		override protected function defineFixture():void{
			super.defineFixture();
			_fixtureDef.density = 10;
			_fixtureDef.friction = 5;
		}
		
		override public function update(timeDelta:Number):void{
			super.update(timeDelta);
			axleAngle += speed;
			this.body.SetAngle(degreesToRadians * axleAngle);
		}
		
		public function addAxle():void{
			var axle:Axle = new Axle("axle", {x:this.x, y:this.y});	
			var revoluteJointDef = new b2RevoluteJointDef();
			var axle_body:b2Body = axle.getBody();
			//axle_body.GetWorldCenter().Add(new b2Vec2(30,0));
			revoluteJointDef.Initialize(axle_body,_body, axle_body.GetWorldCenter());
			var revoluteJoint = _box2D.world.CreateJoint(revoluteJointDef) as b2RevoluteJoint;
		}
		
	}
}
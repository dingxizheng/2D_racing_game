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
	import citrus.objects.platformer.box2d.Platform;
	
	public class Accelerator extends Platform
	{
		private var myRotation:Number;
		private const degreesToRadians:Number=0.0174532925;
		public function Accelerator(name:String, params:Object=null)
		{
			params["height"] = 20;
			params["width"] = 150;
			myRotation = params["rotation"];
			params["rotation"] = 0;
			params["view"] = "img/Accelerator.swf";
			super(name, params);
		}
		
		override public function initialize(poolObjectParams:Object=null):void{
			super.initialize(poolObjectParams);
		}
		
		override protected function createBody():void{
			super.createBody();
			for(var i = 0; i < 14; i ++){
				addWheels(i);
			}
			body.SetAngle(myRotation * degreesToRadians);
		}
		
		public function addWheels(i:int):void{
			var wheel:Wheel = new Wheel("wheels"+i, {x:this.x - 65 + 10 * i, y:this.y - 9});	
			var revoluteJointDef = new b2RevoluteJointDef();
			var wheel_body:b2Body = wheel.getBody();
			revoluteJointDef.Initialize(wheel_body,_body, wheel_body.GetWorldCenter());
			revoluteJointDef.enableMotor = true;
			var revoluteJoint = _box2D.world.CreateJoint(revoluteJointDef) as b2RevoluteJoint;
			revoluteJoint.SetMaxMotorTorque(800);
			revoluteJoint.SetMotorSpeed(-500); 
			_ce.state.add(wheel);
		}
	}
}
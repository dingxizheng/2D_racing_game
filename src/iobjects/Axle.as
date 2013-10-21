package iobjects
{
	import citrus.objects.Box2DPhysicsObject;;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Joints.*;
	import citrus.objects.Box2DPhysicsObject;
	import Box2D.Dynamics.b2Body;
	import flash.ui.Keyboard;
	
	public class Axle extends Box2DPhysicsObject
	{
		public var scale = 30;
		
		public function Axle(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		override protected function defineBody():void{
			super.defineBody();
			_bodyDef.type = b2Body.b2_kinematicBody;
		}
		
		override protected function createShape():void{
			super.createShape();
			_shape = new b2CircleShape(10 / scale);
		}
		
	}
}
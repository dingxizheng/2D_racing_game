package iobjects
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2Body;
	import citrus.objects.Box2DPhysicsObject;
	
	public class CarAxle1 extends Box2DPhysicsObject
	{
		private const degreesToRadians:Number=0.0174532925;
		private var scale = 30;
		private var axleContainerDistance:Number=60;
		private var axleContainerWidth:Number=5;
		private var axleContainerHeight:Number=20;
		private var axleContainerDepth:Number=10;
		private var axleAngle:Number=20;
		private var wheelRadius:Number=25;
		
		public function CarAxle1(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		override protected function createShape():void{
			_bodyDef.type = b2Body.b2_staticBody;
			super.createShape();
			_shape = new b2PolygonShape();
			b2PolygonShape(_shape).SetAsOrientedBox(axleContainerWidth/scale,axleContainerHeight/scale,new b2Vec2(-axleContainerDistance/scale,axleContainerDepth/scale),axleAngle*degreesToRadians);
		}
		
		override protected function defineFixture():void{
			super.defineFixture();
			_fixtureDef.density = 3;
			_fixtureDef.friction = 3;
			_fixtureDef.restitution = 0.3;
			_fixtureDef.shape = _shape;
		}
		
		override protected function createFixture():void{
			
		}
		
		public function getFixtureDef():b2FixtureDef{
			return this._fixtureDef;
		}
	}
}
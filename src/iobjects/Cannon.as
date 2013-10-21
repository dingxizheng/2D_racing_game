package iobjects
{
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.Box2DPhysicsObject;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import citrus.objects.Box2DPhysicsObject;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2FixtureDef;
	
	public class Cannon extends Box2DPhysicsObject
	{

		private var scale = 30;
		
		private var CannonDistance:Number = 10;
		private var CannonWidth:Number = 25;
		private var CannonHeight:Number = 2.5;
		private var CannonDepth:Number = 12.5;
		
		public function Cannon(name:String, params:Object=null)
		{
			super(name, params);
		}
				
		override protected function createShape():void
		{   
			super.createShape();
			_shape = new b2PolygonShape();
			b2PolygonShape(_shape).SetAsOrientedBox(CannonWidth/scale, CannonHeight/scale,new b2Vec2(0,0), 0);
		}
		
		override protected function defineFixture():void
		{
			super.defineFixture();
			_fixtureDef.density = 4;
			_fixtureDef.friction = 0.5;
			_fixtureDef.restitution = 0.2;
		}
		
		override protected function createFixture():void{
			//super.createFixture();	
		}
		
		public function getFixtureDef():b2FixtureDef{
			return this._fixtureDef;
		}
	}
}
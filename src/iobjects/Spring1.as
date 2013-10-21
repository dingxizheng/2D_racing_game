package iobjects 
{
	import citrus.objects.Box2DPhysicsObject;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	public class Spring1 extends Box2DPhysicsObject
	{
		private const degreesToRadians:Number = 0.0174532925;
		private var axleAngle:Number = 20;
		private var scale = 30;
		private var wheelRadius:Number = 10;
		
		private var axleContainerDistance:Number = 40;
		private var axleContainerWidth:Number = 4;
		private var axleContainerHeight:Number = 16;
		private var axleContainerDepth:Number = 5;
		
		public function Spring1(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		override protected function createShape():void
		{   
			_bodyDef.type = b2Body.b2_dynamicBody;
			super.createShape();
			_shape = new b2PolygonShape();
			b2PolygonShape(_shape).SetAsOrientedBox(axleContainerWidth/scale, axleContainerHeight/scale,new b2Vec2(0,0), 0);
		}
		
		override protected function defineFixture():void
		{
			super.defineFixture();
			_fixtureDef.density = 3;
			_fixtureDef.friction = 0.5;
			_fixtureDef.restitution = 0.2;
			_fixtureDef.shape = _shape;
		}
		
		override protected function createFixture():void{
			super.createFixture();
			_body.SetPosition(new b2Vec2( this.x/scale - axleContainerDistance/scale ,this.y/scale ));		
		}
	}
}
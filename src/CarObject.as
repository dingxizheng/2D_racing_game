package
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2FixtureDef;
	
	import citrus.objects.Box2DPhysicsObject;
	import citrus.physics.box2d.Box2DUtils;
	
	import nape.dynamics.Contact;
	import citrus.core.CitrusEngine;
	import citrus.physics.box2d.Box2D;
	import citrus.objects.platformer.box2d.Hero;
	
	import citrus.physics.PhysicsCollisionCategories;
	import citrus.physics.box2d.Box2D;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	
	public class CarObject extends Hero
	{
		private const degreesToRadians:Number=0.0174532925;
		private var worldScale:int=30;
		
//		private var carShape:b2PolygonShape;
//		private var car:b2Body;
//		private var carBodyDef:b2BodyDef;
//		private var carFixture:b2FixtureDef;
		
//		private var leftAxleContainerShape:b2PolygonShape;
//		private var leftAxleContainerFixture:b2FixtureDef;
//		
//		private var rightAxleContainerShape:b2PolygonShape;
//		private var rightAxleContainerFixture:b2FixtureDef;
		
		private var carPosX:Number=500;
		private var carPosY:Number=300;
		private var carWidth:Number=45;
		private var carHeight:Number=10;
		private var axleContainerDistance:Number=30;
		private var axleContainerWidth:Number=5;
		private var axleContainerHeight:Number=20;
		private var axleContainerDepth:Number=10;
		
		private var axleAngle:Number=20;
		private var wheelRadius:Number=25;
		
		public function CarObject(name:String, params:Object=null)
		{
			super(name, params);
			_ce = CitrusEngine.getInstance();
			//var physics:Box2D = _ce.getChildByName("Box2D");
			//_box2D.world.SetContactListener(new ContactNiMei());
			//_ce = CitrusEngine.getInstance();
			_box2D = _ce.state.getFirstObjectByType(Box2D) as Box2D;
			//_box2D.world.
		}
		
//		override public function initialize(poolObjectParams:Object = null):void {
//			super.initialize(poolObjectParams);
//		}
//		
//		override public function update(timeDelta:Number):void {
//			super.update(timeDelta);
//			
//			if (view)
//				(view as RopeChainGraphics).update(_vecBodyChain, _box2D.scale);
//		}

		override protected function defineBody():void{		
			super.defineBody();	
			
			_bodyDef = new b2BodyDef();
			_bodyDef.position.Set(carPosX/worldScale,carPosY/worldScale);
			_bodyDef.type = b2Body.b2_dynamicBody;
		}
		
		override protected function createBody():void{
			super.createBody();	
			
			_body = _box2D.world.CreateBody(_bodyDef);
		}
		
		override protected function createShape():void{
			super.createShape();
			
			_shape = new b2PolygonShape();
			b2PolygonShape(_shape).SetAsBox(carWidth/worldScale,carHeight/worldScale);
			
//			leftAxleContainerShape = new b2PolygonShape();
//			leftAxleContainerShape.SetAsOrientedBox(axleContainerWidth/worldScale,axleContainerHeight/worldScale,new b2Vec2(-axleContainerDistance/worldScale,axleContainerDepth/worldScale),axleAngle*degreesToRadians);
//			
//			rightAxleContainerShape = new 
//				b2PolygonShape();
//			rightAxleContainerShape.SetAsOrientedBox(axleContainerWidth/worldScale,axleContainerHeight/worldScale,new b2Vec2(axleContainerDistance/worldScale,axleContainerDepth/worldScale),-axleAngle*degreesToRadians);
//			
		}
		
		override protected function defineFixture():void{
			super.defineFixture();
			
			_fixtureDef = new b2FixtureDef();
			_fixtureDef.density=5;
			_fixtureDef.friction=3;
			_fixtureDef.restitution=0.3;
			_fixtureDef.filter.categoryBits = PhysicsCollisionCategories.Get("Level");
			_fixtureDef.filter.maskBits = PhysicsCollisionCategories.GetAll();
			_fixtureDef.shape = _shape;
//			leftAxleContainerFixture = new b2FixtureDef();
//			leftAxleContainerFixture.density=3;
//			leftAxleContainerFixture.friction=3;
//			leftAxleContainerFixture.restitution=0.3;
//			leftAxleContainerFixture.filter.groupIndex=-1;
//			leftAxleContainerFixture.shape=leftAxleContainerShape;
//			
//			rightAxleContainerFixture = new 
//				b2FixtureDef();
//			rightAxleContainerFixture.density=3;
//			rightAxleContainerFixture.friction=3;
//			rightAxleContainerFixture.restitution=0.3;
//			rightAxleContainerFixture.filter.groupIndex=-1;
//			rightAxleContainerFixture.shape=rightAxleContainerShape;
		}
		
		override protected function createFixture():void{
			super.createFixture();		
			
			_body.CreateFixture(_fixtureDef);
//			_body.CreateFixture(leftAxleContainerFixture);
//			_body.CreateFixture(rightAxleContainerFixture);
		}
//		
//		override public function handleBeginContact(contact:b2Contact):void{
//			super.handleBeginContact(contact);
//			trace("1");
//		}
//		
//		override public function handleEndContact(contact:b2Contact):void{
//			super.handleEndContact(contact);
//			trace("3");
//		}
//		
//		override public function handlePostSolve(contact:b2Contact, impulse:b2ContactImpulse):void{
//			super.handlePostSolve(contact, impulse);
//			trace("2");
//		}
//		
		override public function handlePreSolve(contact:b2Contact, oldManifold:b2Manifold):void{
			//if (!_ducking)
				//return;
			
			var other:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);
			
			var heroTop:Number = y;
			var objectBottom:Number = other.y + (other.height / 2);
			
			if (objectBottom < heroTop)
				contact.SetEnabled(false);
		}
	}
}
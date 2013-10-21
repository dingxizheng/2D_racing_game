//package
//{
//	import Box2D.Collision.*;
//	import Box2D.Collision.Shapes.*;
//	import Box2D.Common.Math.*;
//	import Box2D.Dynamics.*;
//	import Box2D.Dynamics.Joints.*;
//	
//	/**
//	 * @author Xizheng Ding
//	 */ 
//	public class Car extends Object implements creator
//	{
//		
//		private const degreesToRadians:Number=0.0174532925;
//		private var worldScale:int=30;
//		
//		private var carShape:b2PolygonShape;
//		private var car:b2Body;
//		private var carBodyDef:b2BodyDef;
//		private var carFixture:b2FixtureDef;
//		
//		private var leftAxleContainerShape:b2PolygonShape;
//		private var leftAxleContainerFixture:b2FixtureDef;
//		
//		private var rightAxleContainerShape:b2PolygonShape;
//		private var rightAxleContainerFixture:b2FixtureDef;
//		
//		private var leftAxleShape:b2PolygonShape;
//		private var leftAxleFixture:b2FixtureDef;
//		
//		private var leftAxleBodyDef:b2BodyDef;
//		private var leftAxle:b2Body;
//		
//		private var rightAxleShape:b2PolygonShape;
//		private var rightAxleFixture:b2FixtureDef;
//		
//		private var rightAxleBodyDef:b2BodyDef;
//		private var rightAxle:b2Body;
//		
//		private var wheelShape:b2CircleShape;
//		private var wheelFixture1:b2FixtureDef;
//		private var wheelFixture2:b2FixtureDef;
//		
//		private var wheelBodyDef1:b2BodyDef;
//		private var wheelBodyDef2:b2BodyDef;
//		private var leftWheel:b2Body;
//		
//		private var rightWheel:b2Body;
//		private var leftWheelRevoluteJointDef:b2RevoluteJointDef;
//		private var rightWheelRevoluteJointDef:b2RevoluteJointDef;
//		
//		private var leftAxlePrismaticJointDef:b2PrismaticJointDef;
//		private var rightAxlePrismaticJointDef:b2PrismaticJointDef;
//		
//		private var leftWheelRevoluteJoint:b2RevoluteJoint;
//		private var rightWheelRevoluteJoint:b2RevoluteJoint;
//		private var left:Boolean=false;
//		private var right:Boolean=false;
//		private var motorSpeed:Number=0;
//		private var leftAxlePrismaticJoint:b2PrismaticJoint;
//		private var rightAxlePrismaticJoint:b2PrismaticJoint;
//		//
//		private var carPosX:Number=500;
//		private var carPosY:Number=300;
//		private var carWidth:Number=45;
//		private var carHeight:Number=10;
//		private var axleContainerDistance:Number=30;
//		private var axleContainerWidth:Number=5;
//		private var axleContainerHeight:Number=20;
//		private var axleContainerDepth:Number=10;
//		private var axleAngle:Number=20;
//		private var wheelRadius:Number=25;
//		
//		public function Car()
//		{
//		}
//		
//		override protected function defineBody():void {
//			super.defineBody();	
//			
//			carBodyDef = new b2BodyDef();
//			carBodyDef.position.Set(carPosX/worldScale,carPosY/worldScale);
//			carBodyDef.type=b2Body.b2_dynamicBody;
//			
//			leftAxleBodyDef = new b2BodyDef();
//			leftAxleBodyDef.type=b2Body.b2_dynamicBody;
//			
//			rightAxleBodyDef = new b2BodyDef();
//			rightAxleBodyDef.type=b2Body.b2_dynamicBody;	
//			
//			wheelBodyDef1 = new b2BodyDef();
//			wheelBodyDef1.type=b2Body.b2_dynamicBody;
//			wheelBodyDef1.position.Set(carPosX/worldScale-axleContainerDistance/worldScale-2*axleContainerHeight/worldScale*Math.cos((90-axleAngle)*degreesToRadians),carPosY/worldScale+axleContainerDepth/worldScale+2*axleContainerHeight/worldScale*Math.sin((90-axleAngle)*degreesToRadians));
//			
//			wheelBodyDef2 = new b2BodyDef();
//			wheelBodyDef2.type=b2Body.b2_dynamicBody;
//			wheelBodyDef2.position.Set(carPosX/worldScale+axleContainerDistance/worldScale+2*axleContainerHeight/worldScale*Math.cos((90-axleAngle)*degreesToRadians),carPosY/worldScale+axleContainerDepth/worldScale+2*axleContainerHeight/worldScale*Math.sin((90-axleAngle)*degreesToRadians));
//			
//		}
//		
//		override protected function createBody():void {
//			super.createBody();	
//			
//			car = world.CreateBody(carBodyDef);
//			
//			leftAxle= world.CreateBody(leftAxleBodyDef);
//			
//			rightAxle = world.CreateBody(rightAxleBodyDef);
//			
//			leftWheel =world.CreateBody(wheelBodyDef1);
//			
//			rightWheel = world.CreateBody(wheelBodyDef2);
//			
//		}
//		
//		override protected function createShape():void {
//			super.createShape();
//			
//			carShape = new b2PolygonShape();
//			carShape.SetAsBox(carWidth/worldScale,carHeight/worldScale);
//			
//			leftAxleContainerShape = new b2PolygonShape();
//			leftAxleContainerShape.SetAsOrientedBox(axleContainerWidth/worldScale,axleContainerHeight/worldScale,new b2Vec2(-axleContainerDistance/worldScale,axleContainerDepth/worldScale),axleAngle*degreesToRadians);
//			
//			rightAxleContainerShape = new 
//				b2PolygonShape();
//			rightAxleContainerShape.SetAsOrientedBox(axleContainerWidth/worldScale,axleContainerHeight/worldScale,new b2Vec2(axleContainerDistance/worldScale,axleContainerDepth/worldScale),-axleAngle*degreesToRadians);
//			
//			leftAxleShape = new b2PolygonShape();
//			leftAxleShape.SetAsOrientedBox(axleContainerWidth/worldScale/2,axleContainerHeight/worldScale,new b2Vec2(0,0),axleAngle*degreesToRadians);
//			
//			
//			rightAxleShape = new b2PolygonShape();
//			rightAxleShape.SetAsOrientedBox(axleContainerWidth/worldScale/2,axleContainerHeight/worldScale,new b2Vec2(0,0),-axleAngle*degreesToRadians);
//			
//			wheelShape =new 
//				b2CircleShape(wheelRadius/worldScale);
//			
//			
//		}
//		
//		override protected function defineFixture():void {
//			super.defineFixture();
//			
//			carFixture = new b2FixtureDef();
//			carFixture.density=5;
//			carFixture.friction=3;
//			carFixture.restitution=0.3;
//			carFixture.filter.groupIndex=-1;
//			carFixture.shape=carShape;
//			
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
//			
//			leftAxleFixture = new b2FixtureDef();
//			leftAxleFixture.density=0.5;
//			leftAxleFixture.friction=3;
//			leftAxleFixture.restitution=0;
//			leftAxleFixture.shape=leftAxleShape;
//			leftAxleFixture.filter.groupIndex=-1;
//			
//			rightAxleFixture = new b2FixtureDef();
//			rightAxleFixture.density=0.5;
//			rightAxleFixture.friction=3;
//			rightAxleFixture.restitution=0;
//			rightAxleFixture.shape=rightAxleShape;
//			rightAxleFixture.filter.groupIndex=-1;
//			
//			wheelFixture1 = new b2FixtureDef();
//			wheelFixture1.density=1;
//			wheelFixture1.friction=15;
//			wheelFixture1.restitution=0.2;
//			wheelFixture1.filter.groupIndex=-1;
//			wheelFixture1.shape=wheelShape;
//			
//			wheelFixture2 = new b2FixtureDef();
//			wheelFixture2.density=1;
//			wheelFixture2.friction=15;
//			wheelFixture2.restitution=0.2;
//			wheelFixture2.filter.groupIndex=-1;
//			wheelFixture2.shape=wheelShape;
//			
//		}
//		
//		override protected function createFixture():void {
//			super.createFixture();		
//			
//			car.CreateFixture(carFixture);
//			car.CreateFixture(leftAxleContainerFixture);
//			car.CreateFixture(rightAxleContainerFixture);
//			
//			leftAxle.CreateFixture(leftAxleFixture);
//			leftAxle.SetPosition(new b2Vec2(carPosX/worldScale-axleContainerDistance/worldScale-axleContainerHeight/worldScale*Math.cos((90-axleAngle)*degreesToRadians),carPosY/worldScale+axleContainerDepth/worldScale+axleContainerHeight/worldScale*Math.sin((90-axleAngle)*degreesToRadians)));
//			
//			rightAxle.CreateFixture(rightAxleFixture);
//			rightAxle.SetPosition(new b2Vec2(carPosX/worldScale+axleContainerDistance/worldScale+axleContainerHeight/worldScale*Math.cos((90-axleAngle)*degreesToRadians),carPosY/worldScale+axleContainerDepth/worldScale+axleContainerHeight/worldScale*Math.sin((90-axleAngle)*degreesToRadians)));
//			
//			leftWheel.CreateFixture(wheelFixture1);
//			rightWheel.CreateFixture(wheelFixture2);
//		}
//		
//		override protected function defineJoint():void {
//			super.defineJoint();
//			
//			leftWheelRevoluteJointDef=new b2RevoluteJointDef();
//			leftWheelRevoluteJointDef.Initialize(leftWheel,leftAxle,leftWheel.GetWorldCenter());
//			leftWheelRevoluteJointDef.enableMotor=true;
//			
//			rightWheelRevoluteJointDef=new b2RevoluteJointDef();
//			rightWheelRevoluteJointDef.Initialize(rightWheel,rightAxle,rightWheel.GetWorldCenter());
//			rightWheelRevoluteJointDef.enableMotor=true;
//			
//			leftAxlePrismaticJointDef=new b2PrismaticJointDef();
//			leftAxlePrismaticJointDef.lowerTranslation=0;
//			leftAxlePrismaticJointDef.upperTranslation=axleContainerDepth/worldScale;
//			leftAxlePrismaticJointDef.enableLimit=true;
//			leftAxlePrismaticJointDef.enableMotor=true;
//			leftAxlePrismaticJointDef.Initialize(car,leftAxle,leftAxle.GetWorldCenter(), new b2Vec2(-Math.cos((90-axleAngle)*degreesToRadians),Math.sin((90-axleAngle)*degreesToRadians)));
//			
//			rightAxlePrismaticJointDef=new b2PrismaticJointDef();
//			rightAxlePrismaticJointDef.lowerTranslation=0;
//			rightAxlePrismaticJointDef.upperTranslation=axleContainerDepth/worldScale;
//			rightAxlePrismaticJointDef.enableLimit=true;
//			rightAxlePrismaticJointDef.enableMotor=true;
//			rightAxlePrismaticJointDef.Initialize(car,rightAxle,rightAxle.GetWorldCenter(), new b2Vec2(Math.cos((90-axleAngle)*degreesToRadians),Math.sin((90-axleAngle)*degreesToRadians)));
//			
//		}
//		
//		override protected function createJoint():void {
//			super.createJoint();
//			
//			leftWheelRevoluteJoint=world.CreateJoint(leftWheelRevoluteJointDef) as b2RevoluteJoint;
//			leftWheelRevoluteJoint.SetMaxMotorTorque(10);
//			
//			rightWheelRevoluteJoint=world.CreateJoint(rightWheelRevoluteJointDef) as b2RevoluteJoint;
//			rightWheelRevoluteJoint.SetMaxMotorTorque(10);
//			
//			leftAxlePrismaticJoint=world.CreateJoint(leftAxlePrismaticJointDef) as b2PrismaticJoint;
//			leftAxlePrismaticJoint.SetMaxMotorForce(10);                         
//			leftAxlePrismaticJoint.SetMotorSpeed(10);  
//			
//			rightAxlePrismaticJoint=world.CreateJoint(rightAxlePrismaticJointDef) as b2PrismaticJoint;
//			rightAxlePrismaticJoint.SetMaxMotorForce(10);                         
//			rightAxlePrismaticJoint.SetMotorSpeed(10);  
//			
//		}
//		
//	}
//}
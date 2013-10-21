package iobjects 
{
	
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.b2Body;
	import citrus.objects.platformer.box2d.Platform;
	
	import citrus.objects.Box2DPhysicsObject;
	
	public class CarWheel1 extends Box2DPhysicsObject
	{
		private const degreesToRadians:Number = 0.0174532925;
		private var axleAngle:Number = 20;
		private var wheelRadius:Number = 10;
		private var scale = 30;
		
		private var axleContainerDistance:Number = 41;
		private var axleContainerWidth:Number = 4;
		private var axleContainerHeight:Number = 16;
		private var axleContainerDepth:Number = 5;
		
		public function CarWheel1(name:String, params:Object = null)
		{
			params["view"] = "img/carWheelView.swf";
			super(name, params);
		}
		
		override protected function defineBody():void{
			super.defineBody();
			_bodyDef.position.Set(this.x / scale - axleContainerDistance / scale, this.y / scale + axleContainerDepth / scale + axleContainerHeight / scale / 2 );
			_bodyDef.type = b2Body.b2_dynamicBody;
		}
		
		override protected function createShape():void{
			super.createShape();
			_shape = new b2CircleShape(wheelRadius / scale);
		}
		
		override protected function defineFixture():void{
			super.defineFixture();
			
			_fixtureDef.density = 3;
			_fixtureDef.friction = 15;
			_fixtureDef.restitution = 0.2;
			_fixtureDef.shape = _shape;
		}
		
		override public function handleBeginContact(contact:b2Contact):void{
			super.handleBeginContact(contact);
			if (contact.GetFixtureA().GetBody().GetUserData() is Platform){
				
			}
		}
	}
		
}
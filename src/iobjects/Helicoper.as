package iobjects
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2Body;
	
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.platformer.box2d.Enemy;
	
	import flash.display.Sprite;
		
	public class Helicoper extends Box2DPhysicsObject
	{
		private var myview:Sprite;
		[Embed(source = '../bin-debug/img/helicoper.swf')] 
		private var helicopter:Class;
		
		public function Helicoper(name:String, params:Object=null)
		{
			params["view"] = "img/helicoper.swf"
			super(name, params);
		}
		
		override protected function defineBody():void{
			super.defineBody();
			_bodyDef.type = b2Body.b2_kinematicBody;
		}
		
		override public function update(timeDelta:Number):void{
			super.update(timeDelta);
			var car:CarBody = _ce.state.getObjectByName("carBody") as CarBody;
			
			if(car == null)
				return;
			
			if(this.body.GetPosition().x < car.body.GetPosition().x + (100/30) && this.body.GetLinearVelocity().x < car.body.GetLinearVelocity().x * 1.7){		
				this.body.SetLinearVelocity(new b2Vec2(this.body.GetLinearVelocity().x + 0.4, this.body.GetLinearVelocity().y));
			}else if(this.body.GetPosition().x > car.body.GetPosition().x + (100/30)&& this.body.GetLinearVelocity().x > car.body.GetLinearVelocity().x * 1.7){
				this.body.SetLinearVelocity(new b2Vec2(this.body.GetLinearVelocity().x - 0.4, this.body.GetLinearVelocity().y));
			}
			
			if(this.body.GetPosition().y != car.body.GetPosition().y - (180/30) && Math.abs(this.body.GetPosition().x - car.body.GetPosition().x) < (180/30)){
				this.body.SetPosition(new b2Vec2(this.body.GetPosition().x, car.body.GetPosition().y - (180/30)));
			}
		}
	}
}
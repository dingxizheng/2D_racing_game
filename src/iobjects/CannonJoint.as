package iobjects
{
	import citrus.objects.Box2DPhysicsObject;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Joints.*;
	import citrus.objects.Box2DPhysicsObject;
	import Box2D.Dynamics.b2Body;
	import citrus.objects.platformer.box2d.Missile;
	//import flash.ui.Keyboard;
	
	import citrus.input.InputAction;
	import citrus.input.controllers.Keyboard;

	public class CannonJoint extends Box2DPhysicsObject
	{
		private const degreesToRadians:Number = 0.0174532925;
		private var axleAngle:Number = -20;
		private var wheelRadius:Number = 4;
		
		private var scale = 30;		
		private var CannonDistance:Number = 0;
		private var CannonWidth:Number = 25;
		private var CannonHeight:Number = 2.5;
		private var CannonDepth:Number = 28;
		private var inputChannel = 2;
		
		public function CannonJoint(name:String, params:Object = null)
		{
			super(name, params);
		
			_ce.sound.addSound("missile", "sounds/missile.mp3");
			var keyboard:Keyboard = _ce.input.keyboard as Keyboard;
			keyboard.addKeyAction("right_roll", Keyboard.DOWN, inputChannel);
			keyboard.addKeyAction("left_roll", Keyboard.UP, inputChannel);
		}
		
		override protected function defineBody():void{
			super.defineBody();
			_bodyDef.position.Set(this.x / scale + CannonDistance / scale, this.y / scale - CannonDepth / scale);
		}
		
		override protected function createShape():void{
			super.createShape();
			_shape = new b2CircleShape(wheelRadius / scale);
		}
		
		override protected function createFixture():void{
			super.createFixture();
		}
		
		public function addCannon():void{
			var cannon2 = new Cannon("cannon", {x:this.x, y:this.y});
			_ce.state.add(cannon2);
			_body.CreateFixture(cannon2.getFixtureDef());		
		}
		
		public function get_Body():b2Body{
			return this._body;
		}
		
		override public function update(timeDelta:Number):void
		{

			super.update(timeDelta);
			this.body.SetAngle(degreesToRadians * axleAngle);

			if(_ce.input.isDoing("right_roll", inputChannel)){
				axleAngle += 3;
				this.body.SetAngle(axleAngle*degreesToRadians);	
			}
			
			if(_ce.input.isDoing("left_roll", inputChannel)){
				axleAngle -= 3;
				this.body.SetAngle(axleAngle*degreesToRadians);	
			}
			
			
			if(_ce.input.isDown(Keyboard.SPACE)){
				var bullet:Missile;
				_ce.sound.playSound("missile",0.2, 0);
				bullet = new CarMissile("bullet", {x: x + Math.cos(this.body.GetAngle()) * CannonWidth*2, y:y + Math.sin(this.body.GetAngle()) * CannonWidth*2, width:25, height:5, speed:60, angle:this.body.GetAngle() / degreesToRadians});
				_ce.state.add(bullet);
			}

		}
	}
} 
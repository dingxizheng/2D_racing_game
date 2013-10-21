package iobjects 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	
	import citrus.input.InputAction;
	import citrus.input.controllers.Keyboard;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.platformer.box2d.Hero;
	
	import flash.events.TimerEvent;
	import flash.net.dns.AAAARecord;
	import flash.utils.Timer;
	
	import state.GameState;
	import data.CurrentLevelData;
	import state.GameOverState;
	
	/**
	 *@Author Xizheng Ding  
	 */
	public class CarBody extends Hero
	{
		private const degreesToRadians:Number=0.0174532925;
		private var bodyHeight = 10;
		private var bodyWidth = 75;
		private var scale = 30;
		
		private var wheelRadius:Number = 10;
		private var axleContainerDistance:Number = 40;
		private var axleContainerWidth:Number = 4;
		private var axleContainerHeight:Number = 16;
		private var axleContainerDepth:Number = 5;
		private var axleAngle:Number = 0 ;
		
		private var leftWheelRevoluteJoint;
		private var rightWheelRevoluteJoint;
		private var motorSpeed = 0.0;
		private var motorTorque = 0.0;
		private var playingSound:Boolean = false;
		private var timer:Timer;
		private var isTiming:Boolean = false;
		
		public function CarBody(name:String, params:Object=null)
		{
			super(name, params);
			inputChannel = 1;
			_ce.sound.addSound("engine", "sounds/engine.mp3");
			_ce.sound.addSound("lose", "sounds/lose.mp3");
			var keyboard:Keyboard = _ce.input.keyboard as Keyboard;
			keyboard.addKeyAction("right_run", Keyboard.RIGHT, inputChannel);
			keyboard.addKeyAction("left_run", Keyboard.LEFT, inputChannel);
			keyboard.addKeyAction("up_roll", Keyboard.UP, inputChannel);
			keyboard.addKeyAction("down_roll", Keyboard.DOWN, inputChannel);
			
		}
		
		override public function initialize(poolObjectParams:Object=null):void{
			super.initialize(poolObjectParams);
			addWheels();
			addCannon();
		}
		
		override protected function defineBody():void{
			super.defineBody();
			_bodyDef.type = b2Body.b2_dynamicBody;
			_bodyDef.fixedRotation = false;
		}
		
		override protected function createShape():void{
			super.createShape();
			_shape = new b2PolygonShape();
			b2PolygonShape(_shape).SetAsBox(bodyWidth / scale, bodyHeight / scale);

		}
		
		override protected function defineFixture():void {
			super.defineFixture();
			_fixtureDef.density = 20;
			_fixtureDef.friction = 0.5;
			_fixtureDef.restitution=0.2;
			_fixtureDef.shape = _shape;
		}
		
		override protected function createFixture():void{
			super.createFixture();
			var can:Cannon = new Cannon("can", {x:this.x, y:this.y - 50});
			_body.CreateFixture(can.getFixtureDef());
		}
		
		public function addWheels():void{		
			var wheel1:CarWheel1 = new CarWheel1("wheel1", {x:this.x, y:this.y});
			_ce.state.add(wheel1);
			var wheel2:CarWheel2 = new CarWheel2("wheel2", {x:this.x, y:this.y});
			_ce.state.add(wheel2);
			
			var spring1:Spring1 = new Spring1("spring1", {x:this.x, y:this.y});
			var spring2:Spring2 = new Spring2("spring2", {x:this.x, y:this.y});
			
			var leftAxlePrismaticJointDef = new b2PrismaticJointDef();
			leftAxlePrismaticJointDef.lowerTranslation = -0.2;
			leftAxlePrismaticJointDef.upperTranslation = 0.3;
			leftAxlePrismaticJointDef.enableLimit = true;
			leftAxlePrismaticJointDef.enableMotor = true;
			var spring1_body:b2Body = spring1.getBody();
			leftAxlePrismaticJointDef.Initialize(_body, spring1.getBody(), spring1_body.GetWorldCenter(), new b2Vec2(0,1));
			
			var rightAxlePrismaticJointDef = new b2PrismaticJointDef();
			rightAxlePrismaticJointDef.lowerTranslation = -0.2;
			rightAxlePrismaticJointDef.upperTranslation = 0.3;
			rightAxlePrismaticJointDef.enableLimit = true;
			rightAxlePrismaticJointDef.enableMotor = true;
			var spring2_body:b2Body = spring2.getBody();
			rightAxlePrismaticJointDef.Initialize(_body, spring2.getBody(), spring2_body.GetWorldCenter(), new b2Vec2(0,1));
			
			var leftAxlePrismaticJoint =_box2D.world.CreateJoint(leftAxlePrismaticJointDef) as b2PrismaticJoint;
			leftAxlePrismaticJoint.SetMaxMotorForce(80);                         
			leftAxlePrismaticJoint.SetMotorSpeed(3);  
			
			var rightAxlePrismaticJoint =_box2D.world.CreateJoint(rightAxlePrismaticJointDef) as b2PrismaticJoint;
			rightAxlePrismaticJoint.SetMaxMotorForce(80);                         
			rightAxlePrismaticJoint.SetMotorSpeed(3)
			
			var leftWheelRevoluteJointDef = new b2RevoluteJointDef();
			var wheel1_body:b2Body = wheel1.getBody();
			leftWheelRevoluteJointDef.Initialize(wheel1.getBody(),spring1_body, wheel1_body.GetWorldCenter());
			leftWheelRevoluteJointDef.enableMotor = true;
			leftWheelRevoluteJoint = _box2D.world.CreateJoint(leftWheelRevoluteJointDef) as b2RevoluteJoint;
			leftWheelRevoluteJoint.SetMaxMotorTorque(350);
			leftWheelRevoluteJoint.SetMotorSpeed(-40); 
			
			var leftWheelRevoluteJointDef = new b2RevoluteJointDef();
			var wheel2_body:b2Body = wheel2.getBody();
			leftWheelRevoluteJointDef.Initialize(wheel2.getBody(),spring2_body, wheel2_body.GetWorldCenter());
			leftWheelRevoluteJointDef.enableMotor = true;
			rightWheelRevoluteJoint = _box2D.world.CreateJoint(leftWheelRevoluteJointDef) as b2RevoluteJoint;
			rightWheelRevoluteJoint.SetMaxMotorTorque(350);
			rightWheelRevoluteJoint.SetMotorSpeed(-40); 
		}
		
		public function addCannon():void{
			var cannon:CannonJoint = new CannonJoint("cannon", {x:this.x, y:this.y, view:"img/cannon.png"});
			cannon.addCannon();
			_ce.state.add(cannon);
			var revoluteJointDef = new b2RevoluteJointDef();
			var cannon_body:b2Body = cannon.get_Body();
			revoluteJointDef.Initialize(cannon_body, _body, cannon_body.GetWorldCenter());
			var revoluteJoint = _box2D.world.CreateJoint(revoluteJointDef) as b2RevoluteJoint;
			cannon_body.SetAngle(degreesToRadians * -120);
		}
		
		override public function update(timeDelta:Number):void
		{
			if(leftWheelRevoluteJoint == null)
				return;
			
			if (_ce.input.isDoing("left_run", inputChannel)) {
				motorSpeed += 5;
				motorTorque = 350;
				playSound();
			}
			if (_ce.input.isDoing("right_run", inputChannel)) {
				motorSpeed -= 3;
				motorTorque = 350;
				playSound();
			}

			if(_ce.input.hasDone("left_run", inputChannel)||_ce.input.hasDone("right_run", inputChannel)){
				motorSpeed = 0;
				motorTorque = 0;
				stopSound();
			}
			if(_ce.input.isDoing("up_roll", inputChannel)){
				this.body.ApplyTorque(-70);
			}
			if(_ce.input.isDoing("down_roll", inputChannel)){
				this.body.ApplyTorque(70);
			}
			if(_ce.input.justDid("up_roll", inputChannel) || _ce.input.justDid("down_roll", inputChannel)){
				this.body.ApplyTorque(0);
			}
			
			motorSpeed *= 0.99;		
			if (motorSpeed > 60) {
				motorSpeed = 60;
			}	
			if (motorSpeed < -150) {
				motorSpeed = -150;
			}
			
			leftWheelRevoluteJoint.SetMotorSpeed(motorSpeed);
			rightWheelRevoluteJoint.SetMotorSpeed(motorSpeed);	
			leftWheelRevoluteJoint.SetMaxMotorTorque(motorTorque);
			rightWheelRevoluteJoint.SetMaxMotorTorque(motorTorque);
			isUpsideDown();
		}
		
		
		private function GameOver(evt:TimerEvent):void{
			var levelDat:CurrentLevelData = CurrentLevelData.getInstance();
			if(levelDat.getData(CurrentLevelData.TIMES) == 1){
				levelDat.resetData();
				levelDat.saveData();
				Project1.changeState(Project1.GAME_OVER_STATE);
			}else{
				levelDat.decreaseData(CurrentLevelData.TIMES, 1);
				levelDat.saveData();
				Project1.changeState(Project1.GAME_STATE);
			}		
			
		}
		
		private function isUpsideDown():void{
			if(Math.abs(this.rotation) - 360 * int((Math.abs(this.rotation) / 360)) > 120){
				if(!isTiming){
					timer = new Timer(4000, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, GameOver);
					timer.start();
				}
				isTiming = true;
			}else{
				isTiming = false;
				if(timer != null){
				    timer.removeEventListener(TimerEvent.TIMER_COMPLETE, GameOver);
				    timer.stop();
				}
			}
		}
		
		private function playSound():void{
			if(!playingSound)
				_ce.sound.playSound("engine",0.2, 0);
			playingSound = true;
		}
		
		private function stopSound():void{
			if(playingSound)
				_ce.sound.stopSound("engine");
			playingSound = false;
		}
		
		override protected function updateAnimation():void
		{
		}
		
	}
}
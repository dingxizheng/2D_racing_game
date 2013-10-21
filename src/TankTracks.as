package
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Joints.*;
	
	public class TankTracks extends Object{
		
		public var links:Array = new Array();
		public var linkjoints:Array = new Array();
		public var wheels:Array =  new Array();
		public var wheeljoints:Array = new Array();
		public var frame:b2Body;
		
		public function TankTracks (physworld:b2World, startX:Number, startY:Number, wheelsize:Number, framelength:Number, 
									thickness:Number, number_of_links:int, tightness:Number = 0.8, addShape:b2Shape = null) {
			
			
			var boxdef = new b2PolygonShape();
			var bodydef = new b2BodyDef();
			var circ = new b2CircleShape();
			var joint = new b2RevoluteJointDef();
			var perimeter:Number = (Math.PI *( wheelsize + thickness)) + (2 * framelength) ;
			//trace(perimeter)
			var trackradius:Number = wheelsize + (framelength/ 2);
			trackradius *= tightness;
			
			//The frame that fixes the wheels.
			boxdef.SetAsBox(framelength/2,wheelsize/2);
			boxdef.density = 1.0; 
			boxdef.friction = 0.3;
			
			bodydef.position.Set((framelength/2) + startX,startY);
			
			frame = physworld.CreateBody(bodydef);
			
			if(addShape){
				addShape.restitution = 0.8;
				addShape.density = 1;
				addShape.groupIndex = -8;
				frame.CreateFixture(addShape);
			}
			frame.CreateFixture(boxdef);
			frame.SetMassFromShapes()
			
			//The wheels
			circ.radius = wheelsize;
			circ.density = 1;
			circ.friction = 2;
			circ.restitution = 0;
			bodydef = new b2BodyDef();
			
			//Left wheel
			bodydef.position.Set(startX,startY);
			wheels[0] = physworld.CreateDynamicBody(bodydef);
			wheels[0].CreateShape(circ);
			wheels[0].SetMassFromShapes()
			
			joint.Initialize(wheels[0],frame,wheels[0].GetWorldCenter());
			wheeljoints[0] = physworld.CreateJoint(joint);
			
			//Right wheel
			bodydef.position.Set(framelength + startX,startY);
			wheels[1] = physworld.CreateDynamicBody(bodydef);
			wheels[1].CreateShape(circ);
			wheels[1].SetMassFromShapes();
			
			
			joint.Initialize(wheels[1],frame,wheels[1].GetWorldCenter());
			wheeljoints[1] = physworld.CreateJoint(joint);
			
			
			//Create the tracks.
			//trace(perimeter);
			boxdef.SetAsBox((perimeter/Number(number_of_links))/2,thickness);
			boxdef.friction = 3;
			boxdef.density = 2;
			boxdef.groupIndex = -8;
			bodydef = new b2BodyDef();
			joint = new b2RevoluteJointDef()
			joint.enableLimit = true;
			joint.lowerAngle 
			joint.lowerAngle = -40 / (180/Math.PI);
			joint.upperAngle = 40 / (180/Math.PI);
			var firstBody:b2Body;
			var tBody;
			var body
			var angle; var tX; var tY;
			for (var i = 0; i < number_of_links; i++){
				angle = i/number_of_links * Math.PI * 2;
				tX = startX + (framelength/2) + Math.sin(angle) * trackradius;
				tY = Math.cos(angle) * trackradius +startY;
				bodydef.position.Set(tX , tY );
				bodydef.angle = -angle;
				//trace("tX: " + tX + " tY: " + tY);
				body = physworld.CreateDynamicBody(bodydef);
				body.CreateShape(boxdef);
				body.SetMassFromShapes();
				links.push(body);
				
				if (i != 0){
					joint.Initialize(tBody,body,new b2Vec2(((tX) + tBody.GetPosition().x) / 2, (tY + tBody.GetPosition().y) / 2));
					physworld.CreateJoint(joint);
				}
				else{
					firstBody = body;
				}
				tBody = body;
			}
			joint.Initialize(body, firstBody, new b2Vec2((firstBody.GetPosition().x + body.GetPosition().x) / 2, (firstBody.GetPosition().y + body.GetPosition().y) / 2));
			linkjoints.push(physworld.CreateJoint(joint));
		}
	}
}
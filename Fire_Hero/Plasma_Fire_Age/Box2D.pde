import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.callbacks.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.Manifold;
import org.jbox2d.dynamics.contacts.Contact;

// A reference to our box2d world
Box2DProcessing box2d;

Body makeRectangleBody(float x, float y, float w, float h)
{
   Vec2 center = new Vec2(x,y);
   PolygonShape sd = new PolygonShape();
   float halfWidth = box2d.scalarPixelsToWorld(w/2);
   float halfHeight = box2d.scalarPixelsToWorld(h/2);
   sd.setAsBox(halfWidth,halfHeight);
   
   FixtureDef fd = new FixtureDef();
   fd.shape = sd;

   BodyDef bd = new BodyDef();
   bd.type = BodyType.KINEMATIC;
   bd.position.set(box2d.coordPixelsToWorld(center));
   
   Body body = box2d.createBody(bd);
   body.createFixture(fd);
   return body;
}

Body makeRectangleBody(float x, float y, float w, float h, BodyType type, float friction, float restitution, boolean sensor)
{
  Vec2 center = new Vec2(x,y);
  PolygonShape sd = new PolygonShape();
  float halfWidth = box2d.scalarPixelsToWorld(w/2);
  float halfHeight = box2d.scalarPixelsToWorld(h/2);
  sd.setAsBox(halfWidth,halfHeight);

  FixtureDef fd = new FixtureDef();
  fd.shape = sd;
  fd.friction = friction;
  fd.restitution = restitution;
  fd.isSensor = sensor;

  BodyDef bd = new BodyDef();
  bd.type = type;
  bd.position.set(box2d.coordPixelsToWorld(center));

  Body body = box2d.createBody(bd);
  body.createFixture(fd);
  return body;
}

Body makeRectangleBodyKinematic(float x, float y, float w, float h)
{
  return makeRectangleBody(x,y,w,h,BodyType.KINEMATIC,0.5f,0.5f,false);
}

Body makeRectangleBodyDynamic(float x, float y, float w, float h)
{
  return makeRectangleBody(x,y,w,h,BodyType.DYNAMIC,0.5f,0.5f,false);  
}

Body makeRectangleBodyStatic(float x, float y, float w, float h)
{
  return makeRectangleBody(x,y,w,h,BodyType.STATIC,0.5f,0.5f,false);
}

Body makeCircleBody(float x, float y, float diameter)
{   
   Vec2 center = new Vec2(x,y);
   CircleShape sd = new CircleShape();
   float radius = box2d.scalarPixelsToWorld(diameter/2);
   sd.setRadius(radius);
   
   FixtureDef fd = new FixtureDef();
   fd.shape = sd;
   fd.restitution = 1;
   fd.friction = 0;
   
   BodyDef bd = new BodyDef();
   bd.type = BodyType.DYNAMIC;
   bd.position.set(box2d.coordPixelsToWorld(center));
   
   Body body = box2d.createBody(bd);
   body.createFixture(fd);
   return body;
}

Body makeCircleBody(float x, float y, float radius, BodyType type, float friction, float restitution, boolean sensor)
{
   Vec2 center = new Vec2(x,y);
   
   CircleShape sd = new CircleShape();
   radius = box2d.scalarPixelsToWorld(radius);
   sd.setRadius(radius);

   FixtureDef fd = new FixtureDef();
   fd.shape = sd;
   fd.restitution = restitution;
   fd.friction = friction;
   fd.isSensor = sensor;

   BodyDef bd = new BodyDef();
   bd.type = type;
   bd.position.set(box2d.coordPixelsToWorld(center));

   Body body = box2d.createBody(bd);
   body.createFixture(fd);
   return body;
}

Body makeCircleBodyBox2DCoords(float x, float y, float radius, BodyType type, float friction, float restitution, boolean sensor)
{
   Vec2 center = new Vec2(x,y);
   
   CircleShape sd = new CircleShape();
   radius = box2d.scalarPixelsToWorld(radius);
   sd.setRadius(radius);

   FixtureDef fd = new FixtureDef();
   fd.shape = sd;
   fd.restitution = restitution;
   fd.friction = friction;
   fd.isSensor = sensor;

   BodyDef bd = new BodyDef();
   bd.type = type;
   bd.position.set(center);

   Body body = box2d.createBody(bd);
   body.createFixture(fd);
   return body;
}


Body makeCircleBodyDynamic(float x, float y, float radius)
{
  return makeCircleBody(x,y,radius,BodyType.DYNAMIC,0.5f,0.5f,false);
}

Body makeCircleBodyKinematic(float x, float y, float radius)
{
  return makeCircleBody(x,y,radius,BodyType.KINEMATIC, 0.5f,0.5f,false);
}

Body makeCircleBodyStatic(float x, float y, float radius)
{
  return makeCircleBody(x,y,radius,BodyType.STATIC,0.5f,0.5f,false);
}

float getBox2DCoordX(float coord)
{
 return box2d.scalarPixelsToWorld(coord);
}

float getBox2DCoordY(float coord)
{
  return box2d.scalarPixelsToWorld(coord);
}

void drawRectangle(Body paddle, float w, float h)
{
  rectMode(CENTER);

  pushMatrix();
  Vec2 pos = box2d.getBodyPixelCoord(paddle);
  translate(pos.x,pos.y);
  stroke(0);
  rect(0, 0, w, h);
  popMatrix();
}

void drawImage(Body paddle, float w, float h, PImage image)
{
  imageMode(CENTER);

  pushMatrix();
  Vec2 pos = box2d.getBodyPixelCoord(paddle);
  translate(pos.x,pos.y);
  stroke(0);
  image(image,0, 0, w, h);
  popMatrix();
}


void drawCircle(Body circle, float diameter)
{
  Vec2 pos = box2d.getBodyPixelCoord(circle);

  pushMatrix();
  translate(pos.x,pos.y);
  stroke(0);
  ellipse(0,0,diameter,diameter);
  popMatrix();
}

float getPositionX(Body body)
{
  Vec2 trans = body.getPosition();
  return trans.x;
}
float getProcessingPositionX(Body body)
{
  Vec2 pos = box2d.getBodyPixelCoord(body);
  return pos.x;
}

void setPositionX(Body body, float posX)
{
  Vec2 trans = body.getPosition();
  trans.x = posX;
  body.setTransform(trans,0);
}


float getPositionY(Body body)
{
  Vec2 trans = body.getPosition();
  return trans.y;
}

float getProcessingPositionY(Body body)
{
  Vec2 pos = box2d.getBodyPixelCoord(body);
  return pos.y;
}

void setPositionY(Body body, float posY)
{
  Vec2 trans = body.getPosition();
  trans.y = posY;
  body.setTransform(trans,0);
}

void setPosition(Body body, float posX, float posY)
{
  Vec2 trans = new Vec2(0,0);
  trans.x = posX;
  trans.y = posY;
  body.setTransform(trans,0);
}

void setVelocity(Body body, int direction, float speed)
{
  Vec2 velocity = new Vec2();
  velocity.x = (float)Math.cos(Math.toRadians(direction));
  velocity.y = (float)Math.sin(Math.toRadians(direction));
  velocity.mulLocal(speed);
  body.setLinearVelocity(velocity);
}

void setLinearVelocity(Body body, Vec2 velocity)
{
  body.setLinearVelocity(velocity);
}

void addVelocity(Body body, int direction, float speed)
{
  Vec2 velocity = new Vec2();
  velocity.x = (float)Math.cos(Math.toRadians(direction));
  velocity.y = (float)Math.sin(Math.toRadians(direction));
  velocity.mulLocal(speed);
  Vec2 current = body.getLinearVelocity();
  velocity.addLocal(current);
  body.setLinearVelocity(velocity);
}

/**
* Creates the Box2D world, should be the second step in setup
* comes after setting up the size.
* \param gravityMagnitude The magnitude of gravity
*/
void createWorld(float gravityMagnitude)
{
    // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();
  
  // We are setting a custom gravity
  box2d.setGravity(0, gravityMagnitude);
}

void step()
{
  box2d.step();
  for(Body b : bodiesToRemove)
  {
    box2d.destroyBody(b);
  }
  bodiesToRemove.clear();
}

void addForce(Body body, float direction, float magnitude, float duration)
{

}

float getSpeed(Body body)
{
  return body.getLinearVelocity().length();
}

void setSpeed(Body body, float speed)
{
  body.getLinearVelocity().normalize();
  body.getLinearVelocity().mulLocal(speed);
  body.setLinearVelocity(body.getLinearVelocity());
}

ArrayList<Body> bodiesToRemove = new ArrayList<Body>();

void destroyBody(Body body)
{
  bodiesToRemove.add(body);
}

void setUserData(Body body, String userData)
{
  body.setUserData(userData);
}

String getUserData(Body body)
{
  return (String)body.getUserData();
}

void beginContact(Contact contact)
{
  Body bodyA = contact.getFixtureA().getBody();
  Body bodyB = contact.getFixtureB().getBody();
  
  handleCollision(bodyA,bodyB);
}
  
void endContact(Contact contact)
{
}

boolean collisionNonseq(Body firstCollider, Body secondCollider, String firstData, String secondData)
{
  String firstUserData = getUserData(firstCollider);
  String secondUserData = getUserData(secondCollider);
  
  return (compareString(firstUserData, firstData) && compareString(secondUserData, secondData));
}


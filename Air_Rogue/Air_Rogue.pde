PImage playerImage;
PImage backgroundImage;
PImage bulletImage;
PImage enemyImage;
PImage ballImage;
PImage nemesisImage;

void handleCollision(Body one, Body two)
{
  println("in collision");
  String userDataOne = getUserData(one);
  String userDataTwo = getUserData(two);
  
  if(userDataOne == null || userDataTwo == null)
  {
    return;
  }
  // Handle collisions between:
  // -- Bullet and Enemy
  if(compareString(userDataOne,"Bullet")&&compareString(userDataTwo,"Enemy"))  
  {
   destroyBody(one);
    destroyBody(two);
    bodyListRemove(bullets,one);
    bodyListRemove(enemies,two);
  }
  if(compareString(userDataOne,"Enemy")&&compareString(userDataTwo,"Bullet"))  
  {
   destroyBody(one);
    destroyBody(two);
    bodyListRemove(bullets,two);
    bodyListRemove(enemies,one);
  }
  if(compareString(userDataOne,"Bullet")&&compareString(userDataTwo,"Nemisis"))  
  {
   destroyBody(one);
    destroyBody(two);
    bodyListRemove(bullets,one);
    bodyListRemove(nemesis3,two);
  }
  if(compareString(userDataOne,"Enemy")&&compareString(userDataTwo,"Nemeisis"))  
  {
   destroyBody(one);
    destroyBody(two);
    bodyListRemove(bullets,two);
    bodyListRemove(nemesis3,one);
  }
  if((isKeyPressed('u')) && (compareString(userDataOne,"Player") && compareString(userDataTwo,"Enemy")) || (isKeyPressed('L')) && (compareString(userDataOne,"Player") && compareString(userDataTwo,"Enemy")))
  {
  
  destroyBody(two);
  
  bodyListRemove(enemies,two);
  return;
  }
  if((isKeyPressed('u')) && (compareString(userDataTwo,"Player") && compareString(userDataOne,"Enemy")) || (isKeyPressed('L')) && (compareString(userDataTwo,"Player") && compareString(userDataOne,"Enemy")))  
  {
  
  destroyBody(one);
  
  bodyListRemove(enemies,one);
  return;
  }
  if(compareString(userDataOne,"Ball")&&compareString(userDataTwo,"Enemy"))  
  {
   destroyBody(one);
  destroyBody(two);
  bodyListRemove(balls,one);
  bodyListRemove(enemies,two);
  }
  if(compareString(userDataTwo,"Ball")&&compareString(userDataOne,"Enemy"))  
  {
   destroyBody(two);
  destroyBody(one);
  bodyListRemove(balls,two);
  bodyListRemove(enemies,one);
  }
    if(compareString(userDataOne,"Ball")&&compareString(userDataTwo,"Nemesis"))  
  {
   destroyBody(one);
  destroyBody(two);
  bodyListRemove(balls,one);
  bodyListRemove(nemesis3,two);
  }
  if(compareString(userDataTwo,"Ball")&&compareString(userDataOne,"Nemesis"))  
  {
   destroyBody(two);
  destroyBody(one);
  bodyListRemove(balls,two);
  bodyListRemove(nemesis3,one);
  }

  // -- Player and Enemy
  if((isKeyPressed('J')) && (compareString(userDataOne,"Player")&&compareString(userDataTwo,"Enemy")))
  {
    
    return;
  }
  if((isKeyPressed('J')) && (compareString(userDataTwo,"Player")&&compareString(userDataOne,"Enemy")))
  {
    
   return;
  }
  else if(compareString(userDataOne,"Player")&&compareString(userDataTwo,"Enemy"))
  {
    stopGame();
   dead=true;
   clear(); 
  }
  if(compareString(userDataOne,"Enemy")&&compareString(userDataTwo,"Player"))
  {
stopGame();
   dead=true;
   clear(); 
  }
  if((isKeyPressed('J')) && (compareString(userDataOne,"Player")&&compareString(userDataTwo,"Nemesis")))
  {
    
    return;
  }
  if((isKeyPressed('J')) && (compareString(userDataTwo,"Player")&&compareString(userDataOne,"Nemesis")))
  {
    
    return;
  }
  else if(compareString(userDataOne,"Player")&&compareString(userDataTwo,"Nemisis"))
  {
    stopGame();
   dead=true;
   clear(); 
  }
  if(compareString(userDataOne,"Nemisis")&&compareString(userDataTwo,"Player"))
  {
stopGame();
   dead=true;
   clear(); 
  }
   // -- Other things
}

boolean dead = false;
Body player;

List<Body> bullets = bodyListCreate();
List<Body> balls = bodyListCreate();
List<Body> enemies = bodyListCreate();
List<Body> nemesis3 = bodyListCreate();

void createPlayer()
{
  player = makeRectangleBodyDynamic(width/4,height/4,64,64);
  setUserData(player,"Player");
}

void drawPlayer()
{
  drawImage(player,64,64,playerImage);
}


void setup()
{
  size(1200,1000);
  //we're in space, 0-gravity
  createWorld(0);
  createPlayer();
  playerImage=loadImage("Air Knight mega.png");
  backgroundImage=loadImage("war6.png");
  
  enemyImage=loadImage("earth pawn.png");
  ballImage=loadImage("airball1.png");
  nemesisImage=loadImage("earth knight.png");
  
}

//speed of a player bullet
int bulletSpeed = 40;

void doInput()
{
  setVelocity(player,0,0);
  
  if(isKeyPressed('a') || isKeyPressed('A'))
  {
    addVelocity(player,180,10);
  } 
  else if(isKeyPressed('d') || isKeyPressed('D'))
  {
    addVelocity(player,0,10);
  } 
  
  if(isKeyPressed('w') || isKeyPressed('W'))
  {
    addVelocity(player,90,10);
  } 
  else if(isKeyPressed('s') || isKeyPressed('S'))
  {
    addVelocity(player,270,10);
  } 
  
  if(getSpeed(player) > 20)
  {
    setSpeed(player,20);
  }
  
//  if(isKeyPressed('j'))
 // {
 //   shootBullet(bulletSpeed,180);
//  }
//  else if(isKeyPressed('k'))
//  {
//    shootBullet(bulletSpeed,270);
//  }
//  else if(isKeyPressed('i'))
//  {
//    shootBullet(bulletSpeed,90);
//  }
//  else if(isKeyPressed('l'))
//  {
//    shootBullet(bulletSpeed,0);
//  }
if(isKeyPressed('j'))
{
    shootBall(bulletSpeed,180);
  }
  else if(isKeyPressed('k'))
  {
    shootBall(bulletSpeed,270);
  }
  else if(isKeyPressed('i'))
  {
    shootBall(bulletSpeed,90);
  }
  else if(isKeyPressed('l'))
  {
    shootBall(bulletSpeed,0);
  }
}
void stopGame()
{
  setUserData(player,null);
  dead=true;
   while(bodyListGetLength(enemies)>0)
 {
   Body firstEnemy=bodyListGetElement(enemies, 0);
   bodyListRemove(enemies,firstEnemy);
   if(firstEnemy!=null)
   {
     destroyBody(firstEnemy);
   }
 }
 while(bodyListGetLength(bullets)>0)
 {
   Body firstBullet=bodyListGetElement(bullets,0);
   bodyListRemove(bullets,firstBullet);
   if(firstBullet!=null)
   {
     box2d.destroyBody(firstBullet);
   }
 }
 while(bodyListGetLength(balls)>0)
 {
   Body firstBall=bodyListGetElement(balls,0);
   bodyListRemove(balls,firstBall);
   if(firstBall!=null)
   {
     box2d.destroyBody(firstBall);
   }
 }
 bullets=bodyListCreate();
 enemies=bodyListCreate();
 balls = bodyListCreate();
 setUserData(player,"Player");
}
void doDeadInput()
{
 if(isKeyPressed('r'))
{

 bullets=bodyListCreate();
 enemies=bodyListCreate();
 destroyBody(player);
 createPlayer();
 dead=false;
} 
}

int iteration2 = 0;//enemies on screen
int iterations2 = 1000;
int enemySize2 = 64;//width and height for enemies

void spawnNemesis()
{
  if(iteration2==iterations2)
  {
    iteration2=0;
    int side=randomRange(0,4);
    int posX=0;
    int posY=0;
    if(side==0)
    {
     posX=width;
    posY=height/2; 
    }
    else if(side==1)
    {
     posX=width/2;
    posY=0;
    }
    else if(side==2)
    {
     posX=0;
    posY=height/2; 
    }
    else if(side==3)
    {
     posX=width/2;
    posY=height; 
    }
  Body nemesis=makeRectangleBodyDynamic(posX,posY,enemySize2,enemySize2);
  bodyListAdd(nemesis3,nemesis);
  setUserData(nemesis,"Nemesis");
  }
  iteration2++;
}

void drawNemesis()
{
  for(int i = 0; i < bodyListGetLength(nemesis3); ++i)
  {
    Body body = bodyListGetElement(nemesis3,i);
    
    fill(color(0,255,255));
    drawImage(body,enemySize2,enemySize2, nemesisImage);
    fill(color(255,255,255));
  }
}


int iteration = 0;//enemies on screen
int iterations = 50;
int enemySize = 32;//width and height for enemies

void spawnEnemy()
{
  //Spawn enemies until there are enough on the screen
  if(iteration==iterations)
  {
    iteration=0;
    int side=randomRange(0,4);
    int posX=0;
    int posY=0;
    if(side==0)
    {
     posX=width;
    posY=height/2; 
    }
    else if(side==1)
    {
     posX=width/2;
    posY=0;
    }
    else if(side==2)
    {
     posX=0;
    posY=height/2; 
    }
    else if(side==3)
    {
     posX=width/2;
    posY=height; 
    }
  Body enemy=makeRectangleBodyDynamic(posX,posY,enemySize,enemySize);
  bodyListAdd(enemies,enemy);
  setUserData(enemy,"Enemy");
  }
  iteration++;
}


void drawEnemies()
{
  for(int i = 0; i < bodyListGetLength(enemies); ++i)
  {
    Body body = bodyListGetElement(enemies,i);
    
    fill(color(0,255,255));
    drawImage(body,enemySize,enemySize, enemyImage);
    fill(color(255,255,255));
  }
}

void drawBullets()
{
  for(int i = 0; i < bodyListGetLength(bullets); ++i)
  {
    Body body = bodyListGetElement(bullets,i);
    
    fill(color(255,0,0));
    drawImage(body,25,25,bulletImage);
    fill(color(255,0,0));
  }
  for(int i = 0; i < bodyListGetLength(balls); ++i)
  {
    Body body = bodyListGetElement(balls,i);
    
    drawImage(body,25,25,ballImage);
  }
}

//handle AI-based movement for each enemy
void updateEnemy(Body enemy)
{
  //slowly move Body enemy towards player
  float enemyX=getPositionX(enemy);
  float enemyY=getPositionY(enemy);
  float playerX=getPositionX(player);
  Float playerY=getPositionY(player);
  float diffX=playerX-enemyX;
  float diffY= playerY-enemyY;
  float dist=sqrt(diffX*diffX+diffY*diffY);
  diffX/=dist;
  diffY/=dist;
  diffX*=0.1;
  diffY*=0.1;
  setPositionX(enemy,enemyX+diffX);
  setPositionY(enemy,enemyY+diffY);
}

//update all of the enemies using the updateEnemy function
void updateEnemies()
{
  for(int i = 0; i < bodyListGetLength(enemies); ++i)
  {
    updateEnemy(bodyListGetElement(enemies,i));
  }
}

void updateNemesis3()
{
  for(int i = 0; i < bodyListGetLength(nemesis3); ++i)
  {
    updateEnemy(bodyListGetElement(nemesis3,i));
  }
}

void updateNemesis(Body nemesis)
{
  //slowly move Body enemy towards player
  float nemesisX=getPositionX(nemesis);
  float nemesisY=getPositionY(nemesis);
  float playerX=getPositionX(player);
  Float playerY=getPositionY(player);
  float diffX=playerX-nemesisX;
  float diffY= playerY-nemesisY;
  float dist=sqrt(diffX*diffX+diffY*diffY);
  diffX/=dist;
  diffY/=dist;
  diffX*=0.1;
  diffY*=0.1;
  setPositionX(nemesis,nemesisX+diffX);
  setPositionY(nemesis,nemesisY+diffY);
}


int bulletSize = 16;
void shootBall(float speed, int direction)
{
  float posX = getPositionX(player);
  float posY = getPositionY(player);
  //Body bullet=makeRectangleBody(posX, posY, bulletSize, bulletSize);
  //Body bullet = makeCircleBodyDynamic(posX,posY,bulletSize);
  Body ball = makeCircleBodyBox2DCoords(posX,posY, bulletSize, BodyType.DYNAMIC, 0,0,true);
  bodyListAdd(balls,ball);
  setUserData(ball,"Ball");
  setVelocity(ball, direction, speed);
}

void shootBullet(float speed, int direction)
{
  //spawn a bullet, or set of bullets
  float posX = getProcessingPositionX(player);
  float posY=getProcessingPositionY(player);
  //Body bullet=makeRectangleBody(posX, posY, bulletSize, bulletSize);
  Body bullet = makeCircleBodyDynamic(posX,posY,bulletSize);
  bodyListAdd(bullets,bullet);
  setUserData(bullet,"Bullet");
  setVelocity(bullet, direction, speed);
  
}

void draw()
{
  background(backgroundImage);
  
  if(!dead)
  {
    spawnEnemy();
    spawnNemesis();
    doInput();
    
    updateEnemies();
    updateNemesis3();
    drawPlayer();
    drawEnemies();
    drawBullets();
    drawNemesis();
    swapKeys();
     step(); 
textSize(32);

  }
  else
  {   
    textSize(64);
    text(" Game Over!\n Press 'r' to play practice!",width/3,height/3);
    doDeadInput();
    swapKeys();
  }
}

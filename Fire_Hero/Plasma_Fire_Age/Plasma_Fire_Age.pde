PImage playerImage;
PImage backgroundImage;
PImage bulletImage;
PImage enemyImage;

void handleCollision(Body one, Body two)
{
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
if(compareString(userDataTwo,"Bullet")&&compareString(userDataOne,"Enemy"))  
{
 destroyBody(two);
destroyBody(one);
bodyListRemove(bullets,two);
bodyListRemove(enemies,one);
}
  // -- Player and Enemy
  if(compareString(userDataOne,"Player")&&compareString(userDataTwo,"Enemy"))
  {
   dead=true;
   clear(); 
  }
  if(compareString(userDataOne,"Enemy")&&compareString(userDataTwo,"Player"))
  {
   dead=true;
   clear(); 
  }
   // -- Other things
}

boolean dead = false;
Body player;

List<Body> bullets = bodyListCreate();
List<Body> enemies = bodyListCreate();

void createPlayer()
{
  player = makeRectangleBodyDynamic(width/2,height/2,64,64);
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
  playerImage=loadImage("player1.png");
  backgroundImage=loadImage("collide1.png");
  bulletImage=loadImage("fireball1.png");
  enemyImage=loadImage("enemy1.png");
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
  
  if(isKeyPressed('j') || isKeyPressed('J'))
  {
    shootBullet(bulletSpeed,180);
  }
  else if(isKeyPressed('k') || isKeyPressed('K'))
  {
    shootBullet(bulletSpeed,270);
  }
  else if(isKeyPressed('i') || isKeyPressed('I'))
  {
    shootBullet(bulletSpeed,90);
  }
  else if(isKeyPressed('l') || isKeyPressed('L'))
  {
    shootBullet(bulletSpeed,0);
  }
}
void doDeadInput()
{
 if(isKeyPressed('r'))
{
 while(bodyListGetLength(enemies)>0)
 {
   Body firstEnemy=bodyListGetElement(enemies, 0);
   bodyListRemove(enemies,firstEnemy);
   destroyBody(firstEnemy);
 }
 while(bodyListGetLength(bullets)>0)
 {
   Body firstBullet=bodyListGetElement(bullets,0);
   bodyListRemove(bullets,firstBullet);
   box2d.destroyBody(firstBullet);
 }
 bullets=bodyListCreate();
 enemies=bodyListCreate();
 destroyBody(player);
 createPlayer();
 dead=false;
} 
}

int iteration = 0;//enemies on screen
int iterations = 25;
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
  Body enemy=makeRectangleBodyDynamic(600,600,enemySize,enemySize);
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


int bulletSize = 16;
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
    
    doInput();
    
    updateEnemies();
    
    drawPlayer();
    drawEnemies();
    drawBullets();
    swapKeys();
     step(); 
  }
  else
  {   
    textSize(32);
    text("Contact! \nGame Over!\n Press 'R' to revive!",width/2,height/2);
    doDeadInput();
    swapKeys();
  }
}

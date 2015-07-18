import java.util.Random;

Random rand = new Random();

public static double clamp (double i, double low, double high)
{
  return java.lang.Math.max (java.lang.Math.min (i, high), low);
}


public static float clamp (float i, float low, float high)
{
  return java.lang.Math.max (java.lang.Math.min (i, high), low);
}


public static int clamp (int i, int low, int high)
{
  return java.lang.Math.max (java.lang.Math.min (i, high), low);
}


public static long clamp (long i, long low, long high)
{
  return java.lang.Math.max (java.lang.Math.min (i, high), low);
}

void printMousePosition()
{
  Vec2 localMouseInWorld = box2d.coordPixelsToWorld(mouseX,mouseY);
  
  println("Processing Mouse: " + mouseX + " , " + mouseY);
  println("Box2D Mouse: " + localMouseInWorld.x + ", " + localMouseInWorld.y);
  println("----------");
}

int randomRange(int min, int max)
{
  return rand.nextInt(max - min) + min;
}

boolean compareString(String one, String two)
{
  return one.equals(two);
}

boolean[] keyDown = new boolean[256];
boolean[] keyDownPrevious = new boolean[256];

boolean[] codedKeyDown = new boolean[256];
boolean[] codedKeyDownPrevious = new boolean[256];

void keyPressed()
{
  if(key == CODED)
  {
    codedKeyDown[keyCode] = true;
    return;
  }
  if(key > 255)
  {
    return;
  }
  keyDown[key] = true;
}

void keyReleased()
{
  if(key == CODED)
  {
    codedKeyDown[keyCode] = false;
    return;
  }
  if(key > 255)
  {
    return;
  }
  keyDown[key] = false;
}

void swapKeys()
{
  boolean[] keys = keyDown;
  boolean[] codedKeys = codedKeyDown;
  System.arraycopy(keyDown,0,keyDownPrevious,0,keyDown.length);
  System.arraycopy(codedKeyDown,0,codedKeyDownPrevious,0,codedKeyDown.length);
}

boolean isCodedKeyPressed(int key)
{
  return codedKeyDown[key];
}

boolean isKeyPressed(char key)
{
  return keyDown[key];
}

boolean isCodedKeyTriggered(int key)
{
  return !codedKeyDownPrevious[key] && codedKeyDown[key];
}

boolean isKeyTriggered(char key)
{
  return !keyDownPrevious[key] && keyDown[key];
}


/*
- render head X
 - Make movement X
 2. Standard movement X
 2.1 Add framework for mouse movement X
 2.2 Move with wasd X
 - Make everything a Pgraphic. X
 - Add tail
 1.1 Make direction() reusable X
 1.2 rework head if needed X
 1.3 tail: put it through direction() X
 1.4 safe the last coords in the loop to use in the next repetition. X
 1.5 test with smoother angle changes. X
 2.1 Make a ARRAYlist that stores x, y and angle X
 2.1.2 Make class for the tail together with a constructor X
 2.2 Spawn balls X
 2.4 movement updates are done with x and y
 - Add grow points
 - Add window resize
 - Add proper mouse movement.
 - Add menu initialising thingy
 - Add enemies
 - Add dungeon
 */
boolean start = true;

PGraphics GameGraph;

boolean startLoading = true;

float playerHeadX;
float playerHeadY;

float playerAngle = 0;

PlayerSnake Player;

void setup() {
  size(500, 500);
  background(25);
  
  
  boolean start = true;
  /*if (start==true) {
    windowMove(0, 0);
    windowResize(500, 500);
  }*/
  

  GameGraph = createGraphics(displayWidth, displayHeight);
  GameGraph.beginDraw();
  GameGraph.background(25);
  GameGraph.endDraw();

  playerHeadX = width/2;
  playerHeadY = height/2;
  
  Player = new PlayerSnake();
}

void draw() {
  background(25);
  drawPlayer();
}

void keyPressed() {
  switch(key) {
  case 'd':
    playerAngle = 0;
    break;
  case 'a':
    playerAngle = 180;
    break;
  case 's':
    playerAngle = 90;
    break;
  case 'w':
    playerAngle = 270;
    break;
  }
}


void drawPlayer() {
  Player.playerHead();
  Player.playerTailMethod();
  
  GameGraph.endDraw();
  image(GameGraph, 0, 0);
}


class PlayerSnake {

  float xHeadMult = 0;
  float yHeadMult = 0;
  float lastXPos = 0;
  float lastYPos = 0;
  float lastXDir = 0;
  float lastYDir = 0;

  ArrayList<Tail> playerTail = new ArrayList<Tail>();
  int tailSize = 5;


  void playerHead() {
    GameGraph.beginDraw();
    GameGraph.background(25);
    
    float[] coordsMult = direction(playerAngle, 2.5);
    lastXPos = playerHeadX;
    lastYPos = playerHeadY;
    lastXDir = coordsMult[0];
    lastYDir = coordsMult[1];
    playerHeadX += coordsMult[0];
    playerHeadY += coordsMult[1];
    
    GameGraph.ellipse(playerHeadX, playerHeadY, 40, 40);
  }
  
  void playerTailMethod() {
    //move tail
    //Check if there is a tail to begin with
    if (playerTail.size() > 0) 
    {
      //Repeat the following code for every part of the tail (last to first)
      for (int i = playerTail.size()-1; i >= 0; i--)
      {
        Tail currentTail = playerTail.get(i);
        //if it's the first part of the tail use the head data
        if(i == 0)
        { 
          currentTail.setDir(lastXDir, lastYDir);
        }
        else //else use the last part of the tail
        {
          Tail lastTail = playerTail.get(i-1);
          
          currentTail.setDir(lastTail.xDir, lastTail.yDir);
        }  
        //move after changing the dir
        currentTail.move();
      }
    }
     
  //spawn 1 tailball if needed
    if(playerTail.size() < tailSize)
    {
     if(playerTail.size() == 0)
     {
       float reverseAngle = (playerAngle + 180) % 360;
       
       float[] spawnMult = direction(reverseAngle, 20);
       
       playerTail.add(new Tail(lastXPos + spawnMult[0], lastYPos + spawnMult[1], lastXDir, lastYDir));
     }
     else
     {
       //access last tail
       println(playerTail.size());
       Tail lastTail = playerTail.get(playerTail.size()-1);
       
       lastXPos = lastTail.xPos;
       lastYPos = lastTail.yPos;     
       lastXDir = lastTail.xDir;
       lastYDir = lastTail.yDir;
       
       float spawnXMult = lastXDir / 2.5 * 20;
       float spawnYMult = lastYDir / 2.5 * 20;
       
       playerTail.add(new Tail(lastXPos + spawnXMult, lastYPos + spawnYMult, lastXDir, lastYDir));
     }
    }
  }
}

class Tail {
 float xPos;
 float yPos;
 float xDir;
 float yDir;
 
 Tail(float xPos, float yPos, float xDir, float yDir) {
  this.xPos = xPos;
  this.yPos = yPos;
  this.xDir = xDir;
  this.yDir = yDir;
 }
 
 void setDir(float newXDir, float newYDir) 
 {
   xDir = newXDir;
   yDir = newYDir;
 }
 
 void move() 
 {
  xPos += xDir;
  yPos += yDir;
   
  GameGraph.ellipse(xPos, yPos, 40, 40); 
  playerAngle += 0.3;
 }
 
}

float[] direction(float angle, float radius) {
   float xMult = radius * cos(angle * PI / 180);
   float yMult = radius * sin(angle * PI / 180);

   float[] coordsMult = {xMult, yMult};

   return coordsMult;
  }

float reverseAngle(float angle) {
   if (angle <= 180) angle += 180;
   else if (angle >= 180) angle -= 180;
   else if (angle == 180) angle = 0;

   return angle;
  }

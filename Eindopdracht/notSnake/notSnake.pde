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
Boolean start = true;
boolean dead = false;

PGraphics GameGraph;

float playerHeadX;
float playerHeadY;

float playerAngle = 0;
int playerSlowness = 5;
int playerBallSize = 40;
int playerSpeed;

PlayerSnake Player;

void setup() {
  size(500, 500);
  background(25);
  
  //set up the draw graphic for the game
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
  drawGame();
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

//draw the game
void drawGame() {
  GameGraph.beginDraw();
  if(start == true) initialize(); //spawn the player first
  runGame();
  if(dead == true) gameOver();
  
  GameGraph.endDraw();
  image(GameGraph, 0, 0);
}

void initialize() {
  playerAngle = 0;
  playerHeadX = width/2;
  playerHeadY = height/2;
  playerSpeed = playerBallSize / playerSlowness;
  
  Player.spawn();
  start = false;
}

void runGame() {
  
}

void gameOver() {
  
}

class PlayerSnake {

  float lastXPos = 0;
  float lastYPos = 0;

  ArrayList<Points> playerPoints = new ArrayList<Points>(); //1 is tail end, last is movement point, second to last is head.
  ArrayList<PlayerBody> playerBody = new ArrayList<PlayerBody>();  //1 is head, last is tail end
  int tailSize = 5;
  
  void spawn() {
    tailSize = 5;
    
    //initialize Points
    float x = playerHeadX - tailSize * playerBallSize;
    float y = playerHeadY;
    float pointCounter = (tailSize + 2) * playerSlowness;
    println("x = " + x + " pointCounter = " + pointCounter);
    for (int i = 1; i <= pointCounter; i++)
    {
      playerPoints.add(new Points(x, y));
      x += playerSpeed;
      println(i);
    }
    
    //initialize player
    playerHead(); 
    int counter = 0;
    for(int i = playerPoints.size() - 6; i >= 0; i -= playerSlowness) //current problem: Distance needs to be half the size, need to make sure to exclude the head and movement point
    {
      Points currentPoint = playerPoints.get(i);
      playerBody.add(new PlayerBody(currentPoint.xPos, currentPoint.yPos));
      
      counter++;
      println("playerBody[" + counter + "]: xy: " + currentPoint.xPos + ", " + currentPoint.yPos);
      
      if(counter <= tailSize)  playerTailMethod(currentPoint.xPos, currentPoint.yPos);
    }
  }

  void playerHead() {
    GameGraph.ellipse(playerHeadX, playerHeadY, playerBallSize, playerBallSize);
  }
  
  void playerTailMethod(float x, float y) {
    GameGraph.ellipse(x, y, playerBallSize, playerBallSize);
  }
}

class Points {
 float xPos;
 float yPos;
 
 Points(float xPos, float yPos) {
  this.xPos = xPos;
  this.yPos = yPos;
 } 
}

class PlayerBody {
 float xPos;
 float yPos;
 
 PlayerBody(float xPos, float yPos) {
  this.xPos = xPos;
  this.yPos = yPos;
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

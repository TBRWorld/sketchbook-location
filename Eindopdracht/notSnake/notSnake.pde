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
float playerSpeed;

PlayerSnake Player;

void setup() {
  size(1200, 800);
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
    playerAngle += playerSpeed * 1.5;
    break;
  case 'a':
    playerAngle -= playerSpeed * 1.5;
    break;
  case 's':
    //playerAngle = 90;
    break;
  case 'w':
    //playerAngle = 270;
    break;
  }
}

//draw the game
void drawGame() {
  GameGraph.beginDraw();
  GameGraph.background(25);
  if(start == true) initialize(); //spawn the player first
  else runGame();
  if(dead == true) gameOver();
  
  GameGraph.endDraw();
  image(GameGraph, 0, 0);
}

void initialize() {
  playerAngle = 0;
  playerHeadX = width/2;
  playerHeadY = height/2;
  playerSpeed = playerBallSize / 1.5 / playerSlowness;
  
  Player.spawn();
  start = false;
}

void runGame() {
  //calculate new point
  Player.newPoints();
  //move all the values
  Player.move();
}

void gameOver() {
  
}

class PlayerSnake {
  ArrayList<Points> playerPoints = new ArrayList<Points>(); //1 is tail end, last is movement point, second to last is head.
  ArrayList<PlayerBody> playerBody = new ArrayList<PlayerBody>();  //1 is head, last is tail end
  int tailSize = 5;
  
  void spawn() {
    tailSize = 5;
    
    //initialize Points
    float x = playerHeadX - (tailSize + 1) * (playerBallSize / 2);
    float y = playerHeadY;
    float pointCounter = (tailSize + 2) * playerSlowness;
    println("x = " + x + " pointCounter = " + pointCounter);
    for (int i = 0; i <= pointCounter; i++)
    {
      playerPoints.add(new Points(x, y));
      println("i:" + i + " x:" + x);
      x += playerSpeed;
    }
    
    //initialize player 
    for(int i = playerPoints.size() - playerSlowness - 1; i >= 0; i -= playerSlowness)
    {      
      Points currentPoint = playerPoints.get(i);
      playerBody.add(new PlayerBody(currentPoint.xPos, currentPoint.yPos));
      
      println("playerBody[" + i + "]: xy: " + currentPoint.xPos + ", " + currentPoint.yPos);
      playerTail(currentPoint.xPos, currentPoint.yPos);
    }
    playerHead();
  }
  
  void newPoints() {
    //fetch last point
    Points currentPoint = playerPoints.get(playerPoints.size()-1);
    
    //fetch angle (currently testing circle
    //playerAngle += playerSpeed * 1.5;
    
    //use direction method using the angle
    float[] multiplier = direction(playerAngle, playerSpeed);
    
    //add it to the list
    playerPoints.add(new Points(currentPoint.xPos + multiplier[0], currentPoint.yPos + multiplier[1]));
    
    //remove old points
    trimOldPoints();
  }
  
  void trimOldPoints() {
  int maxPoints = (tailSize + 2) * playerSlowness + 1;

  while (playerPoints.size() > maxPoints) {
    playerPoints.remove(0);
  }
}
  
  void move() {
    for(int i = playerPoints.size() - 6; i >= 0; i -= playerSlowness)
    {
      Points currentPoint = playerPoints.get(i);
      playerBody.add(new PlayerBody(currentPoint.xPos, currentPoint.yPos));
      
      playerTail(currentPoint.xPos, currentPoint.yPos);
      if(i == playerPoints.size() - 6) { playerHeadX = currentPoint.xPos; playerHeadY = currentPoint.yPos; }
    }
    playerHead();
  }

  void playerHead() {
    GameGraph.fill(255, 1, 1);
    GameGraph.ellipse(playerHeadX, playerHeadY, playerBallSize, playerBallSize);
    GameGraph.fill(255, 255, 255);
  }
  
  void playerTail(float x, float y) {
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
   float x = radius * cos(angle * PI / 180);
   float y = radius * sin(angle * PI / 180);

   float[] coordsMult = {x, y};

   return coordsMult;
  }

float reverseAngle(float angle) {
   if (angle <= 180) angle += 180;
   else if (angle >= 180) angle -= 180;
   else if (angle == 180) angle = 0;

   return angle;
  }

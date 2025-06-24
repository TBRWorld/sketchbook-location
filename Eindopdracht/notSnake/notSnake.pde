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
 */
import java.util.Collections;
 
Boolean start = true;
boolean dead = false;

PGraphics GameGraph;

float playerHeadX;
float playerHeadY;

float playerAngle = 0;
int playerSlowness = 15;
int playerBallSize = 40;
float playerSpeed;
float angleLimit = 4;

PlayerSnake Player;

boolean fruitExists = false;
float[] fruitCoords = {0, 0};

void setup() {
  size(500, 500);
  background(25);
  //noCursor();
  
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
    Player.tailSize += 1;
   // start = true;
    break;
  case 'w':
    //Player.tailSize -= 1;
    start = true;
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
  playerSpeed = playerBallSize * 0.5 / playerSlowness;
  
  Player.spawn();
  start = false;
}

void runGame() {
  playerSpeed = playerBallSize * 0.5 / playerSlowness;
  //println("Distance: " + (playerSpeed * playerSlowness));
  //calculate playerAngle
  angleLogic();
  //calculate new point
  Player.newPoints();
  //move and draw
  Player.move();
  //fruit logic
  fruitLogic();
  //death logic
}

void gameOver() {
  
}

void angleLogic() {
  float targetAngle = degrees(atan2(mouseY - playerHeadY, mouseX - playerHeadX));

  // Normalize angles between 0–360
  targetAngle = (targetAngle + 360) % 360;
  playerAngle = (playerAngle + 360) % 360;

  // Compute shortest signed angle difference for the shortest rotation
  float angleDiff = targetAngle - playerAngle;
  if (angleDiff > 180) angleDiff -= 360;
  if (angleDiff < -180) angleDiff += 360;

  //limit rotation speed
  angleDiff = constrain(angleDiff, -angleLimit, angleLimit);

  // Apply rotation
  playerAngle += angleDiff;
}

int goalIndex = 0;
void fruitLogic() {
  //check if fruit exists
  if(!fruitExists)
  {
    fruitCoords = spawnFruit();
  }
  else
  {
  //else check if player is at fruit
  float dx = fruitCoords[0] - playerHeadX;
  float dy = fruitCoords[1] - playerHeadY;
  float distanceSq = dx * dx + dy * dy;
  
   if(distanceSq <= playerBallSize * playerBallSize)
   {
    //if player is at fruit adjust size
    Player.tailSize += 1;
    fruitExists = false;
   }
   
   int[] goals = {10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150};
   //if size is correct adjust maxAngle and playerSlowness
   if(Player.tailSize == goals[goalIndex])
   {
    playerSlowness--;
    playerSpeed = playerBallSize * 0.5 / playerSlowness;
    goalIndex++;
   }
  }
  GameGraph.fill(0, 255, 0);
  GameGraph.ellipse(fruitCoords[0], fruitCoords[1], playerBallSize / 2, playerBallSize / 2);
  GameGraph.fill(255, 255, 255);
}

float[] spawnFruit() {
  //get random coords
  float randomX = random(playerBallSize + 5, width - (playerBallSize + 5));
  float randomY = random(playerBallSize + 5, height - (playerBallSize + 5));
  
  float[] fruitCoord = {randomX, randomY};
  
  boolean insidePlayer = false;
  //check if coords are not in player
  for(int i = 0; i <= Player.playerBody.size() - 1; i++) 
  {
   PlayerBody currentBody = Player.playerBody.get(i); 
  float dx = randomX - currentBody.xPos;
  float dy = randomY - currentBody.yPos;
  float distanceSq = dx * dx + dy * dy;
  
  if(distanceSq <= playerBallSize * playerBallSize) insidePlayer = true;
  }
  
  //repeat if fruit is inside player
  if(insidePlayer) fruitCoord = spawnFruit();
  
  fruitExists = true;
  
  return fruitCoord;
}

class PlayerSnake {
  ArrayList<Points> playerPoints = new ArrayList<Points>(); //1 is tail end, last is movement point
  ArrayList<PlayerBody> playerBody = new ArrayList<PlayerBody>();  //1 is head, last is tail end
  int tailSize = 5;
  
  void spawn() {
    tailSize = 5;
    
    //initialize Points
    float x = playerHeadX - (tailSize + 1) * (playerBallSize / 2);
    float y = playerHeadY;
    float pointCounter = (tailSize + 1) * playerSlowness;
    for (int i = 0; i <= pointCounter; i++)
    {
      playerPoints.add(new Points(x, y));
      float[] offset = direction(playerAngle, playerSpeed);
      x += offset[0];
      y += offset[1];
    }
    
    //initialize player 
    for(int i = playerPoints.size() - playerSlowness - 1; i >= 0; i -= playerSlowness)
    {      
      Points currentPoint = playerPoints.get(i);
      playerBody.add(new PlayerBody(currentPoint.xPos, currentPoint.yPos, i));
      
      playerTail(currentPoint.xPos, currentPoint.yPos);
    }
    playerHead();
  }
  
  void newPoints() {
    //fetch last point
    Points currentPoint = playerPoints.get(playerPoints.size()-1);
    
    //use direction method using the angle
    float[] multiplier = direction(playerAngle, playerSpeed);
    
    //add it to the list
    playerPoints.add(new Points(currentPoint.xPos + multiplier[0], currentPoint.yPos + multiplier[1]));
    
    //remove old points
    trimOldPoints();
  }
  
  void trimOldPoints() {
  int maxPoints = (tailSize + 1) * playerSlowness + 1;

  while (playerPoints.size() > maxPoints) {
    playerPoints.remove(0);
  }
}
  
  void move() {
    //reorganize points if size does not match (new size)
    if(playerBody.size() <= tailSize)
    {
      changeSize();
    }
    for(int i = 0; i < playerPoints.size()-1; i++)
    {
     GameGraph.ellipse(playerPoints.get(i).xPos, playerPoints.get(i).yPos, 5, 5);
    }
    
        for (int i = 0; i <= tailSize; i++) {
        int pointIndex = playerBody.get(i).pointIndex;
        Points p = playerPoints.get(pointIndex);
               
        playerBody.add(new PlayerBody(p.xPos, p.yPos, pointIndex)); //xPos and yPos adjusted using pointIndex
      
        // draw
        if (i == 0) {
          playerHeadX = p.xPos;
          playerHeadY = p.yPos;
        }
      playerTail(p.xPos, p.yPos);
    }
    playerHead();
}

void changeSize() {
  ArrayList<PlayerBody> currentBody = new ArrayList<PlayerBody>();    
  currentBody.addAll(playerBody);
  playerBody.clear(); //clear for performance

  if (currentBody.size() < 2) return; // safety check

  // 1. Get pointIndexes of existing body (excluding head)
  int[] indexArray = new int[currentBody.size() - 1];
  for (int i = 1; i < currentBody.size(); i++) {
    indexArray[i - 1] = currentBody.get(i).pointIndex;
  }

  // 2. Calculate new headIndex
  int headIndex = playerPoints.size() - 1;

  // 3. Calculate delta between last two segments (used to determine delay spacing)
  int deltaIndex = currentBody.get(0).pointIndex - currentBody.get(1).pointIndex;

  // 4. Add existing body parts with new rotated indexes
  for (int i = currentBody.size() - 1; i >= 0; i--) {
    PlayerBody p = currentBody.get(i);
    int newIndex = currentBody.get(i).pointIndex;
    playerBody.add(new PlayerBody(p.xPos, p.yPos, newIndex));
  }

  // 5. Get tail tip position
  int tailPointIndex = currentBody.get(currentBody.size() - 1).pointIndex;
  float x = playerPoints.get(tailPointIndex).xPos;
  float y = playerPoints.get(tailPointIndex).yPos;

  // 6. Clone existing points and add new stationary ones at tail
  ArrayList<Points> newPoints = new ArrayList<Points>(playerPoints);
  for (int i = 0; i <= deltaIndex; i++) {
    newPoints.add(0, new Points(x, y)); // insert at tail (start of list)
  }

  // 7. Replace old points list
  playerPoints.clear();
  playerPoints.addAll(newPoints);

  // 8. Add new tail part at index 0 (tail side)
  Points newTail = playerPoints.get(0);
  playerBody.add(new PlayerBody(newTail.xPos, newTail.yPos, 0));

  currentBody.clear(); // cleanup
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
 int pointIndex;
 
 PlayerBody(float xPos, float yPos, int pointIndex) {
  this.xPos = xPos;
  this.yPos = yPos;
  this.pointIndex = pointIndex;
 } 
}

float[] direction(float angle, float radius) {
   float x = radius * cos(angle * PI / 180);
   float y = radius * sin(angle * PI / 180);

   float[] coordsMult = {x, y};

   return coordsMult;
  }

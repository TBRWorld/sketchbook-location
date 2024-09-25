/*
- render head X
- Make movement X
  2. Standard movement X
  2.1 Add framework for mouse movement X
  2.2 Move with wasd X
- Make everything a Pgraphic. X
- Add tail
- Add grow points
- Add window resize
- Add proper mouse movement.
- Add menu initialising thingy
- Add enemies
- Add dungeon
*/
boolean start = true;

PGraphics GameGraph;

float windowMidPointX = width / 2;
float windowMidPointY = height / 2;

boolean startLoading = true;

float playerHeadX;
float playerHeadY;

float angle = 0;

//maak floatList!
float[] playerTail;

void setup() {
  size(10, 10);
  background(25);
  boolean start = true;
  if(start==true) {
    windowMove(0,0);
    windowResize(500, 500);
  }
  
  GameGraph = createGraphics(displayWidth, displayHeight); GameGraph.beginDraw();
  GameGraph.background(25);
  GameGraph.endDraw();
  
  playerHeadX = width/2;
  playerHeadY = height/2;
}

void draw() {
  background(25);
  drawPlayer();
  
}

void keyPressed() {
 switch(key){
  case 'd':
  angle = 0;
  break;
  case 'a':
  angle = 180;
  break;
  case 's':
  angle = 90;
  break;
  case 'w':
  angle = 270;
  break;
 }
}


void drawPlayer() {
  //add angle later
  PlayerSnake Player = new PlayerSnake();
  Player.direction();
  Player.playerHead();
  image(GameGraph, 0, 0);
}




class PlayerSnake {
  
  
 // PlayerSnake(float angle) {
 //   this.angle = angle;
 // }
  boolean startTail = true;
  
  float xMult = 0;
  float yMult = 0;
  
  void playerHead() {
    GameGraph.beginDraw();
    GameGraph.background(25);
    GameGraph.ellipse(playerHeadX, playerHeadY, 70, 70);
    GameGraph.endDraw();
  }
  
  void direction() {
    xMult = 3.5 * cos(angle * PI / 180);
    yMult = 3.5 * sin(angle * PI / 180);   
    
    playerHeadX += xMult;
    playerHeadY += yMult;
  }
  
  void playerTail() {
    if (startTail == true)
    {
      
    }
    
    
  }
  
  
  
}

/*
- Start animation
  -2.1 Make it a Pgraphic and call image every time something needs to be changed.
     -2.2 Make sure it updates properly
  -3 Get it to switch to regular game after the animation is over
- render head
- Make movement
- Make everything a Pgraphic.
- Add tail
- Add grow points
- add a menu initializer
- Add window resize
- Add proper mouse movement.
- Add enemies
- Add dungeon
*/
boolean start = true;

float windowMidPointX = width / 2;
float windowMidPointY = height / 2;

boolean startLoading = true;



void setup() {
  size(10, 10);
  background(25);
  boolean start = true;
  if(start==true) {
    windowMove(0,0);
    windowResize(displayWidth - 200, displayHeight - 200);
  }
}

void draw() {
  startUp();
  
}
void startUp() {
  float windowMidPointX = width / 2;
  float windowMidPointY = height / 2;
  
  float titleSize = 100;
  
  int gameWindowMinX = displayWidth / 5;
  int gameWindowMinY = displayHeight / 5;
  
  boolean LoadingToGame = false;
  
  int i = 0;
  
  
  while(startLoading == true) {
    textAlign(CENTER); 
    textSize(titleSize);
    fill(255);
    stroke(255);
    
    text("NOT SNAKE", windowMidPointX, windowMidPointY);
    println(windowMidPointX, windowMidPointY, i);
    delay(200);
    i++;
    
    
    if(i == 30) {
      startLoading = false;
      LoadingToGame = true;
      //println("startLoading == false");
    }  
  }
  
  float titleSizeMath = titleSize;
  
  while(LoadingToGame == true) {
    //println("LoadingToGame aka resizing");
    background(25);
    boolean switch1 = false;
    boolean switch2 = false;
    
    float titleDivider = 1500 / titleSizeMath;
    titleSize -= titleDivider;
    textSize(titleSize);
    text("NOT SNAKE", windowMidPointX, windowMidPointY);
    
    float screenDividerX = 150 / (width + gameWindowMinX);
    float screenDividerY = 150 / (height + gameWindowMinY);
    delay(200);
    windowResize(int(width - screenDividerX), int(height - screenDividerY));
    
    if(switch1 && switch2) {
      windowResize(gameWindowMinX, gameWindowMinY);
      LoadingToGame = false;
    }
    else if(titleSize <= 0) {
      switch1 = true;
      println("switch1");
    }
    
    else if(width <= gameWindowMinX + screenDividerX || height <= gameWindowMinY + screenDividerY) {
      switch2 = true;
      println("switch2");
    }
  }
}

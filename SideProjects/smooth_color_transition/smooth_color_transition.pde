int x = 200;
int y = 200;
int sizeX = 100;
int sizeY = 100;

int colorSmoothness = 100;
int framerate = 60;

float[] startColor;
float[] endColor;

float[] randomColor;

float[] inputR;
float[] inputG;
float[] inputB;  
  
PGraphics box;

void setup() {
  size(500, 500);
  background(25, 25, 25);
  box = createGraphics(sizeX, sizeY);
}

void draw() {
    frameRate = framerate;
    
    randomColor[0] = random(0, 255);
    randomColor[1] = random(0, 255);
    randomColor[2] = random(0, 255);    
    randomColor[3] = random(0,255);
    randomColor[4] = random(0, 255);
    randomColor[5] = random(0, 255);
      
    byte i2 = 0;  
    boolean stageR = true;
    boolean stageG = false;
    boolean stageB = false;
    int i = 0;
    
    while(i != 6)
    {   
      
    if(stageR == true)
    inputR[i2] = randomColor[i];        
    
    if(stageG == true)
    inputG[i2] = randomColor[i];
    
    if(stageB == true)
    inputB[i2] = randomColor[i];
    
    if(i2 == 1)
      {
        if(stageR == true) 
        {
          stageR = false;
          stageG = true;
        }
        
        if(stageG == true)
        {
          stageG = false;
          stageB = true;
        }       
      }    
    }
    
    inputR = sort(inputR);
    inputG = sort(inputG);
    inputB = sort(inputB);
    
    inputR = reverse(inputR);
    inputG = reverse(inputG);
    inputB = reverse(inputB);
    
    float deltaR = dist(inputR[0], 0, inputR[1], 0);
    float deltaG = dist(inputG[0], 0, inputG[1], 0);
    float deltaB = dist(inputB[0], 0, inputB[1], 0);
    
    float randomR = randomColor[0];
    float randomG = randomColor[2];
    float randomB = randomColor[4];
      
    
    i = 0;
    while(i <= colorSmoothness)
    {
    deltaR /= colorSmoothness;
    deltaG /= colorSmoothness;
    deltaB /= colorSmoothness;      

    fill(randomR, randomG, randomB);
    rect(x, y, sizeX, sizeY);
    
    randomR += deltaR;
    randomG += deltaG;
    randomB += deltaB;
    }
}

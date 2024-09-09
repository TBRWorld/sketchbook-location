size(500, 500);
background(0, 0, 0);

float xStartPoint = 240;
float yStartPoint = 240;

int dotAmount = 2;
float radius = 50;

int dotMultiplier = dotAmount * 4;
float[] circle = new float[dotMultiplier];

//float degree = (360 / dotAmount) * 2;
//float theta = radians(degree);
float theta = 12.566371 / dotMultiplier;
println("theta: " + theta);
float thetaMultiplier = theta;
theta = 0;


int i = 0;
boolean loopKill = false;
while (loopKill == false)
{ 
  circle[i] = xStartPoint + radius * cos(theta);
  //println("circle1: " + circle[i]);
  i++;
  circle[i] = xStartPoint + radius * sin(theta);
  //println("circle2: " + circle[i]);
  i++;
  theta += thetaMultiplier;
  if(i == dotMultiplier)
  {
    loopKill = true;
  }  
}


fill(255, 255, 255);
rect(xStartPoint, yStartPoint, 10, 10);



i = 0;
loopKill = false;
int x1 = 0;
int x2 = 2;
int y1 = 1;
int y2 = 3;
int x = 0;
int y = 1;
while(loopKill == false)
{
  /*float randomRed = random(255);
  float randomBlue = random(150);
  stroke(int(randomRed), 255, int(randomBlue));*/
 
  stroke(100, 255, 100);
    
  println("i, x, y: " + i + " " + x1 + " " + y1 + " SECOND: " + x2 + " " + y2);
  line(circle[x1], circle[y1], circle[x2], circle[y2]);
  
  x1 += 2;
  y1 += 2;
  x2 += 2;
  y2 += 2;
  i++;  
  if(i == dotAmount * 2 - 1)
  {
    x2 -= 2;
    y2 -= 2;
    line(circle[0], circle[1], circle[x2], circle[y2]);
    loopKill = true;
  }
  
  
  /*
  rect(circle[x], circle[y], 5, 5);
  println(x);
  print(" " + circle[x]);
  x += 2;
  y += 2;
  i++;
  if(i == dotAmount)
  {
    loopKill = true;
  }*/
}

println("i, x, y: " + i + " " + x1 + " " + y1 + " SECOND: " + x2 + " " + y2);

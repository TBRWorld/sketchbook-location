int x = 10;
int y = 10;
boolean Switch = false;
while (Switch == false)
{
while (x <= 500) 
{
  float xRandom = random(9);
  float yRandom = random(9);
  
  int(xRandom);
  int(yRandom);
  
  x += xRandom;
  delay(5);
  y += yRandom;
   
   windowResize(x, y);
   println(x + " Addition " + y);
}
if (x >= 500)
 {
   while(x >= 20)
   {
   float xRandom = random(9);
   float yRandom = random(9);
   
   x -= xRandom;
   delay(5);
   y -= yRandom;
   
   if(x <= 10)
   {
     x = 10;
   }
   
    windowResize(x, y);
    println(x + " Subtraction " + y);
   }
 }
}

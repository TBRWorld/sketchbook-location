size(1000, 1000);
background(135, 206, 235);

//background
fill(56, 128, 4);
rect(0, 450, 1000, 450);
fill(255, 223, 34);
ellipse(800, 100, 250, 250);

//grass???
stroke(124, 252, 0);
int i = 0;
while(i != 3000)
{
  float x = random(0, 1000);
  float y = random(450, 900);
  line(x, y, x + 5, y - 20);
  i++;
}
noStroke();

//body
fill(192, 70, 87);
rect(250, 400, 500, 400);

//chimney
rect(300, 200, 100, 200);

//roof
fill(86, 55, 37);
triangle(250, 400, 750, 400, 500, 100);

//door
fill(193, 154, 107); //door brown
rect(550, 550, 125, 250);

//window
fill(15, 186, 216);
rect(300, 500, 200, 200);

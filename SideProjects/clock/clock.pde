boolean kill = false;
boolean secondPassed = true;
int currentSecond = 0;

while(kill == false){
int y = year();
int m = month();
int d = day();
int h = hour();
int min = minute();
int s = second();

if(secondPassed == true)
{
println("today is: " + y + "/" + m + "/" + d + " " + h + ":" + min + ":" + s);
secondPassed = false;
}

if(currentSecond != s)
{
  secondPassed = true;
}

currentSecond = s;

}

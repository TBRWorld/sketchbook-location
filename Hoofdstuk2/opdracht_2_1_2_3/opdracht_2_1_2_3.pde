size(500, 500);
background(0, 0, 0);
int textAllign = 10;

String blip = "bwop";
String blop = "blop";

fill(230, 0, 0);
text("Rood text", 10, textAllign);
textAllign += 15;
fill(0, 230, 0);
text("groen text", 10, textAllign);
textAllign += 15;
fill(0, 0, 230);
text("blauw text", 10, textAllign);
textAllign += 15;

//woooooaah :0
if(keyPressed == true)
{
}
print("ik denk.");
delay(2000);
print(".");

delay(2000);

if (blip == "bwop")
{
  blop = "blip";
  blip = "blop";
}

println(".");
print(blip + blop);

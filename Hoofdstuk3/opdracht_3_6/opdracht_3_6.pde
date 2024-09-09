size(1000, 600);
background(255, 255, 255);
noFill();
textAlign(CENTER);

stroke(0, 0, 0);
line(20, 30, 200, 30);

textSize(18);
fill(0, 0, 0);
text("Lijn", 100, 50);

noFill();
rect(25, 100, 300, 200);
fill(0, 0, 0);
text("Rechthoek", 175, 330);


stroke(0, 0, 0);
fill(128, 0, 128);
rect(350, 100, 300, 200);

fill(128, 0, 128);
ellipse(500, 200, 300, 200);
fill(0, 0, 0);
text("Gevulde rechthoek met ovaal", 500, 330);


stroke(0, 0, 0);
noFill();
ellipse(825, 200, 300, 200);

fill(128, 0, 128);

float startRad = radians(320);
float endRad = radians(360);
arc(825, 200, 300, 200, startRad, endRad);
fill(0, 0, 0);
text("Taartpunt met ovaal eromheen", 825, 330);




noFill();
rect(25, 350, 300, 200, 28);
fill(0, 0, 0);
text("Afgeronde rechthoek", 175, 580);

noStroke();
fill(128, 0, 128);
ellipse(500, 450, 300, 200);
fill(0, 0, 0);
text("Gevulde ovaal", 500, 580);

noFill();
stroke(0, 0, 0);
ellipse(825, 450, 150, 150);
fill(0, 0, 0);
text("Cirkel", 825, 580);

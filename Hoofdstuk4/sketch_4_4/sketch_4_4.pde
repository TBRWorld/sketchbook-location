size(500, 500);
background(25);

int pointAX = 100;
int pointAY = 100;
int pointBX = 245;
int pointBY = 352;

int[] values = {pointAX, pointAY, pointBX, pointBY};


stroke(255);
strokeWeight(5);
point(pointAX, pointAY);
point(pointBX, pointBY);

println("math.dist calculates distance between 2 points:");
println(dist(pointAX, pointAY, pointBX, pointBY));

println("math.max gives you the highest number:");
println(max(values));

println("math.noise gives a random value at specified coordinates using the classic perlin noise:");
println(noise(random(1000)));

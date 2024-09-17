float cijfer1 = 5.7;
float cijfer2 = 8.2;
boolean diploma = false;
boolean vrijstelling = false;
boolean cumlaude = false;

if(vrijstelling == true);
else if(cijfer1 >= 8 && cijfer2 >= 8){
  cumlaude = true;
}
else if(cijfer1 >= 5.5 && cijfer2 >= 5.5){
  diploma = true; 
}

if(diploma || vrijstelling || cumlaude){
  println("Gefeliciteerd");
}

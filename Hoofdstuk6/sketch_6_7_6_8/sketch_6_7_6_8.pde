float cijfer = 5.7;
boolean diploma = false;
boolean vrijstelling = false;
boolean cumlaude = false;

if(vrijstelling == true);
else if(cijfer >= 8){
  cumlaude = true;
}
else if(cijfer >= 5.5){
  diploma = true; 
}

if(diploma || vrijstelling || cumlaude){
  println("Gefeliciteerd");
}

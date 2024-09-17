int age = 17;
String ageismBracket = "";

if(age < 2) ageismBracket = "baby";
else if(age < 4) ageismBracket = "toddler";
else if(age < 12) ageismBracket = "child";
else if(age < 20) ageismBracket = "teenager";
else if(age < 25) ageismBracket = "adolescent";
else ageismBracket = "Adult";

println(ageismBracket);

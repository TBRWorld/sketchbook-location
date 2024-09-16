int gradeAmount = 3;

float[] grade = new float[gradeAmount];
float average = 0;

int i = 0;
while(i != gradeAmount)
{
  grade[i] = random(0, 10.1);
  float gradeCorrection = grade[i] % 0.1;
  grade[i] = grade[i] - gradeCorrection;
  average = average + grade[i];
  println(grade);
  i++;
}

average /= grade.length;

println(round(average));

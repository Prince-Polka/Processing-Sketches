
 


void type (String S){
  int len = S.length();
  S=S.toUpperCase();
  char temp;
  for(int i=0; i<len; i++){
    temp=S.charAt(i);
    robot.keyPress(temp);
    robot.keyRelease(temp);
  }
  robot.keyPress(' ');
    robot.keyRelease(' ');
}
 
import java.awt.*;
import java.awt.event.*;

Robot robot;
Point save_p;
 
void setup() {
  try { 
    robot = new Robot();
    robot.setAutoDelay(100);
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
}

void type (String S){
  int len = S.length();
  char temp;
  for(int i=0; i<len; i++){
    temp=S.charAt(i);
    robot.keyPress(temp);
    robot.keyRelease(temp);
  }
}
 
void draw() {
  if(frameCount%100==0){type("HELLO WORLD ");}
}
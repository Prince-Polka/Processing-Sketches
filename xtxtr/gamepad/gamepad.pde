/**
 Basic demonstration of using a gamepad.
 
 When this sketch runs it will try and find
 a game device that matches the configuration
 file 'gamepad' if it can't match this device
 then it will present you with a list of devices
 you might try and use.
 
 The chosen device requires 3 sliders and 2 button.
 */

import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

ControlIO control;
Configuration config;
ControlDevice gpad;

color highlight = #f4f4f4;
color dimmed = #cccccc;
int box;
PImage base, thumb;
Gesture right = new Gesture(360/24);

public void setup() {
  size(342,342,P2D);
  noStroke();
  box=min(width,height)/3;
  base = loadImage("base.png");
  thumb = loadImage("thumb.png");
  // Initialise the ControlIO
  control = ControlIO.getInstance(this);
  // Find a device that matches the configuration file
  gpad = control.getMatchedDevice("gamepad_eyes");
  if (gpad == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }
}

int [] turnx = {0,1,2,2,2,1,0,0};
int [] turny = {0,0,0,1,2,2,2,1};

int anim;
int animLen =2;

boolean light(int n, int A, int B){
B+=A;boolean a=n<B%8,b=n>=A,c=B>7;
return a&&b||(a||b)&&c;
}
float x,y;
void draw(){
  if(frameCount%30==0){anim ++; anim%=8;}
  x = gpad.getSlider("XPOS").getValue();
  y = gpad.getSlider("YPOS").getValue();
  right.thing(x,y);
  anim=right.nudge;
  animLen = right.rotary;
  for (int i=0; i<8; i++){
    int x=turnx[i]*box;
    int y=turny[i]*box;
    fill(light(i,anim,animLen)?highlight:dimmed);
    rect(x,y,box,box);
  }
  image(base,box,box);
  image(thumb,box*1.5-33+x*23.,box*1.5-33+y*23.);
}
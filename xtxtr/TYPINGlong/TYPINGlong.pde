import java.util.*;
import java.awt.*;
import java.awt.event.*;
import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;
//import java.util.Arrays.*;
word[] words;
Robot robot;
Point save_p;
ControlIO control;
Configuration config;
ControlDevice gpad;

color highlight = #f4f4f4;
color dimmed = #cccccc;
PImage base, thumb;
Gesture right = new Gesture(360/24);

String[] dictionary; 
String[] strings; 
String[] strNums; 
int dilen = 1000;
long[] nums;
String[] t9key = { "abcABC", "defDEF", "ghiGHI", "jklJKL", "mnoMNO", "pqrsPQRS", "tuvTUV", "wxyzWXYZ" };
String []empty={""};
String []lastTypedWord=empty;

int box = 100;
boolean mpa;
long typedword;
String all;
//String[] numface = { "new","abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz" };
String[] numface = { "abc", "def", "ghi", "jkl", " ", "mno", "pqrs", "tuv", "wxyz" };
int [] turnx = {0,1,2,2,2,1,0,0};
int [] turny = {0,0,0,1,2,2,2,1};

int nudge;

boolean light(int n, int A, int B){
B+=A;boolean a=n<B%8,b=n>=A,c=B>7;
return a&&b||(a||b)&&c;
}
float x,y;
void setup() {
  size(342,342,P2D);
  noStroke();
  textAlign(CENTER, CENTER);
  try { 
    robot = new Robot();
    robot.setAutoDelay(4);
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
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
  textSize(20);
  dictionary = loadStrings("dictionarylong.txt");
  dilen = dictionary.length;
  //diNum = new long[dilen];
  nums = new long[dilen];
  strings = new String[dilen];
  strNums = new String[dilen];
  words = new word[dilen];
  //make(); noLoop();
  loadwords();
}

void loadwords(){
  strings = loadStrings("numSortDict.txt");
  strNums = loadStrings("nums.txt");
  for (int w = 0; w<dilen; w++){
    //words[w] = new word (strings[w],Long.parseLong(nums[w]));
    nums[w] = Long.parseLong(strNums[w]);
  }
}

void draw(){
  background(0);
  
for (int i=0; i<9; i++){
  fill(230);
  rect(i%3*box,i/3*box,box,box);
  fill(0);
  text(numface[i],i%3*box+box/3,i/3*box+box/2);
}
/*fill(#00ff00);
all="";
for(int i=0; i<lastTypedWord.length;i++){
  all+=" "+lastTypedWord[i];
}
text(all,20,350);*/
/*if(mousePressed && !mpa){
  int temp = mouseX/box + mouseY/box*3;
  if(temp==0){
    typedword = 0;
    lastTypedWord = empty;
  }
  if(temp>=1 && temp<=8){
    typedword*=10;
    typedword+=temp;
    lastTypedWord = range(typedword);
  }
}*/

  x = gpad.getSlider("XPOS").getValue();
  y = gpad.getSlider("YPOS").getValue();
  right.thing(x,y);
  nudge=right.nudge;
  
  if(!right.home && right.delay>=20){
  int ltwlen = lastTypedWord.length;
  for (int i=1; i<=ltwlen; i++){
    int it = (i+nudge)%8;
    int x=turnx[it]*box;
    int y=turny[it]*box;
    fill(160);
    rect(x,y,box,box);
    fill(0);
    text(lastTypedWord[min(i,ltwlen-1)],x+box/2,y+box/2);
  }
  }
  /*for (int i=0; i<8; i++){
    int x=turnx[i]*box;
    int y=turny[i]*box;
    fill(light(i,anim,animLen)?highlight:dimmed);
    rect(x,y,box,box);
    fill(0);
    // slug.nudge
    //if(i>=slug.nudge && i<slug.nudge+ltwlen)
    text(lastTypedWord[min(i,ltwlen-1)],x,y);
  }*/
  image(base,box,box);
  image(thumb,box*1.5-33+x*23.,box*1.5-33+y*23.);

mpa = mousePressed;
}
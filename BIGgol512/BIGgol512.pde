import java.math.*;
BigInteger rule = new BigInteger("0"); 
golbutton[] button = new golbutton[512];
int numof[] = {1, 8, 28, 56, 70, 56, 28, 8, 1};
int indexes[] = {0, 1, 9, 37, 93, 163, 219, 247, 255, 256};
PImage viewport;
int array[] = { 2, 5, -2, 6, -3, 8, 0, -7, -9, 4 };
int[]sortedrules = new int[512];
boolean codeArray[] = new boolean[9];
int box=10;
int swap;
int xyz=100;
boolean[][][] fields = new boolean[2][xyz][xyz];
int cellsize=5;
color store;
 
boolean mpa,leftclick,rightclick; //mouse variables
void checkmouse(){
  if(!mpa && mousePressed){
   leftclick=mouseButton==LEFT;
   rightclick=mouseButton==RIGHT;
 }
 else { leftclick=rightclick=false; } 
}
//int[] stay ={2};
//int[] born = {3};
//int[] born = {3};
boolean closerThan(int len, int x0, int y0, int x1, int y1){
  float delx = x0-x1;
  float dely = y0-y1;
  delx*=delx;
  dely*=dely;
  len*=len;
  return delx+dely < len;
}
color fillcolor;
void setup(){
  size(1150,650);
  noStroke();
  noSmooth();
  viewport = createImage(xyz,xyz,ARGB);
  viewport.loadPixels();
  loadPixels();
  sortrules();
  for (int i=0; i<256; i++){ 
    button[i] = new golbutton(i);
  }
  conway();
  //setrow(2,2);
  //setrow(3,3);
  
}
void draw(){
 checkmouse();
  for (int i=0; i<256; i++){
    button[i].show();
 }
 for (int y=0;y<xyz;y++){
  for (int x=0;x<xyz;x++){
  fields[(swap+1)%2][x][y]=judge(0,x,y);
  //fill(judge(0,x,y)?#000000:#ffffff);
  viewport.pixels[x+y*xyz]=store;
  //rect(x*cellsize,y*cellsize,cellsize,cellsize);
  }}
  viewport.updatePixels();
  image(viewport,0,0,xyz*cellsize,xyz*cellsize);
  if(swap==0){swap=1;}else{swap=0;}
 mpa=mousePressed;
}
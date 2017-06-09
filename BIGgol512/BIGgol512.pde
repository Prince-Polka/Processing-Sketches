import java.math.*;
BigInteger rule; 
golbutton[] button = new golbutton[512];
PImage viewport;
 
boolean codeArray[] = new boolean[9];
int box=10;
int swap;
int xyz=100;
boolean[][][] fields = new boolean[2][xyz][xyz];
int cellsize=5;
color store;
 
boolean mpa,click; //mouse variable
int[] stay ={2};
int[] born = {3};
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
  size(1790,650);
  noStroke();
  noSmooth();
  viewport = createImage(xyz,xyz,ARGB);
  viewport.loadPixels();
  loadPixels();
  setgol(stay,born);
  for (int i=0; i<512; i++){ 
    button[i] = new golbutton(i);
  }
}
void draw(){
 click=(!mpa && mousePressed);
  for (int i=0; i<512; i++){
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
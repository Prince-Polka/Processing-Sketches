/*

float X,Y;
float D;
float A;
int prevA;
int rot;
void setup(){
  size(400,400);
}
//char[][] letters = {{'a','b','c'},{'d','e','f'},{'g','h','i'},{'j','k','l'},{'m','n','o'},{p,q,r,s},{t,u,v},{w,x,y,z}};
void update(){
X = map(mouseX,0,width,-1,1);
Y = map(mouseY,0,height,-1,1);
A=atan2(X,Y);
A=(427.5-degrees(A+PI))%360;
A=int(map(A,0,360,1,9));
rot=int(A-prevA);
prevA=int(A);
D= abs(X*X+Y*Y);

}

void draw(){
  background(0);
  
  update();
  if(r){println(rot);}
  //println(X + " " +Y);
  float start = PI+QUARTER_PI/2;
  for (int i=0; i<8; i++){
    fill(i*30);
 arc(width/2,height/2,width,height,start+i*QUARTER_PI,start+(i+1)*QUARTER_PI,CHORD); 
  }
  fill(#ff0000);
  ellipse(width/2,height/2,20,20);
  ellipse(mouseX,mouseY,20,20);
}

*/
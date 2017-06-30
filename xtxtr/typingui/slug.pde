class Slug{
float angle_out;
float angle_in;
int steps;
float step;
int firstselected;
int selected;
int pselected;
int selectionLength;
float dsq;
boolean home; // joystick at middle
boolean phome;
int [] foo = {1,2,3,5,8,7,6,4}; 
long wordtyping;
Slug( float STEP){
  angle_out=0; step=STEP;
}

void slug(float x,float y){
  dsq=x*x+y*y;
  home = dsq<0.11 ? true : dsq>0.44 ? false : home;
  if(!home){
  angle_in=(405+22.5-degrees(atan2(x,y)+PI))%360;
  if(step<abs(angle_out-angle_in)){
    angle_out=angle_in;
    selected = int(angle_out/step/3);
  }
  
  if(phome){
    firstselected = pselected = selected;
    selectionLength=1;
  }
  int temp = selected - pselected;
  if(abs(temp)>=6){temp+=selected>pselected?-8:8;}
  selectionLength += temp;
  
  } else {selected = -1; selectionLength=0;}
  if(home && !phome && firstselected>=0){
    wordtyping*=10;
    wordtyping+=foo[firstselected];
    println(wordtyping);
  }
  pselected=selected;
  phome=home;
  //println(selected + " " + firstselected);
}
}
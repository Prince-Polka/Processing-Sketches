long x;
float xorshiftstar(int start, int end, int steps){
  long mod,star;
  mod=abs(start-end)*1000;
  x ^= x >> 12;
  x ^= x << 25;
  x ^= x >> 27;
  star = x * 0x2545F4914F6CDD1DL;
  return min(start,end)+abs( star % mod )/1000.;
}

PVector project(PVector A, PVector B, PVector C) {
    PVector L = PVector.sub(B,A);
    float K = PVector.dot( PVector.sub(C,A) , L);
          K/= PVector.dot(L,L);
    return PVector.add(A,PVector.mult(L,K));
 }
 
boolean side( PVector A, PVector B, PVector C) {
    return PVector.dot(new PVector(B.y-A.y,A.x-B.x),PVector.sub(C,A))>=0.;
}

boolean sectline(PVector A, PVector B, PVector C, PVector D){
    return side(A,B,C) != side(A,B,D) && side(C,D,A) != side(C,D,B);
}

boolean pit(PVector A, PVector B, PVector C, PVector D){
    if ( side(A,B,D) != side(B,C,D) ) {return false;}
    return side(B,C,D)==side(C,A,D);
}

boolean pip(PVector point, PVector... poly){
  int len = poly.length;
  int sects=0;
  PVector far = new PVector(9999,9999);
  for(int i=0; i<len; i++){
    sects+=sectline(point,far,poly[i],poly[(i+1)%len])?1:0;
  }
  return sects%2==1;
}

PVector a,b,c,d;

void setup(){
  size(500,500);
  noFill();
  x = System.nanoTime();
}
boolean tri;
void draw(){
  background(0);
  a = new PVector(xorshiftstar(0,width,1),xorshiftstar(0,height,1));
  b = new PVector(xorshiftstar(0,width,1),xorshiftstar(0,height,1));
  c = new PVector(xorshiftstar(0,width,1),xorshiftstar(0,height,1));
  d = new PVector(xorshiftstar(0,width,1),xorshiftstar(0,height,1));
  
  
  if(tri){
    if(!pit(a,b,c,d)){
     stroke(#ff0000);
    } else { stroke(#00ff00); noLoop();}
    
  triangle(a.x,a.y,b.x,b.y,c.x,c.y);
  ellipse(d.x,d.y,5,5);
  } else {
    if(sectline(a,b,c,d)){
    stroke(#ff0000);
    noLoop();
  } else { stroke(#00ff00); }
  line(a.x,a.y,b.x,b.y);
  line(c.x,c.y,d.x,d.y);
  }
  
}
void keyPressed(){
  if(key == 't' || key == 'T'){
    tri = true;
  } else {tri = false;}
  loop();
}

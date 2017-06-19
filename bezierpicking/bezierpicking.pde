import peasy.*;
PeasyCam camera;
boolean mpa, click;
color mouseC,pickcolor = #ffff00; //
PVector UL,UR,BL,BR, mouse, pmouse,camposV;
float ratio,hovdis;
 PImage crosshair;
 pickable [] knot;
 int H,Npickables=0;
float [] node0,node1,node2,node3;
float [][] nodes;
void rotateZ3D (float theta) {
    float sin_t = sin(theta);
    float cos_t = cos(theta);
    for (int n=0; n<nodes.length; n++) {
        float [] node = nodes[n];
        float x = node[0];
        float y = node[1];
        node[0] = x * cos_t - y * sin_t;
        node[1] = y * cos_t + x * sin_t;
    }
};
void rotateY3D (float theta) {
    float sin_t = sin(theta);
    float cos_t = cos(theta);
    for (int n=0; n<nodes.length; n++) {
        float [] node = nodes[n];
        float x = node[0];
        float z = node[2];
        node[0] = x * cos_t - z * sin_t;
        node[2] = z * cos_t + x * sin_t;
    }
};
void rotateX3D (float theta) {
    float sin_t = sin(theta);
    float cos_t = cos(theta);
    for (int n=0; n<nodes.length; n++) {
        float [] node = nodes[n];
        float y = node[1];
        float z = node[2];
        node[1] = y * cos_t - z * sin_t;
        node[2] = z * cos_t + y * sin_t;
    }
};
class pickable {
  color id;
  PVector pos;
  boolean hover;
  boolean follow;
  pickable(){
    id=pickcolor+Npickables++;
    pos = new PVector(-250+Npickables*100,0,0);
  }
  void go(){
    hover = (mouseC==id);
    if(hover && click){follow=true;}
    if(!mousePressed){follow=false;}
    if (follow){pos=mouse.copy();}
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    stroke(id);
    sphere(20);
    popMatrix();
  }
}
PVector project(PVector A, PVector B, PVector C) {
    PVector L = PVector.sub(B,A);
    float K = PVector.dot( PVector.sub(C,A) , L);
          K/= PVector.dot(L,L);
    return PVector.add(A,PVector.mult(L,K));
 }
void bezier2(PVector knot0, PVector knot1,PVector knot2,PVector knot3){
      bezier2( knot0.x,knot0.y,knot0.z,
               knot1.x,knot1.y,knot1.z,
               knot2.x,knot2.y, knot2.z,
               knot3.x,knot3.y, knot3.z );
    }
void bezier2( float x0,float y0,float z0,
              float x1,float y1,float z1,
              float x2,float y2, float z2,
              float x3,float y3, float z3 ) {
  // measure chord lengths
  float c1,c2,c3;
        c1=dist( x0,y0,z0, x1,y1,z1 );
        c2=dist( x1,y1,z1, x2,y2,z2 );
        c3=dist( x2,y2,z2, x3,y3,z3 );
  float t1,t2;
        t1=c1/(c1+c2+c3);
        t2=(c1+c2)/(c1+c2+c3);
  float b0,b1,b2,b3;
  b0 = pow( 1 - t1 , 3 );
  b1 = pow( 1 - t2 , 3);
  b2 = pow( t1 , 3 );
  b3 = pow( t2 , 3 );
  // make curve segment lengths proportional to chord lengths
  float a,b,c,d;
  a = t1 * ( 1 - t1 ) * ( 1 - t1 ) * 3;
  b = ( 1 - t1 ) * t1 * t1 * 3;
  c = t2 * ( 1 - t2 ) * ( 1 - t2 ) * 3;
  d = ( 1 - t2 ) * t2 *t2 *3;
  float e,f,g,h,i,j;
  e = x1 - ( x0 * b0 ) - ( x3 * b2 );
  f = x2 - ( x0 * b1 ) - ( x3 * b3 );
  g = y1 - ( y0 * b0 ) - ( y3 * b2 );
  h = y2 - ( y0 * b1 ) - ( y3 * b3 );
  i = z1 - ( z0 * b0 ) - ( z3 * b2 );
  j = z2 - ( z0 * b1 ) - ( z3 * b3 );
  x2 = ( e - a / c * f ) / ( b - a * d / c);
  x1 = ( e - ( b * x2 ) ) / a;
  y2 = ( g - a / c * h ) / ( b - a * d / c);
  y1 = ( g - ( b * y2 ) ) / a;
  z2 = ( i - a / c * j ) / ( b - a * d / c);
  z1 = ( i - ( b * z2 ) ) / a;
  bezier(x0,y0,z0, x1,y1,z1, x2,y2,z2, x3,y3,z3);
}
void setup(){
  size(400,400,P3D);
  bezierDetail(50);
  ratio = (float)width/height;
  camera = new PeasyCam(this, 400);
  camera.setCenterDragHandler(null);
  knot = new pickable [] {new pickable(),new pickable(),new pickable(),new pickable()};
}
void draw() {
  click=(!mpa && mousePressed);
  float DX = (float)camera.getDistance()*width/695.*ratio;
  float DY = (float)camera.getDistance()*height/695.*ratio;
  node0 = new float [] {-DX, -DY,  0};
  node1 = new float [] { DX, -DY,  0};
  node2 = new float [] {-DX,  DY,  0};
  node3 = new float [] { DX,  DY,  0};
  nodes = new float [][] {node0, node1, node2, node3};
    background(100);
    float[] rot; 
    rot = camera.getRotations();
    float yaw=rot[0], pitch=rot[1], roll=rot[2];
    rotateZ3D(roll);
    rotateY3D(-pitch);
    rotateX3D(yaw);
    float [] camposF=camera.getPosition();
    camposV = new PVector (camposF[0],camposF[1],camposF[2]);
    UL = new PVector (node0[0],node0[1],node0[2]);
    UR = new PVector (node1[0],node1[1],node1[2]);
    BL = new PVector (node2[0],node2[1],node2[2]);
    BR = new PVector (node3[0],node3[1],node3[2]);
    UL = PVector.lerp(camposV,UL,hovdis);
    UR = PVector.lerp(camposV,UR,hovdis);
    BL = PVector.lerp(camposV,BL,hovdis);
    BR = PVector.lerp(camposV,BR,hovdis);
    noFill();
    stroke(10);
    bezier2(knot[0].pos,knot[1].pos,knot[2].pos,knot[3].pos);
    for(pickable i : knot){ i.go(); }
    stroke(#ff0000);
    line(0,0,0,100,0,0);
    stroke(#00ff00);
    line(0,0,0,0,100,0);
    stroke(#0000ff);
    line(0,0,0,0,0,100);
    float xlerp = (float)mouseX/(float)width;
    float ylerp = (float)mouseY/(float)height;
    mouse = PVector.lerp (
    PVector.lerp(UL,UR,xlerp) ,
    PVector.lerp(BL,BR,xlerp) , ylerp);
    strokeWeight(5);
    mouseC = get(mouseX,mouseY);
    if(mouseC >= pickcolor && mouseC <= pickcolor+Npickables){
    if(click){camera.setActive(false);}
    if(H != mouseC-pickcolor){
    H = mouseC-pickcolor;
    PVector origin = new PVector( 0,0,0);
    hovdis = PVector.dist( camposV , project(origin,camposV,knot[H].pos) ); 
    hovdis/=(float)camera.getDistance();
    }
  }
    else if(mpa && !mousePressed){camera.setActive(true);}
    pmouse=mouse.copy();
    mpa=mousePressed;
}

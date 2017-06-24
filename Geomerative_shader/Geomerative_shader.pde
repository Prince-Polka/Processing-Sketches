import geomerative.*;
PShader font;
PGraphics text;
float[] verts;
//import Mesh.*;

// Declare the objects we are going to use, so that they are accesible from setup() and from draw()
RFont f;
RShape grp;
RPoint[] points;


void setup(){
  // Initilaize the sketch
  size(600,400,P2D);
  frameRate(24);
  font = loadShader("font.glsl");
  verts = new float[1848];
  text = createGraphics(width,height,P2D);
  text.shader(font);

  // Choice of colors
  background(255);
  fill(255,102,0);
  stroke(0);
  
  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);
  
  //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
  grp = RG.getText("Hello World!", "FreeSans.ttf", 72, CENTER);

  // Enable smoothing
  //smooth();
}

void gpudraw(){
if(points != null){
  int len = points.length;
  for(int i=0; i<len; i++){
      verts[i*2]= points[i].x+200;
      verts[i*2+1]= -points[i].y+200;
  }
  verts[len*2]=-1.0;
  verts[len*2+1]=-1.0;
  verts[len*2+2]=-1.0;
  verts[len*2+3]=-1.0;
  font.set("poly",verts,2);
  
  text.beginDraw();
  text.rect(0, 0, width, height);
  text.endDraw();
  
  image(text,0,0);
  }
}

void cpudraw(){
 if(points != null){
    noFill();
    stroke(0,200,0);
    RPoint lastskip = points[0];
    int skipindex=0;
    int len = points.length;
    boolean jum =false;
    for(int i=0; i<len; i++){
      RPoint A = points[i];
      RPoint B = points[(i+1)%len];
      RPoint C = points[(i+2)%len];
      if(i>skipindex && A.x == lastskip.x && A.y == lastskip.y){
        lastskip=C;
        skipindex=i+2;
        i++;
      } else{
      line(A.x+200,A.y+200.,B.x+200,B.y+200);
    }
}}}

void draw(){
  // Clean frame
  background(255);
  
  // Set the origin to draw in the middle of the sketch
  //translate(width/2, 3*height/4);
  
  // Get the points on the curve's shape
  RG.setPolygonizer(RG.UNIFORMSTEP);
  points = grp.getPoints();
  gpudraw();
}
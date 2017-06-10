class shadershapes{
  float [] verts; // vec2 2D vertices/points
  float[] fills; // vec4 normalized argb
  float[] strokes; 
  int[] shapeType; // int id's for what shape to draw
  int vertIndex;
  int shapeIndex;
  PGraphics view;
  PShader glshapes;
  
  shadershapes(){
    view = createGraphics(width,height,P2D);
    glshapes = loadShader("shapes.glsl");
    view.shader(glshapes);
  }
  void fill(color input){
    // will probably break on other color format?
    int temp = shapeIndex*4;
    fills[temp  ] = ((input >> 16) & 0xFF)/255.;
    fills[temp+1] = ((input >>  8) & 0xFF)/255.;
    fills[temp+2] = ( input        & 0xFF)/255.;
    fills[temp+3] = ((input >> 24) & 0xFF)/255.;
  }
  
  void stroke(color input){
    
  }
  
  void beginDraw(){
  // clear arrays and counters
  verts = new float[400];
  fills = new float[100];
  strokes = new float[100];
  shapeType = new int[25];
  vertIndex=shapeIndex=0;
  }
  void endDraw(){
    //send arrays to, and render them in shader
    image(view,0,0);
    
  }
  void rectMode(int i){ }
  void rect(){
  }
  
  void line(float A,float B, float C, float D){
    verts[vertIndex  ]=A;
    verts[vertIndex+1]=B;
    verts[vertIndex+2]=C;
    verts[vertIndex+3]=D;
    
    shapeType[shapeIndex]=1;
  }

  void bezier(float A,float B, float C, float D, float E,float F, float G, float H){
    verts[vertIndex  ]=A;
    verts[vertIndex+1]=B;
    verts[vertIndex+2]=C;
    verts[vertIndex+3]=D;
    verts[vertIndex+4]=E;
    verts[vertIndex+5]=F;
    verts[vertIndex+6]=G;
    verts[vertIndex+7]=H;
    
    fills[shapeIndex] = getGraphics().fillColor;
    shapeType[shapeIndex]=2;
    
    vertIndex+=8;
    shapeIndex++;
  }
  
}
shadershapes gl = new shadershapes();

void setup(){}
void draw(){
  gl.beginDraw();
  gl.fill();
  gl.stroke();+
  gl.ellipse();
  gl.endDraw();
}

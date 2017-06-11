class shaderShapes{
  int[] shapeType; // int id's for what shape to draw
  float[] shapes; // mat4 , 16 floats per shape PMatrix ??
  int shapeIndex;
  PGraphics view;
  PShader glshapes;
  
  shaderShapes(){
    view = createGraphics(width,height,P2D);
    glshapes = loadShader("shapes.glsl");
    view.shader(glshapes);
  }
  
  void background(color C){}
  void strokeWeight(float W){}
  void stroke(color C){}
  void ellipse(float X, float Y, float W, float H){}
  void triangle(float X, float Y, float W, float H){}
  void quad(float A,float B, float C, float D, float E,float F, float G, float H){}
  
  void fill(color input){
    // will probably break on other color format?
    int temp = shapeIndex*16+8;
    shapes[temp  ] = ((input >> 16) & 0xFF)/255.;
    shapes[temp+1] = ((input >>  8) & 0xFF)/255.;
    shapes[temp+2] = ( input        & 0xFF)/255.;
    shapes[temp+3] = ((input >> 24) & 0xFF)/255.;
  }
  
  
  
  void beginDraw(){
  // clear arrays and counters
  shapeType = new int[25];
  shapes = new float[16*25];
  }
  void endDraw(){
    //send arrays to, and render them in shader
    image(view,0,0);
    glshapes.set("shapes", shapes, 16);
  }
  void rectMode(int i){ }
  void rect(){
  }
  
  void line(float A,float B, float C, float D){
    int temp = shapeIndex*16;
    shapes[temp  ]=A;
    shapes[temp+1]=B;
    shapes[temp+2]=C;
    shapes[temp+3]=D;
    
    shapeType[shapeIndex]=1;
  }

  void bezier(float A,float B, float C, float D, float E,float F, float G, float H){
    int temp = shapeIndex*16;
    shapes[temp  ]=A;
    shapes[temp+1]=B;
    shapes[temp+2]=C;
    shapes[temp+3]=D;
    shapes[temp+4]=E;
    shapes[temp+5]=F;
    shapes[temp+6]=G;
    shapes[temp+7]=H;
    
    shapes[temp+8] = getGraphics().fillColor;
    shapeType[shapeIndex]=2;
    
    shapeIndex++;
  }
  
}
void vec4(color... colors){
  int num = colors.length;
  float [] rgba = new float [num*4];
  //int j=0;
  for (int i=0,j=0;i<num;i++,j+=4){
    rgba[j  ] = ((colors[i] >> 16) & 0xFF)/255.;
    rgba[j+1] = ((colors[i] >>  8) & 0xFF)/255.;
    rgba[j+2] = ( colors[i]        & 0xFF)/255.;
    rgba[j+3] = ((colors[i] >> 24) & 0xFF)/255.;
  }
  //radgrad.set("u_num", num);
  //radgrad.set("u_colors", rgba, 4);
}

class shaderbezier{
  float [] bez;
  color[] fills = new color[25];
  int[] shapeId = new int[25];
  int bezIndex;
  int shapeIndex;
  PGraphics view;
  PShader glshapes;
  
  shaderbezier(){
    view = createGraphics(width,height,P2D);
    glshapes = loadShader("shapes.glsl");
    view.shader(glshapes);
  }
  void beginDraw(){
  bez = new float[200]; 
  bezIndex=0;
  }
  void endDraw(){
    //bla bla bla
    image(view,0,0);
    
  }
  void sendcolors(){
    
  }
  void bezier(float A,float B, float C, float D, float E,float F, float G, float H){
    bez[bezIndex  ]=A;
    bez[bezIndex+1]=B;
    bez[bezIndex+2]=C;
    bez[bezIndex+3]=D;
    bez[bezIndex+4]=E;
    bez[bezIndex+5]=F;
    bez[bezIndex+6]=G;
    bez[bezIndex+7]=H;
    
    fills[shapeIndex] = getGraphics().fillColor;
    shapeId[shapeIndex]=2;
    
    bezIndex+=8;
    shapeIndex++;
  }
  
}
shaderbezier gl = new shaderbezier();

void setup(){}
void draw(){
gl.bezier(1,1,1,1,1,1,1,1);
}
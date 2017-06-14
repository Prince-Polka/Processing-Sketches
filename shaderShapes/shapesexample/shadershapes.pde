class shaderShapes {
  int[] commandType; // what shape or command the shader shall do
  float[] AB; // AB first two verts of shape, OR one color
  float[] CD; // additional verts for some shapes
  int commandIndex;
  PGraphics view;
  PShader glshapes;
  int bezierDetail=21;
  int rectmode;
  matrixStack stack;
  boolean noFill;
  boolean noStroke;
  boolean flipY = true; // shader has flipped Y-coordinate compared to proccssing 

  shaderShapes() {
    view = createGraphics(width, height, P2D);
    glshapes = loadShader("shapes.glsl");
    view.shader(glshapes);
    stack = new matrixStack();
  }

  void bezierDetail(float input) {
    bezierDetail=max(30, min(3, ((int(input)+2)/3)*3));
  }
  void beginDraw() {
    // clear arrays and counters
    commandType = new int[924];
    commandIndex=0;
    noStroke = false;
    noFill = false;
    rectmode = CORNER;
    resetMatrix();
    AB = new float[4*924];
    CD = new float[4*924];
  }
  void endDraw() {
    //send arrays to, and render them in shader
    glshapes.set("command", commandType);
    glshapes.set("AB", AB, 4);
    glshapes.set("CD", CD, 4);
    view.beginDraw();
    //view.shader(glshapes);
    view.rect(0, 0, width, height);
    view.endDraw();
    image(view, 0, 0);
  }


  //float flip(float in) {return flipY?(height - in):in;}
  /*float rotateOrigin(float X, float Y, float angle) {
    float sina =sin(angle);
    float cosa =cos(angle);
    X*=cosa;
    X-=sina*Y;
    Y*=sina;
    Y+=cosa*Y;
    return X;
  }*/


  void resetMatrix() {
    stack.reset();
  }
  void pushMatrix() {
    stack.push();
  }
  void popMatrix() {
    stack.pop();
  }
  void translate(float x, float y) {
    stack.translate(x,y);
  }
  void rotate(float angle) {
    // swith sign necessary?
    stack.rotate(angle);
  }
  void scale(float s) {
    stack.scale(s, s);
  }
  void scale(float sx, float sy) {
    stack.scale(sx,sy);
  }
  void noStroke(){
    noStroke = true;
  }
  void noFill(){
    noStroke = true;
  }

  /* puts values into the value array sent to shader */
  private void ABCD(float... input) {
    for (int i=0; i<input.length; i++) {
      int temp = commandIndex*4+i;
      float val = input[i];
      if (i<4) {
        AB[temp]=val;
      } else if (i<8) {
        CD[temp-4]=val;
      }
    }
  }
  /* separate function for vectors needing transformation matrix applied*/
  private void ABCDt(float... input) {
    int il = input.length;
    float[] temp = new float[il];
    for (int i=0; i<il; i++) {
      float val = input[i];
      if (i%2 ==0 ) {
        val = stack.X(val,input[i+1]);
      }
      if (i%2 ==1 ) {
        val = stack.Y(input[i-1],val);
        if ( flipY ) { val = height -val; }
      }
      temp[i]=val;
    }
    ABCD(temp);
  }
  
  
  void rectMode(int mode) {
    rectmode = mode;
  }

  void strokeWeight(float W) {
    // noStroke = false; ?
    commandType[commandIndex] = 8;
    ABCD(W);
    commandIndex++;
  }

  void ellipseold(float X, float Y, float W, float H) {
    commandType[commandIndex] = 3;
    ABCD(X, Y, W, H);
    commandIndex++;
  }

  void ellipse(float A, float B, float W, float H) {
    commandType[commandIndex] = 3;
    W=(W*W)/4.;
    H=(H*H)/4.;
    // retrive rotation from current matrix
    float E = stack.current.m00;
    float F = stack.current.m10;
    A = stack.current.multX(A,B);
    B = stack.current.multY(A,B);
    if(flipY) { B=height-B; }
    //ABCDt(A, B);
    ABCD(A,B,W, H, E, F);
    commandIndex++;
  }

  void triangle(float A, float B, float C, float D, float E, float F) {
    if(!noFill){
    commandType[commandIndex] = 4;
    ABCDt(A, B, C, D, E, F);
    commandIndex++;
    }
    if(!noStroke){
    triline(A, B, C, D, E, F, A, B);
    }
  }
  void quad(float A, float B, float C, float D, float E, float F, float G, float H) {
    if(!noFill){
    commandType[commandIndex] = 5;
    ABCDt(A, B, C, D, E, F, G, H);
    commandIndex++;
    }
    if(!noStroke){
    triline(A, B, C, D, E, F, G, H);
    line(G, H, A, B);
    }
  }
  
  private void rect90(float A, float B, float E, float F){
    if(!noFill){
    commandType[commandIndex] = 10;
    ABCDt(A,B,E,F);
    commandIndex++;
    }
    if(!noStroke){
    triline(A,B,E,B,E,F,A,F);
    line(A,F,A,B);
    }
    
  }
  
  /* rectMode supported */
  /* rounded corners not supported */
  void rect(float a, float b, float c, float d) {
    float A,B,C,D,E,F,G,H,x,y;
    if(rectmode == CORNERS){
      A = G = a;
      B = D = b;
      C = E = c;
      F = H = d;
    }
    else{
      if(rectmode == CORNER){
        x=a;
        y=b;
      }
      else{
        if(rectmode == RADIUS){
          c*=2; 
          d*=2;
        }
          x=a-c/2; 
          y=b-d/2;
      }
    A = C = E = G = x;
    B = D = F = H = y;
    C +=c;
    E +=c;
    F +=d;
    H +=d;
    }
    // if close enough to 90 degree angle
    if( abs (stack.getangle()%HALF_PI)<0.01){
      rect90(A,B,E,F);
    }
    else {
    quad(A,B,C,D,E,F,G,H);
    }
  }
  
  void line(float A, float B, float C, float D) {
    commandType[commandIndex]=1;
    ABCDt(A, B, C, D);
    commandIndex++;
  }

  void bezier(float A, float B, float C, float D, float E, float F, float G, float H) {
    /* will call triline */
    float tempx, tempy, div, temp1;
    int temp2;
    float [] results = new float[8];
    div=1./bezierDetail;
    for ( int i=0; i<bezierDetail; i++) {
      temp1=div*i;
      temp2 = (i%4)*2;
      tempx = bezierPoint(A, C, E, G, temp1);
      tempy = bezierPoint(B, D, F, H, temp1);
      results[temp2]=tempx; 
      results[temp2+1]=tempy;
      if (i%4==3) { 
        triline(results);
      }
    }
  }

  void fill(color input) {
    noFill=false;
    commandType[commandIndex] = 6;
    addcolor(input);
    commandIndex++;
  }
  void stroke(color input) {
    // should work like fill
    noStroke = false;
    commandType[commandIndex] = 7;
    addcolor(input);
    commandIndex++;
  }
  void background(color input) {
    commandType[commandIndex] = 9;
    addcolor(input);
    commandIndex++;
  }
  private void triline(float[] FA) {
    triline(FA[0], FA[1], FA[2], FA[3], FA[4], FA[5], FA[6], FA[7]);
  }
  private void triline(float A, float B, float C, float D, float E, float F, float G, float H) {
    commandType[commandIndex]=2;
    ABCDt(A, B, C, D, E, F, G, H);
    commandIndex++;
  }
  private void addcolor(color input) {
    float [] vec = rgba2vec4(input);
    ABCD (vec[0], vec[1], vec[2], vec[3]);
  }

  private float[] rgba2vec4(color input) {
    float[] output = new float[4];
    output[0] = ((input >> 16) & 255)/255.;
    output[1] = ((input >>  8) & 255)/255.;
    output[2] = ( input        & 255)/255.;
    output[3] = ((input >> 24) & 255)/255.;
    return output;
  }
}
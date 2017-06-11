class shaderShapes {
  int[] commandType; // int id's for what shape to draw
  float[] AB; // AB first two verts of shape, OR one color
  float[] CD; // additional verts for some shapes
  int commandIndex;
  PGraphics view;
  PShader glshapes;

  shaderShapes() {
    view = createGraphics(width, height, P2D);
    glshapes = loadShader("shapes.glsl");
    view.shader(glshapes);
  }

  /* lots of setting AB and CD array going on */
  
  void ABCD(float... input){
    for (int i=0; i<input.length;i++){
      if (i<=4){
      AB[commandIndex*4+i]=input[i];
      }
      else if (i<=8){
      CD[commandIndex*4+i-4]=input[i];
      }
    }
  }
   
   void background(color C){}
   void strokeWeight(float W){}
   
   void ellipse(float X, float Y, float W, float H){}
   void triangle(float A, float B, float C){
   commandType[commandIndex] = 4;
   int temp = commandIndex*4;
   ABCD(A,B,C);
   commandIndex++;
   }
   void quad(float A,float B, float C, float D, float E,float F, float G, float H){}
   void rectMode(int i){
   // does nothing
   }
   void rect(){
   // does nothing
   }
   
   void fill(color input){
   commandType[commandIndex] = 6;
   addcolor(input);
   commandIndex++;
   }
   void stroke(color input){
   // should work like fill
   commandType[commandIndex] = 7;
   addcolor(input);
   commandIndex++;
   }
   void addcolor(color input){
   int temp = commandIndex*4;
   float [] vec = rgba2vec4(input);
   ABCD (vec[0],vec[1],vec[1],vec[2]);
   }
   // shall convert rgba int to 4 normalized floats
   // will probably break on other color format?
   float[] rgba2vec4(color input){
   float[] output = new float[4];
   output[0] = ((input >> 16) & 0xFF)/255.;
   output[1] = ((input >>  8) & 0xFF)/255.;
   output[2] = ( input        & 0xFF)/255.;
   output[3] = ((input >> 24) & 0xFF)/255.;
   return output;
   }
   
   
   
   void beginDraw(){
   // clear arrays and counters
   commandType = new int[25];
   AB = new float[4*25];
   CD = new float[4*25];
   }
   void endDraw(){
   //send arrays to, and render them in shader
   image(view,0,0);
   glshapes.set("AB", AB, 4);
   glshapes.set("CD", CD, 4);
   }
   
   
   void line(float A,float B, float C, float D){
   int temp = commandIndex*16;
   commandType[commandIndex]=1;
   ABCD(A,B,C,D);
   commandIndex++;
   }
   
  /* bezier should for performance make lines in this class */
  void bezier(float A, float B, float C, float D, float E, float F, float G, float H) {
    int temp = commandIndex*16;
    commandType[commandIndex]=2;
    AB[temp  ]=A;
    AB[temp+1]=B;
    AB[temp+2]=C;
    AB[temp+3]=D;

    CD[temp+4]=E;
    CD[temp+5]=F;
    CD[temp+6]=G;
    CD[temp+7]=H;

    commandIndex++;
  }
}
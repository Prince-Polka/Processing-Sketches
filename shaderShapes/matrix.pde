class matrixStack{
  ArrayList <PMatrix2D> stack;
  int index;
  PMatrix2D current;
  matrixStack(){
    reset();
  }
  float X (float x, float y){
    return current.multX(x,y);
  }
  float Y (float x, float y){
    return current.multY(x,y);
  }
  void push(){
    stack.add(current);
    index++;
  }
  float getangle(){
    return atan2(current.m10,current.m00);
  }
  float gettransX(){
    return cos(current.m02);
  }
  float gettransY(){
    return current.m12;
  }
  void pop(){
    if( index > 0 ){
    current=stack.get(index);
    stack.remove(index);
    index--;
    }
  }
  void reset(){
    stack = new ArrayList <PMatrix2D>();
    current = new PMatrix2D();
    index=0;
  }
  void rotate(float angle){
    //current.reset();
    current.rotate(angle);
  }
  void scale(float s){
    current.scale(s);
  }
  void scale(float sx, float sy){
    current.scale(sx,sy);
  }
  void translate(float tx, float ty){
   current.translate(tx,ty);
  }
}
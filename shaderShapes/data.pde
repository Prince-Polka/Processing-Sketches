/*
might not be worthwhile implementing PVector-like classes  
could slow down performance if not implemented right  
but could make it more intuitive when switching between the glsl and java language  
would still be different since theres no operator overloading though but leaving it here in case
*/
/*class vec2{
       float x,       y;
  vec2(float X, float Y){
           x=X;     y=Y;}
  vec2 copy(){return new vec2(x,y);}
}
vec2 vec2(float x, float y){ return new vec2(x,y); }*/
class vec4{
       float x,       y,       z,       w;
  vec4(float X, float Y, float Z, float W){
           x=X;     y=Y;     z=Z;     w=W;}
  vec4 copy(){return new vec4(x,y,z,w);}
  int rgba(){ return color(map(x,0,1,0,255),map(y,0,1,0,255),map(z,0,1,0,255),map(w,0,1,0,255)); }
}

vec4 vec4(float x, float y, float z, float w){return new vec4(x,y,z,w);}

/* 
code beneath from forum.Processing.org/two/discussion/22209/ 
*/

static public class vec2 {
  float x, y;
 
  public vec2() {
  }
 
  public vec2(final float n) {
    set(n, n);
  }
 
  public vec2(final float x, final float y) {
    set(x, y);
  }
 
  public vec2(final PVector v) {
    set(v.x, v.y);
  }
 
  public vec2 set(final float px, final float py) {
    x = px;
    y = py;
    return this;
  }
 
  public vec2 add(final float px, final float py) {
    return set(x + px, y + py);
  }
  
  public vec2 add(final vec2 p) {
    return set(x + p.x, y + p.y);
  }
 
  public vec2 sub(final float px, final float py) {
    return set(x - px, y - py);
  }
 
  public vec2 mult(final float n) {
    return set(x * n, y * n);
  }
  public vec2 mult(final vec2 n) {
    return set(x * n.x, y * n.y);
  }
 
  public vec2 div(final float n) {
    return set(x / n, y / n);
  }
 
  public float magSqD() {
    return x*x + y*y;
  }
 
  public float magD() {
    return sqrt(magSqD());
  }
 
  public float distSqD(final PVector v) {
    final float dx = x - v.x, dy = y - v.y;
    return dx*dx + dy*dy;
  }
 
  public float distD(final PVector v) {
    return sqrt(distSqD(v));
  }
 
  public float dotD(final PVector v) {
    return x*v.x + y*v.y;
  }
 
  public float dotD(final float px, final float py) {
    return x*px + y*py;
  }
 
  public float headingD() {
    return atan2(y, x);
  }
}

vec2 vec2(final float x, final float y){ return new vec2(x,y); }
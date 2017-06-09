#ifdef GL_ES
precision mediump float;
//precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 u_resolution;
uniform vec4 u_paint;
uniform ivec4 u_mouse;
uniform ivec2 u_compare[32];
uniform ivec2 u_transform[32];
uniform ivec2 u_ires;
float my_neighbours_red;
ivec2 mytransform;
ivec2 intpos;
vec4 mycolor;
vec4 buff;
vec4 white;
int mylayer;
bool algo;

varying vec4 vertColor;
//varying vec4 vertTexCoord;

float myred;
int c;
uniform float step;

void main () {
  algo=true;
  white = vec4(1.0);
  ivec2 intpos = ivec2(floor(gl_FragCoord.xy));
  intpos.y=int(ceil(u_resolution.y)-intpos.y-1);
  if (u_mouse.z!=0) { // mousepressed
    ivec2 vdit = u_mouse.xy-intpos.xy;
    vdit*=vdit;
    int fdit = vdit.x+vdit.y;
    if (fdit < u_mouse.w+1) {
      algo=false;
      if (u_mouse.z==1) { // left mouse button
        mycolor = u_paint;
      } else if (u_mouse.z==2) { // right mouse button
        mycolor = white;
      }
    }
  }
  if (algo) {
    intpos.y=int(ceil(u_resolution.y)-intpos.y-1);
    mylayer = ((intpos.x%2==0)?0:8)+((intpos.y%2==0)?0:16);
    myred=buff.r;
    buff = texelFetch(texture,intpos,0);
    c=0;
if (mylayer >= 0) {
for (int i=0; i<8; i++) {
  float my_neighbours_red =
  texelFetch(texture, intpos+u_compare[mylayer+i],0).r;
  if (myred<my_neighbours_red) {c++;}
}
for (int i=0; i<9; i++) {
if (i==c) { mytransform = u_transform[mylayer+i]; break; }
}
mycolor = texelFetch(texture, intpos+mytransform,0);
}

}
  gl_FragColor = mycolor;
}

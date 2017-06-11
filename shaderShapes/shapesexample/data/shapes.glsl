#ifdef GL_ES
precision mediump float;
#endif
vec4 u_colors[2];
vec4 background = vec4(0.268,0.286,0.370,1.000);
int u_num;
uniform vec2 u_mouse;

/*
This shader under construction will render shapes sent from processing
a class in processing, ( not yet implemented ) will handle the communication seamlessly
syntax shall similar to to PGraphics, but only include simple shapes like line() , not text()
example
void draw(){
.beginDraw();
.background();
.fill();
.stroke();
.line();
.ellipse();
.quad();
.endDraw();
}
*/

// this array shall contain all shape data neeeded to render, and supplied from processing

int command[13]; // to be renamed command, will include fill() etc not just shapes
/*
will not use mat4 shape[], instead twp vec4's , fill and stroke will have their own command/command in the loop
/* shapes will be stored in arrays, will contain some superfluous data as glsl is not good with lookup
   textures COULD be more efficent but not surely, so ill go with arrays */
mat4 shape[5]; // first rows [0] and [1] is vec2 verts A B C D ,  row [2] fill, row [3] stroke

vec4 AB[13];
vec4 CD[13];

//

// distance things
float distroot(in vec2 A, in vec2 B) {
    A=abs(A-B);
    A*=A;
return sqrt(A.x+A.y);
}
float dist(in vec2 A, in vec2 B) {
float p,q,r,s;
A=abs(A-B);
p = max(A.x,A.y);
q = min(A.x,A.y);
r=q/p;
r*=r;
s=r/(4.0+r);
p+=2.0*s*p;
return p;
}
bool closerThan(float len, vec2 A, vec2 B){
  vec2 del = A-B;
  del*=del;
  len*=len;
  return del.x+del.y < len;
}

// shapes

bool ellipse(vec2 pos, vec2 size) {
    vec2 e = ( gl_FragCoord.xy - pos) / size;
    e*=e;
    if( e.x+e.y < 1. ) { return true; }
    return false;
}

// quad uses triangle which uses side

bool side( vec2 A, vec2 B) {
    return dot(vec2(B.y-A.y,A.x-B.x),gl_FragCoord.xy-A)>=0.;
}
bool triangle(vec2 A, vec2 B, vec2 C) {
 bool a = side(A,B);
 bool b = side(B,C);
 if(a!=b){return false;}
 bool c = side(C,A);
 return b==c;
}

bool quad(vec2 A, vec2 B, vec2 C, vec2 D){
   return triangle(A,B,C) || triangle(C,D,A);
}

//line uses project and constrain
vec2 project(vec2 A, vec2 B, vec2 C){
    vec2 L = B-A;
    float K = dot(C-A,L);
    K/= dot(L,L);
    return A+L*K;
}

vec2 constrain (vec2 amt, vec2 low, vec2 high){
    //return clamp(amt,min(low,high),max(low,high));
    return min(max(amt,min(low,high)),max(low,high));
}

bool line (vec2 A, vec2 B, float thickness){
    vec2 C = gl_FragCoord.xy;
    vec2 D = constrain(project(A,B,C),A,B);
    if ( closerThan ( thickness,C,D) ) {
        return true;
    }
    //return false;
}

// bezier uses bezierpoifilnt and line

vec2 bezierPoint(vec2 A, vec2 B, vec2 C, vec2 D, float T) {
    vec2 ABm = mix(A,B,T);
    vec2 BCm = mix(B,C,T);
    vec2 CDm = mix(C,D,T);
    return mix( mix(ABm,BCm,T) , mix(BCm,CDm,T) , T );
}

bool bezier(vec2 A, vec2 B, vec2 C, vec2 D){
    float I=0.0;
    vec2 prev=bezierPoint(A,B,C,D,0.);
    vec2 cur;
for (int i=0; i<10; i++){
    I+=0.1;
    cur = bezierPoint(A,B,C,D,I);
    if( line(prev,cur,10.) ){
        return true;
    }
    prev =cur;
}
    return false;
}

/*
shall have blendmodes for alpha transparency etc
ID's for processing Blendmodes  ( might not be completely implemented )
0 REPLACE
1 BLEND
2 ADD
8 LIGHTEST
16 DARKEST
32 DIFFERENCE
64 EXLUSION
128 MULTIPLY
256 SCREEN
*/

vec4 blend(vec4 background , vec4 foreground, int mode){
    // REPLACE
    if (mode == 0){
        return foreground;
    }
    //BLEND
    if (mode == 1){
        //return ;
    }
    //ADD
    if (mode == 2){
        return background+foreground; //MIGHT NOT BE RIGHT
    }
    //LIGHTEST
    if (mode == 8){
        //return ;
    }
    //DARKEST
    if (mode == 16){
        //return ;
    }
    //DIFFERNCE
    if (mode == 32){
        //return;
    }
    //EXCLUSION
    if (mode == 64){
        //return ;
    }
    //MULTIPLY
    if (mode == 128){
        //return ;
    }
    //SCREEN
    if (mode == 256){
        //return ;
    }

}

void main() {
    vec4 frag=background;

    // the arrays shall be set by processing but setting manually while coding

    //array of commands
    command[ 0] = 9; //background
    command[ 1] = 8; //strokeWeight
    command[ 2] = 7; //stroke
    command[ 3] = 1; //line
    command[ 4] = 7; //stroke
    command[ 5] = 2; //bezier
    command[ 6] = 6; //fill
    command[ 7] = 3; //ellipse
    command[ 8] = 6; //fill
    command[ 9] = 4; //triangle
    command[10] = 6; //fill
    command[11] = 5; //quad
    command[12] = 0; // no shape stop
    // two vec4 arrays , no more mat4
    AB[0]= vec4(0.268,0.286,0.370,1.000);
    //strokeWeight
    AB[1].x=10.;
    //stroke
    AB[2]=vec4(0.805,0.703,0.332,1.000);
    //line
    AB[3]=vec4(40.,380.,200.,340.);
    //stroke
    AB[4]=vec4(0.805,0.703,0.332,1.000);
    //bezier
    AB[5]=vec4(27.,225.,95.,208.);
    CD[5]=vec4(240.,300.,320.,100.);
    //fill
    AB[6]=vec4(0.264,0.625,0.307,1.000);
    //ellipse
    AB[7]=vec4(400.,300.,100.,200);
    //fill
    AB[8]=vec4(0.194,0.165,0.730,1.000);
    //triangle
    AB[9]=vec4(200.,200.,10.,10.);
    CD[9]=vec4(350.,100.,0.,0.);
    //fill
    AB[10]=vec4(0.730,0.623,0.544,1.000);
    //quad
    AB[11]=vec4(30.,490.,310.,480.);
    CD[11]=vec4(450.,300.,150.,390.);

    // main function shall loop through arrays to render fragments from array data, from background to forefront

    // ABCD shorthand for 4 first verts from mat4 , fill 3rd row, stroke 4th row
    vec2 A,B,C,D;
    vec4 fill,stroke;
    float strokeWeight;
    for (int i=0; i<12; i++){
        if(command[i]==0){ break; } // stops loop , no more commands left in arrray
    A=AB[i].xy;
    B=AB[i].zw;
    C=CD[i].xy;
    D=CD[i].zw;
        if(command[i]==1){
            if ( line(A,B,10.) ){
                frag = blend (frag, stroke, 0);
            }
        }
        if(command[i]==2){
            if ( bezier(A,B,C,D) ){
                frag = blend (frag, stroke, 0);
            }
        }
        if(command[i]==3){
            if ( ellipse(A,B) ){
                frag = blend (frag, fill, 0);
            }
        }
        if(command[i]==4){
            if ( triangle(A,B,C) ){
                frag = blend (frag, fill, 0);
            }
        }
        if(command[i]==5){
            if ( quad(A,B,C,D) ){
                frag = blend (frag, fill, 0);
            }
        }
        if(command[i]==6){
            fill = AB[i];
        }
        if(command[i]==7){
            stroke = AB[i];
        }
        if(command[i]==8){
            strokeWeight = AB[i].x;
        }
        if(command[i]==9){
          frag = blend (frag, AB[i], 0);
        }
    }

gl_FragColor = frag;
}

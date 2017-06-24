#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform vec2 poly[924];


bool side( vec2 A, vec2 B, vec2 C) {
    return dot(vec2(B.y-A.y,A.x-B.x),C-A)>=0.;
}

bool sectline(vec2 A, vec2 B, vec2 C, vec2 D){
    return side(A,B,C) != side(A,B,D) && side(C,D,A) != side(C,D,B);
}

// now going to try find nearest distance from point to polygon outline
vec2 project(vec2 A, vec2 B, vec2 C){
    vec2 L = B-A;
    float K = dot(C-A,L);
    K/= dot(L,L);
    return A+L*K;
}


vec2 constrain (vec2 amt, vec2 low, vec2 high){
    return min(max(amt,min(low,high)),max(low,high));
}


// polygon without smoothing

bool polygonbool(){
    vec2 A = gl_FragCoord.xy;
    vec2 B =  vec2(4999.,4999.);

    // implementing "skipping line"
    vec2 lastskip = poly[0];
    int skipindex=0;

    int num = 0;
    for (int i=0; i<924; i++){
      //return true;
      if(poly[i].x+poly[i].y<=-2.0){break;}
      //if(poly[i].x+poly[i].y<=-4.0){continue;}
        if(i>skipindex && poly[i]==lastskip){ i++; skipindex=i+1; lastskip=poly[i+1]; }

        else if ( sectline(A,B,poly[i],poly[i+1]) ){
            num++;
        }


    }
    if (num==1 || num == 3 || num == 5){return true;}
    return false;
}

float di(vec2 A, vec2 B){
  vec2 del = A-B;
  del*=del;
    float di = del.x+del.y ;
    if(di > 1.0){return 1000.;}
    return sqrt(di);
}

float polygonfloat(vec2 A){
    vec2 left,right ;
    bool leftsect,rightsect;
    // will need two "lightsources" one on left and right
    left.y=right.y=A.y;
    left.x = -1000.;
    right.x = 1000.;
    int num = 0;
    float near=10000.; // starts high will go down in loop
    float nearcon=10000.; // starts high will go down in loop
    for (int i=0; i<21; i++){
        leftsect=sectline(A,left,poly[i],poly[i+1]);
        rightsect=sectline(A,right,poly[i],poly[i+1]);
        if (  leftsect || rightsect ){
            if(leftsect){num++;}
            vec2 closepoint = constrain(project(poly[i],poly[i+1],A),poly[i],poly[i+1]);
            nearcon = di(A,closepoint);
            if(nearcon<near){near=nearcon;}
        }
    }
    if (num==1 || num == 3 || num == 5){
        return 0.;
    }
    if(near<=1.){
        return near;
    }
    return 1.0;

}

float r,g,b;
void main() {
    r=g=b=1.0;
    vec2 green = gl_FragCoord.xy;
    vec2 red = vec2(green.x-0.3333,green.y);
    vec2 blue = vec2(green.x+0.3333,green.y);


    if(polygonbool()){r=g=b=0.0;}

    /*r=polygonfloat(red);
    g=polygonfloat(green);
    b=polygonfloat(blue);*/

    gl_FragColor = vec4(r,g,b,1.0);
}

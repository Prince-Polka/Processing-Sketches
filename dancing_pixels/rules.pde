int sts (int l){ return ((l%4==0)?0:2)*((floor(l/4)%2==1)?-1:1);}
int[] pbox(int n, int layer){
int px,py,xt,yt; xt=yt=0;
  px=(layer%2==0)?0:1;
  py=(layer<=1)?0:1;
  if(n<=7){ xt=px==0?1:-1;}
  else    { yt=py==0?1:-1;}
  xt += sts(n);
  yt += sts(n+2);
  return new int[]{xt,yt};
} 
int[] pboxresult = new int[2];
int[]compare={
-1,2,1,2,3,2,-1,0,3,0,-1,-2,1,-2,3,-2,
-2,3,0,3,2,3,-2,1,2,1,-2,-1,0,-1,2,-1,
-2,1,0,1,2,1,-2,-1,2,-1,-2,-3,0,-3,2,-3,
-3,2,-1,2,1,2,-3,0,1,0,-3,-2,-1,-2,1,-2
};
int[] transform = new int[64];
long RULE;
/*long randomlong(){
  long result = floor(random(0,65536));
  for(int i=0;i<3;i++){
  result<<= 24;
  result+=floor(random(0,16777216));
  }
  return result;
}*/
long random24bit(){return floor(random(0,16777216));}
void transform_update(){
for(int i=0; i<4; i++){
//RULE = randomlong();
RULE = random24bit();
for(int j=0; j<8; j++){
pboxresult = pbox(int((RULE>>(j*3))&7),i);
transform[i*16+j*2  ]=pboxresult[0];
transform[i*16+j*2+1]=pboxresult[1];
}}}
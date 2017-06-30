color highlight = #f4f4f4;
color dimmed = #cccccc;
int box;
PImage base, thumb;
Slug slug = new Slug(360/24);
void setup(){
  size(342,342,P2D);
  noStroke();
  box=min(width,height)/3;
  base = loadImage("base.png");
  thumb = loadImage("thumb.png");
}
int [] turnx = {0,1,2,2,2,1,0,0};
int [] turny = {0,0,0,1,2,2,2,1};

int anim;
int animLen =2;

boolean light(int n, int A, int B){
B+=A;boolean a=n<B%8,b=n>=A,c=B>7;
return a&&b||(a||b)&&c;
}
float x,y;
void draw(){
  if(frameCount%30==0){anim ++; anim%=8;}
  x = map(mouseX,0,width,-1,1);
  y = map(mouseY,0,height,-1,1);
  slug.slug(x,y);
  anim=slug.firstselected;
  animLen = slug.selectionLength;
  for (int i=0; i<8; i++){
    int x=turnx[i]*box;
    int y=turny[i]*box;
    fill(light(i,anim,animLen)?highlight:dimmed);
    rect(x,y,box,box);
  }
  image(base,box,box);
  image(thumb,box*1.5-33,box*1.5-33);
}
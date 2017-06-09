PGraphics canvas;
PShader my_shader;
boolean renew;
float[] paint; 
int mouse_button;
int mouse_speed;
int musx=10;
int musy=10;
boolean playing;
import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;
AudioPlayer song;
FFT fft;
void setup()
{
  fullScreen(P2D);
  minim = new Minim(this);
  song = minim.loadFile("butterbob.mp3", 512);
  fft = new FFT(song.bufferSize(), song.sampleRate());
  paint = new float[4]; paint[3]=1.0;
  my_shader = loadShader("automata.glsl");
  // init buffer
  canvas = createGraphics(width*2,height*2, P2D);
}
void keyPressed(){
  if(!playing && key =='p'){
    song.play();
  playing=true;
  } else{new_rule();}
}
void new_rule(){
  renew=true;
  transform_update();
  my_shader.set("u_resolution",width+.0,height+.0); // s
  my_shader.set("u_compare", compare, 2);
  my_shader.set("u_transform", transform, 2);
  my_shader.set("u_paint",paint,4); 
  canvas.beginDraw();
  //canvas.image(loadImage("background_maybe?"), 0, 0, canvas.width, canvas.height);
  canvas.endDraw();
}
int circol;
int prev_circol;
void draw()
{
  background(255);
  if (frameCount == 1)
  {  new_rule();  }
  if(frameCount%225==0){new_rule(); prev_circol=circol; circol = int(random(#000000,#ffffff));}
  for(int i=0; i<3; i++){paint[i]=random(1);}
  if(mousePressed){ mouse_button = ( mouseButton == LEFT ) ? 1 : 2;}
  else { mouse_button = 0; }
  mouse_speed = int(sq(mouseX-pmouseX)+sq(mouseY-pmouseY));
  my_shader.set("u_paint",paint,4); 
  my_shader.set("u_mouse",mouseX*2,mouseY*2-height,mouse_button,mouse_speed);
  canvas.beginDraw();
  canvas.filter(my_shader);
  canvas.endDraw();
  image(canvas, 0, 0, width, height);
  if(playing){
  fft.forward(song.mix);
  canvas.beginDraw();
  canvas.fill(lerpColor(prev_circol,circol,(frameCount%400)/401.));
  canvas.noStroke();
  canvas.beginShape();
  float posx, posy, step;
  for(int i = 0; i < (song.left.size() - 1); i++)
  {
    step = map(i,0,song.left.size(),-PI,PI);
    posx=width+sin(step)*(5+song.left.get(i))*width/20;
    posy=height+cos(step)*(5+song.left.get(i))*height/20;
    canvas.vertex(posx,posy);
  }
  canvas.endShape(CLOSE);
  canvas.noStroke();
  canvas.fill(int(random(255)));
  canvas.beginShape();
  for(int i = 0; i < fft.specSize(); i++)
  {
    step = map(i,0,fft.specSize(),-PI,PI);
    posx=width+sin(step)*fft.getBand(i)*i*width/1250;
    posy=height+cos(step)*fft.getBand(i)*i*height/1250;
    canvas.vertex(posx,posy);
  }
  canvas.endShape(CLOSE);
  canvas.endDraw();
  }
}
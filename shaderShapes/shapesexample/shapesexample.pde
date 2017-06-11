shaderShapes gl;
void setup(){
  size(500,500,P2D);
  gl = new shaderShapes();
}
void draw(){
  gl.beginDraw();
  gl.background(#222222);
  gl.strokeWeight(10.0);
  gl.stroke(#abcdef);
  gl.line(10,10,40,40);
  gl.stroke(#ff2ba3);
  gl.bezier(10,10,40,140,400,100,300,400);
  gl.fill(#48bfa3);
  gl.ellipse(300,300,30,30);
  gl.fill(#11ff11);
  gl.triangle(10,10,40,140,200,100);
  gl.fill(#fedcba);
  gl.quad(10,10,100,10,100,100,10,100);
  gl.endDraw();
}

void keyPressed(){ gl.flipY=!gl.flipY; }
shaderShapes gl;
float rot;
void setup(){
  size(500,500,P2D);
  gl = new shaderShapes();
}
void draw(){
  /*
  gl.pushMatrix();
  gl.translate();
  gl.rotate();
  gl.scale();
  gl.popMatrix();
  gl.noStroke();
  gl.noFill();
  */
  rot+=0.01;
  rot%=TWO_PI;
  gl.beginDraw();
  
  //gl.translate(mouseX,mouseY);
  //gl.rotate(rot);
  //gl.translate(mouseX,mouseY);
  //println(mouseX + " " + gl.stack.gettransX());
  gl.background(#222222);
  gl.strokeWeight(10.0);
  gl.stroke(#abcdef);
  gl.line(10,10,40,40);
  gl.stroke(#ff2ba3);
  //gl.bezier(210,210,240,440,400,100,300,400);
  gl.fill(#48bfa3);
  gl.ellipse(200,200,130,130);
  gl.rectMode(RADIUS);
  gl.rect(mouseX,mouseY,50,100);
  gl.fill(#11ff11);
  //gl.triangle(110,110,140,240,320,210);
  gl.ellipse(300,300,330,130);
  
  
  
  gl.fill(#fedcba);
  gl.quad(10,10,100,10,100,100,10,100);
  gl.endDraw();
}

void keyPressed(){ gl.flipY=!gl.flipY; }
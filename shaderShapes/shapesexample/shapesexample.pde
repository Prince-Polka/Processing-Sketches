shaderShapes gl;
void setup(){
  size(500,500,P2D);
  gl = new shaderShapes();
}
void draw(){
  gl.beginDraw();
  gl.background();
  gl.strokeWeight();
  gl.stroke();
  gl.line();
  gl.stroke();
  gl.bezier();
  gl.fill();
  gl.ellipse();
  gl.fill();
  gl.triangle();
  gl.fill();
  gl.quad();
  gl.endDraw();
}
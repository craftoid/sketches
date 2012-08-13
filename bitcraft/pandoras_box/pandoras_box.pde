/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/3801*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
 
PImage i;
int t, s=64;

void setup() {
  i = loadImage("../loading.gif");
  i.filter(THRESHOLD);
  size(s+2,s+2,P3D);
}

void draw() { 
  if(mousePressed) { background(0); translate(s/2,s/2,s/2); for(int i=0; i<8;i++) {cube();scale(.3);};}
  else { background(0); image(i,1,1,s,s); noCursor();}
  filter(THRESHOLD);
  t--;
}

void mousePressed() {
  int x = constrain(mouseX-1,0,s-1);
  int y = constrain(mouseY-1,0,s-1);
  cursor(i, x, y);
}

void cube() {
  float z = dist(mouseX,mouseY,s/2,s/2)/width;
  pushMatrix();
  scale(.2*pow(z,2)); rotateZ(t*.01);rotateY(t*.02);rotateX(t*.03);
  for(int i=0;i<6;i++) {rotateY(PI/2* ((i+1)%2)); rotateX(PI/2 *(i%2)); face(z);}
  popMatrix();
}

void face(float explode) {
  pushMatrix();
  translate(0,0,s/4*pow(explode,.2));
  image(i,-s/4,-s/4,s/2,s/2);
  popMatrix();
}

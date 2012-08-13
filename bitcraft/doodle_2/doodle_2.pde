/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6637*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */


  ////////////////////////////
  //                        //
  //        doodle 2        //
  //                        //
  ////////////////////////////

  // (c) Martin Schneider 2009

int n = 100;
float r = 0.1;
float s = 0.02;
float w, h;

void setup() {
  size(500, 500, P2D);
  w = width/2; 
  h = height/2;
  smooth();
}

void draw() {
  noStroke(); 
  fill(255, 30);
  rect(0,0,width, height);
  translate(w,h);
  scale(w*1.6);
  for(int y=1; y<n; y++) for(int x=1; x<n; x++) {
    line(f(x, y), f(x-1, y));
    line(f(x, y), f(x, y-1));
  }
}

void line(float[] p1, float[] p2) {
    stroke(0, 30);
    line(p1[0], p1[1], p2[0], p2[1]);
}

float[] f(int ix, int iy) {
  float x = map(ix, 0, n-1, -1, 1) * random(1-r, 1+r);
  float y = map(iy, 0, n-1, -1, 1) * random(1-r, 1+r);
  float a = (mouseX-w)/(w+h);
  float b = (mouseY-h)/(w+h);
  float d = x*x + y*y; 
  return new float[] { (x*a + y*b)/d, (x*b - y*a)/d }; 
} 



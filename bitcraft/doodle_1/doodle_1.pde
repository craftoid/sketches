/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6634*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */


  ////////////////////////////
  //                        //
  //        doodle 1        //
  //                        //
  ////////////////////////////

  // (c) Martin Schneider 2009

int n = 2500;
float s = 0.02;
float w, h, t, px, py;

void setup() {
  size(500, 500, P2D);
  w = width/2; 
  h = height/2;
  smooth();
}

void draw() {
  background(255);
  translate(w,h);
  scale(w/2);
  for(int i=0; i<n; i++) {
    float x = noise(t+1, i*.01) * 2 - 1;
    float y = noise(t, i*.01) * 2 - 1;
    if(i>0)  {
      line(f(x, y), f(px, py));
      line(f(x, y), f(x+s, y));
      line(f(x+s, y), f(px+s, py));       
    }
    px=x; 
    py=y;
  }
  t += .001;
}

void line(float[] p1, float[] p2) {
  float c =  dist(p1[0], p1[1], p2[0], p2[1])  * 128;
  if(c<128) {
    stroke(128+c, 64);
    line(p1[0], p1[1], p2[0], p2[1]);
  }
}

float[] f(float x, float y) {
  float a = (mouseX-w)/(w+h);
  float b = (mouseY-h)/(w+h);
  float d = x*x + y*y; 
  return new float[] { (x*a + y*b)/d, (x*b - y*a)/d }; 
} 



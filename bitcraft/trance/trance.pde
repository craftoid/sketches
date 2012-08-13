/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6481*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

  ////////////////////////////
  //                        //
  //                        //
  //      t r a n c e       //
  //                        //
  //                        //
  ////////////////////////////

  // (c) Martin Schneider 2009


//color pal[] = { 0, 255 };
//color pal[] = { #ff0000, 255, #0000ff };
color pal[] = { 0, #ff0000, #00ff00, #0000ff };

int n = 61;
int c = 2;

float[][] v = new float[n][3];
float rot, ang, w, h, r;


void setup() {
  size(500,500,P3D);
  w = width;
  h = height;
  r = h - PI/2 * h;
  noStroke();
  noCursor();
}


void draw() {
  
  background(0);
  translate(w/2, h/2, 0);  
 
  ang = (mouseY-h/2) / h * PI/4;
  rot += (mouseX-w/2) / w * .1;
  
  rotateX(ang);
  rotateZ(rot);
  rotateX(-ang);  

  beginShape(QUAD_STRIP);
  for(int t=0, i=0; i<n; i++) {
    for(int j=0; j<n; j++) {  
      float a = map(i,0,n-1,0,PI);
      float b = map(j,0,n-1,0,TWO_PI);
      v[j][0] = r * sin(a) * cos(b);
      v[j][1] = r * sin(a) * sin(b);
      v[j][2] = r * cos(a);
      if(i>0) {
        int k = (j+1) % n;
        fill(pal[ t++ % pal.length], 128);
        vertex(v[j][0], v[j][1], v[j][2]); 
        vertex(v[k][0], v[k][1], v[k][2]);
      } 
    }
  }
  endShape();
 
}

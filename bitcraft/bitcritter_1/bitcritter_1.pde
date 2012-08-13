/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6683*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

////////////////////////////
//                        //
//     bit critter 1      //
//                        //
////////////////////////////

// (c) Martin Schneider 2009


boolean egocritter, shadows, wiggle=true;
int n = 3, l = 50, d = 50;
float zoom = 16, s = .1;
color c1 = 255, c2 = 0;

float w, h, mx, my, rx, ry, vv, zz;
int t, b;

void setup() {
  size(500, 500, P3D);
  w = width/2;
  h = height/2;
}

void draw() {
  
  if(egocritter) noCursor(); else cursor(ARROW);
    
  mx = lerp(mx, mouseX, s);
  my = lerp(my, mouseY, s);
  rx = lerp(rx, (w-mouseY)/w + (egocritter ? 0 : PI), s);
  ry = lerp(ry, (mouseX-w)/w, s);
  vv = lerp(vv, wiggle?.05:-.1, s);
  zz = lerp(zz, zoom, s);

  noStroke();
  background(0); 

  if(shadows) lights(); 
  
  translate(mx, my, 8 * zz * (sin(t*.05) -1));
  rotateY(ry);
  rotateX(rx);
  scale(zz);
  
  randomSeed(0);
  for(int i=-n; i<=n; i++) 
    for(int j=-n; j<=n; j++) {
      pushMatrix();
      translate(i, j, 0);
      float d = random(vv, .1);
      float s = 1;
      for(float k=l; k>0; k--) {
        translate(0, 0, s);
        fill(noise(i, j, k+b)>.5 ? c1 : c2);
        box(1, 1, s);
        rotateY(d * sin(t*.05 + PI*k/l));
        scale(.95);
        s /= .97;
      } 
      popMatrix();
  }
  
  t++;
  
}

void keyPressed() {
  switch(key) {
    case 'e': egocritter = !egocritter; break;
    case 'q': shadows = !shadows; break;
    case 'w': wiggle = !wiggle; break;
    case 's': zoom /= 1.1; break;
    case 'd': zoom *= 1.1; break;
    case 'a': b -= egocritter ? -1 : 1; break;
    case 'f': b += egocritter ? -1 : 1; break;
  }
  zoom = constrain(zoom, 1, 64);
}


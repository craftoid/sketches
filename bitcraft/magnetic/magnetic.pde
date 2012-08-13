/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6884*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */


/////////////////////////////
//                         //
//    Magnetic Bubbles     //
//                         //
/////////////////////////////

// (c) Martin Schneider 2010


color  bg0 = 0, bg1 = 255, c1 = #ff6666, c2 = #6666ff;
boolean dark = true;
int maxiter = 10;
int minsize = 8;
int maxsize = 50;
int cellwall = 8;

ArrayList bubbles = new ArrayList();
float x1, y1, r;
float w, h;


void setup() {
  size(500, 500);
  w = width/2;
  h = height/2;
  background(dark ? bg0: bg1);
  smooth();
}


void draw() {
  
  int n = bubbles.size();

  noStroke();
  fill(dark ? bg0 : bg1, 100);
  rect(0, 0, width, height);
    
  // move bubbles
  for(int i=0; i<n; i++) getBubble(i).move();
  
  // resolve collisions
  boolean c = true;
  for(int cc=0; cc<maxiter & c; cc++) {
    c = false;
    for(int i=0; i<n; i++) c |= getBubble(i).collide();
  } 
 
  // draw bubbles
  for(int i=0; i<n; i++) getBubble(i).draw();
  
  interact();
}


/// user interaction 

void interact() {
  if(mousePressed) {
   bubble(x1, y1, r, mouseButton == LEFT ? c1 : c2); 
  }
}

void mousePressed() {
  x1 = mouseX;
  y1 = mouseY;
  r = minsize;
}

void mouseDragged() {
  r = constrain(dist(x1, y1, mouseX, mouseY), minsize, maxsize);
}

void mouseReleased() {
  bubbles.add(new Bubble(x1, y1, r, mouseButton==LEFT ? +1: -1));
}

void keyPressed() {
  switch(key) {
    case 'r': bubbles = new ArrayList(); break;
    case 'w': dark = !dark; break;
  }
}


// helper functions

Bubble getBubble(int i) {
  return (Bubble) bubbles.get(i);
}

void bubble(float x, float y, float r, color c) {
  fill(c);
  strokeWeight(cellwall); stroke(c, 128);
  ellipse(x, y, 2*r-cellwall, 2*r-cellwall);
}



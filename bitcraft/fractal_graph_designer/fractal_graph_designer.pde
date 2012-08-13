/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/7102*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

       
 /////                           /////
 //                                 //
 //                                 //
 //     Fractal Graph Designer      //
 //                                 //
 //                                 //
 /////                           /////
   
   
 ///// (c) Martin Schneider 2010 /////


int n0 = 5;
int depth = 6;
int dragdepth = 5;
int maxdepth = 8;

color c1 = #000000, c2 = #6666ff,  c3 = #ff0000;
int opacity = 200;


int w, h;
int drawdepth;
boolean softLines;

void setup() {
  
  size(800, 500, P2D);
  w = width / 2;
  h = height / 2;
  
  resetKnobs();
  resetLinks();
  resetCursor();
  
  noFill();
  smooth();

}


void draw() {
  background(255);
  strokeWeight(softLines ? 1 : .5);
  fractalDraw();
}



void mousePressed() {
  
  // store mouse position
  ppmouseX = mouseX;
  ppmouseY = mouseY;
  
  // create knob on the plane
  if(mouseButton==LEFT && active == null) 
    active = createKnob(mouseX, mouseY);
   
  // create knob on an edge
  if(mouseButton==LEFT && activeLink != null && active != null) {
    createLink(activeLink.k1, active);
    createLink(active,  activeLink.k2);
    removeLink(activeLink);
    activeLink = null;
  }
  
}

void mouseReleased() {
  
  // create connected knob
  if(mouseButton==CENTER && active != null) { 
    createLink(active, active = createKnob(mouseX, mouseY));
  }
  
  // deactivate knots and links
  active = null;
  activeLink = null;
}



void keyPressed() {
  switch(key) {
    
    case ' ' : resetKnobs(); resetLinks(); break;
    case 'x' : showKnobs = !showKnobs; break;
    case '-' : showLinks = !showLinks; break;
    case 'v' : showDirection = !showDirection; break;
    case 's' : softLines = !softLines; break;
    
    case CODED : 
      switch(keyCode) {
        case UP : depth++; break; 
        case DOWN : depth-- ; break;
        case LEFT : dragdepth--; break;
        case RIGHT : dragdepth++; break;
      }
      break;
    
  }
  
  // limit iterations 
  depth = constrain(depth, 1, maxdepth);
  dragdepth = constrain(dragdepth, 1, maxdepth);

}


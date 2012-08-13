/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/34982*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

//////////////////////
//                  //
//   Gear Paint     //
//                  //
//////////////////////

//  (c) bit.craft 2011


Stack<Gear> gears;
Gear picked;
color bgcolor = #000000, fgcolor = #ffffff, cursorcolor = #ff0000;
int steps = 4;
float hcog = 5, wcog = 5;
float RMIN = 2 * wcog;
float RMAX = 10 * wcog;
float speed = .5;
float tweening = .2;


void setup() {
  size(500, 500);
  gears = new Stack<Gear>();
  picked = new Gear(mouseX, mouseY);
  stroke(bgcolor); 
  smooth();
}


void draw() {
  background(bgcolor);
  boolean pvalid = setPosition(mouseX, mouseY);
  if(pvalid) {
    gearCursor();
    if(mousePressed) createGear();
  } else {
    cursor(); 
  }
  fill(fgcolor);
  for (Gear gear : gears) {
    gear.step();
    gear.draw();
  }
}




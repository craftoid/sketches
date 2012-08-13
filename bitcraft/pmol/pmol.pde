/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6939*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */


  //////////////////////////////////////////
  //                                      //
  //   o-----o  o       o         o       //
  //   |     |  |\     /|    o    |       //
  //   |     |  | \   / |  /   \  |       //
  //   o-----o  |   o   | o     o |       //
  //   |        |       |  \   /  |       //
  //   o        o       o    o    o----o  //
  //                                      //
  //  A simple molecule viewer            //
  //  for Processing based on JMOL        //
  //  ( http://jmol.sourceforge.net/ )    //
  //                                      //
  //////////////////////////////////////////
  
  //  (c) Martin Schneider 2010


import peasy.*;


color bg= #ffffff,  ca = #ddddff, cb = #aaaaff;
float rmin = 0.1, rmax = 1.0;
float ra = 1/3f; // atom radius
float rb = 1/6f; // bond radius
float opacity = 120;
int detail = 30;


PeasyCam cam;
boolean reset, transparent = true;
float rt, dx, dy, dz, dmax;
float xmin, ymin, zmin, xmax, ymax, zmax;


void setup() {
  size(500, 500, P3D);
  sphereDetail(detail/2);
  cam = new PeasyCam(this, 500);
  noStroke();
  nextMol();
}


void draw() {
  background(bg);
  lights();
  scale(.8);
  drawMolecule(asc);
}


void keyPressed() {
  switch(key) {
    case ' ' : nextMol(); break;
    case 't' : transparent = !transparent; break;
    case CODED: switch(keyCode) {
      case UP : ra = ra*1.1; break;
      case DOWN : ra /= 1.1; rb = min( ra, rb);  break;
      case LEFT : rb /= 1.1; break;
      case RIGHT : rb *= 1.1; ra = max(ra, rb);  break;
    }
  }
  ra = constrain(ra, rmin, rmax);
  rb = constrain(rb, rmin, rmax);  
}







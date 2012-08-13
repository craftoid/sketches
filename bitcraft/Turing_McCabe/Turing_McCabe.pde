/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/33444*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

/////////////////////////////////////////////////////////////////////////////
//                                                                         //
//         Multi-Level Multi-Color Turing-McCabe Pattern Explorer          //
//                                                                         //
/////////////////////////////////////////////////////////////////////////////

// (c) bit.craft 2011

// Turing-McCabe patterns are based on a  multi-layer single-chemical reaction-diffusion system,
// as first described by Jonathan Mc Cabe [1]

// This code extends upon the very efficient implementation posted by Kyle McDonald [2]
// The basic algorithm for Turing-McCabe Patterns was detailled by Jason Rampe [3]
// and first implemented in Processing by Frederik Vanhoutte [4]

// [1] http://www.jonathanmccabe.com/Cyclic_Symmetric_Multi-Scale_Turing_Patterns.pdf
// [2] http://www.openprocessing.org/visuals/?visualID=31195
// [3] http://softologyblog.wordpress.com/2011/07/05/multi-scale-turing-patterns/
// [4] http://www.wblut.com/2011/07/13/mccabeism-turning-noise-into-a-thing-of-beauty/


boolean colMode = true;
boolean invertMode = false;
int resolution = 2;
int spacing = 20;
int brush = 2;
float stepOffsetMin = .001;
float stepOffsetMax = .2;
float stepScaleMin = .001;
float stepScaleMax = .1;

void setup() {
  size(800, 500, P2D);
  //size(720, 600, P2D);
  resetParams();
  setupControls();
  updateControls();
  colorMode(HSB);
}

 
void draw() {
  symmetry();
  calculatePattern();
  background(255);
  renderPattern(buffer);
  drawImage(buffer);
  drawControls();
  interaction();  
  // if(frameCount % 20 == 0) println(frameRate);
}


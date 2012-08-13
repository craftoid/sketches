/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/34403*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

/////////////////////////////////////////////////////////////////////////////
//                                                                         //
//                                                                         //
//      V I G N E T T E    E X P L O R E R         (c) bit.craft 2011      //
//                                                                         //
//                                                                         //
/////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//                                                                         //
//      Key Map                                                            //
//                                                                         //
/////////////////////////////////////////////////////////////////////////////

//////  Vignette Keys   //////

// [UP] and [DOWN] change the rule number
// [+] and [-] change the radius

// (You can also use the mouse to change those parameters)
 
// [LEFT] and [RIGHT] to change the number of iterations

// [x] flip the vignette (upside down)
// [c] invert it (inside out)
// [v] vertical axis twist
// [b] horizontal axis twist

// [q][w][e] ... [u][i][o] toggle individual x-bits of the current rule
// [a][s][d] ... [j][k][l] toggle individual y-bits of the current rule

/////  Display Keys  /////

// [SPACE] switch between display modes
// [1] or [TAB] transition mode on/off
// [2] labels on/off
// [3] icons on/off
// [0] reset to zero

// By default transitions are enabled in sketch mode and disabled in color mode.
// Hold down the [SHIFT] key for supersmooth transitions  :)

 
/////////////////////////////////////////////////////////////////////////////
//                                                                         //
//      Vignette Curves Explained                                          //
//                                                                         //
/////////////////////////////////////////////////////////////////////////////


// Vignettes are parametric curves based on higher level cycloids (see http://en.wikipedia.org/wiki/Cycloid)

// Let's start out with a simple circle.
// Then at each iteration we add a new cyclic curve to our equation with two times the frequency and a smaller amplitude.
// Every iteration introduces a phase shift of either zero or PI to any of the parametric equations for x and y.

// The specific choice of phase shifts results in a bilateral vignette-style symmetry.
// The progression of amplitudes gives rise to shapes with both epicycloid and hypocycloid characteristics.
// (i.e. there are both spikes and petals)

// The succession of phaseshifts is encoded into a binary vector, which we call be the "rule number" of the vignette.
// (In analogy to rule numbers used for enumerating Cellular Automata by Stephen Wolfram)

// Eeach vignette has 8 siblings, resulting from combinations of the three elementary
// inversion operators (negate, invertX and invertY).
// You can [SHIFT]-press the keys on the bottom row ([X] ... [N]) of your keyboard to see how 
// the siblings are related.

// By adding a disk with user controlled radius to the vignette, we can provide additional space on the inside.
// This will offset of our curve from the center, breaking the symmetry and  giving each of the siblings a unique identity.

// If we repeatedly added cyclic curves ad infinitum we would obtain fractal functions, yielding fractal super-cycloids,
// a.k.a fractal vignettes ...

// For a more compact implementation see my tinysketch version here:
// http://www.openprocessing.org/visuals/?visualID=4630


/////////////////////////////////////////////////////////////////////////////


// constants

int MAXITER = 9, fontsize = 12;
float maxradius = 5.0;

int xborder = 15, yborder = 10, xgap = 0;
color bgcolor = color(255,255,230);
int tweensteps = 20;


// objects

PFont font, bfont;
Vignette v; 
Vignette[] icons = new Vignette[MAXITER]; 


// globals

float radius = 0;
boolean showlabels = true;
boolean showicons = true;
boolean colors = true;
boolean tweening = false;
float tweenspeed = .9;
int iter = 8;
int rule = 0;
int w, h;


/////////////////////////////////////////////////////////////////////////////

void setup() {

  size(600, 450, "SmoothJava2D");
  w = width; h = height;
  
  // create fonts for the labels
  bfont = loadFont("FreeSansBold-12.vlw");
  font = loadFont("FreeSans-12.vlw");
  
  // calculate size of the icons 
  int isize = (width - 2 * xborder - (MAXITER - 1) * xgap) / MAXITER;
  
  // create a new vignette at the center of the screen
  int left = xborder;
  int right = xborder;
  int top = yborder + fontsize + yborder;
  int bottom = yborder + isize + yborder;
  v = new Vignette(left, top, width - left - right, height - top - bottom , MAXITER);
  
  // create ancestor vignettes to show the evolution through several iterations
  left = xborder;
  top = yborder + isize;
  for(int i = 0; i < MAXITER; i++) {
    icons[i] = new Vignette(left + i * (isize + xgap), height - top, isize, isize, i + 1); 
  }

  smooth();
  iter = 8;
}


/////////////////////////////////////////////////////////////////////////////

void draw(){

  background(colors ? bgcolor : 255);
  if(showlabels) drawLabels();
  
  // rescale coordinates in case the applet is resized while running (browser zoom)
  if(w != width) scale(float(width) / w);
  
  // draw the vignette
  v.draw(1.0);  
  
  // and it's ancestors
  if(showicons) {
    for(int i = 0; i < iter; i++) {
      icons[i].draw(.5);
    }
  }
}





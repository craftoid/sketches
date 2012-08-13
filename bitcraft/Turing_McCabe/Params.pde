
/////////////////////////////////////////////////////////////////////////////
//                                                                         //
//      Parameters for the Multi-Color Multi-Level Turing Pattern          //
//                                                                         //
/////////////////////////////////////////////////////////////////////////////

int w, h, n, levels, blurlevels;
float gridmin, gridmax, colormax, colormin;

float[] grid, colorgrid, bestVariation;
float[] diffusionLeft, diffusionRight, blurBuffer;
float[] stepSizes, colorShift;
boolean[] direction;
int[] bestLevel, radii;
PImage buffer;

// independent params

float base = 2.0;
float stepScale = .01;
float stepOffset = .01;
float blurFactor = 1.0;
int symmetry = 0;
int colorOffset = 0;




void resetParams() {
  resetParams(false);
}

void resetParams(boolean randomize) {
    
  // set resolution; 
  imgWidth = (width - controlWidth - 3 * spacing) ;
  imgHeight = (height - 2 * spacing);  
  w = imgWidth / resolution;
  h = imgHeight / resolution;
  
  
  // allocate space
  n = w * h;
  grid = new float[n];
  diffusionLeft = new float[n];
  diffusionRight = new float[n];
  blurBuffer = new float[n];
  bestVariation = new float[n];
  bestLevel = new int[n];
  direction = new boolean[n];
  colorgrid = new float[n];
  buffer = createImage(w, h, RGB);
  
  // initialize the grid with noise
  for (int i = 0; i < n; i++) {
    grid[i] = random(-1, +1);
  }
  
  // initialize pattern params
  if(randomize) randomizeParams();
  updateParams(); 
}

void randomizeParams() {
  
   // relates to the complexity (how many blur levels)
  base = random(1.5, 2.4); 
   
  // these values affect how fast the image changes
  stepScale = random(stepScaleMin, stepScaleMax / 5);
  stepOffset = random(stepOffsetMin, stepOffsetMax / 5);
  
  // color scheme of the image
  colorOffset = (int) random(255);
  
  // rotational symmetry groups
  symmetry = int(random(.5, 6.5));
  if(symmetry==1) symmetry = 0;
  
  // random shape blurring
  blurFactor = random(0.5, 1.0);
}


void updateParams() {
  
  // updating the dependent variables
  
  levels = (int) (log(max(w,h)) / log(base)) - 1;
  blurlevels = (int) max(0, (levels+1) * blurFactor - .5);
        
  radii = new int[levels];
  stepSizes = new float[levels];
  colorShift = new float[levels];
  
  for (int i = 0; i < levels; i++) {
    int radius = (int) pow(base, i);
    radii[i] = radius;
    stepSizes[i] = log(radius) * stepScale + stepOffset;
    colorShift[i] = (i % 2 == 0 ? -1.0 : 1.0) * (levels-i);
  }
  
}

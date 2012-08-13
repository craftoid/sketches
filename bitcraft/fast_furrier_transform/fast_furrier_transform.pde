/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/7438*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */


  /////////////////////////////////
  //                             //
  //                             //
  //   Fast Furrier Transform    //
  //                             //
  //                             //
  /////////////////////////////////
  
  /////// (c) Martin Schneider 2010
  
  // Powered by PETA 
  // ( Processing for the Ethical Treatment of Animals )
  
  // This sketch was inspired by the work of Paul Nylander
  // ( http://nylander.wordpress.com/2007/05/24/activator-inhibitor/ )
  // and Jonathan McCabe ( http://www.jonathanmccabe.com/ )
  

  // The FFT-Algorithm:
  
  // The sketch uses a simple pattern formation algorithm based on a 
  // discrete cellular network ( Network Automaton )
  
  // The approach relies on a single chemical spreading along weighted
  // connections  between cells -- very much like in a self organizing 
  // neural network
  
  // Each cell is connected to a number of (r * dirs) cells 
  // in its vicinity.
  
  // The connections spread out out radially, covering distances 
  // of  1, 2, 4, 8, 16, 32 ... units respectively, thus reducing the 
  // minimum pathlength between any two cells, while at the same time
  // minimizing the number of required connections.
  // As a result we get maximum cell interation from minimum computation 
  // making the Furrier Transform superfast.


final int snowland = 0, savanna = 1;
final int palmax = 2, weightmax = 7, dirmax = 18, palsize=256;

boolean borderMode, drawMode, outputMode, inputMode;

int pat = 0;
int dirs = 9;
int pal = savanna;
int outputFrames = 10;

color[][] palettes;
int[][][] fur;
int[][] weights;
int patmax, p, q, w, h;

PImage img;
String sampleImg = "furry.png";
String outputFolder = sketchPath;

   
void setup() {
  
  // init graphics
  colorMode(HSB);
  noStroke();
  
  // init screen
  size(500, 300, P2D);
  w = width;
  h = height;

  // init palettes
  palettes = new color[palmax][palsize];
  for(int i=0; i<palsize; i++) {
    float c1 = map(i, 0, palsize-1, 20, 40);
    float c2 = map(i, 0, palsize-1, 0, 255);
    palettes[savanna][i] = color(c1, 255, c2);
    palettes[snowland][i] = color(c2);
  }

  // init fur and image
  img = createGraphics(w, h, JAVA2D);
  presets();
  reset(); 
  
}


void reset() {
  furFromImage(img); 
}


void presets() {

  // read pattern weights from a file
  String lines[] = loadStrings("weights.txt");
  patmax = lines.length;
  weights = new int[patmax][];
  for(int i=0; i<lines.length; i++) {
    weights[i] = int(expand(split(lines[i], ", "), weightmax));
  }
  
  // reset seed image
  if(frameCount==0) loadSeed(sampleImg); else background(128);
  img = get();
}


void draw() {

  // buffer indices to switch between two buffers
  p = frameCount % 2; 
  q = 1-p;

  // drawing or pattern formation
  if(drawMode) {
    if(inputMode) loadSeed();
    spray(); 
  } else {
    pattern();
    drawPattern();
    if(outputMode) savePatternAnimation();
  }

}


void drawPattern() {
  
  // get minimum and maximum concentration
  int amin = MAX_INT;
  int amax = -MAX_INT;
  for(int y=0; y<h; y++) for(int x=0; x<w; x++) {
    int a = fur[q][x][y];
    amin = min(amin, a);
    amax = max(amax, a);
  }
  
  // map the concentration to the color palette 
  for(int y=0; y<h; y++) for(int x=0; x<w; x++) {
    int a = fur[q][x][y];
    int c = (int) map(a, amin, amax, 0, palsize-1);
    set(x, y, palettes[pal][c] );
    fur[p][x][y] = fur[q][x][y];
  }
  
}



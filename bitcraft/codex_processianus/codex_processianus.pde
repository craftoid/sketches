/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/7579*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */


  //////////////////////////////
  //                          //
  //                          //
  //    Codex Processianus    //
  //                          //
  //                          //
  //////////////////////////////
  
  // (c) Martin Schneider 2009
  
  // This sketch creates flow map based drawings.
  // A flow map is an image where hue indicates the direction of flow 
  // and brightness indicates the amount of flow at any given pixel

  
// parameters

int n = 1000;
int rdodge = 20;
int opacity = 9;
int mapids = 5;

boolean showmap, lifelong, brush, fine, dodge = true;
int maxage, crayons, whirl, isolines, mapid, xhatch = 1;


// array of palettes 

color[][] palette =  {
  {#ffdd99, #882211}, // da vinci
  {#000000, #ffffff}, // blackboard
  {#ffffff, #000000,  #000099, #990099, #009999 }, // pencil crayons
  {#000000, #6666ff,  #aaaa66, #ff6666, #66ffff }, // fibreglass
  {#000000} // rainbow colors
};

int palettes = palette.length;
int rainbow = 4;


// global variables

float[][] a = new float[n][2];
int[] age = new int[n];
float w, h;
int c;



void setup() {  
  size(500, 500);
  w = width/2;
  h = height/2;
  colorMode(HSB, TWO_PI, 2, 1);
  loadFlowmap(mapid);
  smooth();
  reset();
}


void draw() {
    
  if(showmap) {
    
    // show flow map
    background(0);
    image(ff, 0, 0);
  }
  
  else {
  
    // number of colors in the selected palette
    int colors = palette[crayons].length - 1;
    
    // select pen or brush
    strokeWeight(brush ? 3 : 1);
    
    // create new particles
    int np = n / maxage;
    for(int i=0; i<np & c<n; i++, c++) newp(c);
    
    // set detail
    int grain = fine ? 1 : 3;
    
    // draw particle traces 
    for(int i=0; i<c; i++) {
      
      // get particle from the array
      float[] p = a[i];
      
      // aging and rebirth
      if (age[i]++ > maxage) newp(i);  
      
      else {
                
        // save the starting point       
        float p0 = p[0], p1 = p[1];
        
        // move through flow map for a small distance ( the grain )
        final int maxiter = 10;
        float d = 0, j = 0;
        
        while(d < grain & j++ < maxiter ) {
          
          // get the flow at the current point
          float[] f = f(p[0], p[1], whirl + 2 * (i % xhatch) );
          
          // update the point
          p[0] += f[0] * cos(f[1]);
          p[1] += f[0] * sin(f[1]);
          
          // calculate distance to the starting point
          d = dist(p0, p1, p[0], p[1]);
        }
        
        
        //prevent dot marks and allow for iso-stripe pattern
        if(d < grain + isolines * .15) continue;
        if(d < grain + isolines * .15) continue;
        
        // rainbow hue based on direction
        if (crayons == rainbow) stroke(atan2(p[0]-p0,p[1]-p1) + PI, 1, 1, opacity);
       
        // crayon hue based on cross-hatch direction
        else stroke(palette[crayons][1 + (i % xhatch) % colors], opacity);
        
        line(p0, p1, p[0], p[1]);
        
      }
    }
  }
}


void newp(int p) {
  
  if(dodge) {
    
    // particle inside a circle around the mouse position
    float r = random(rdodge), ang = random(TWO_PI);
    a[p] = new float[] { mouseX + r * cos(ang), mouseY + r *sin(ang) };
    
  } else { 
    
    // particle anywhere on screen
    a[p] = new float[] { random(width), random(height) };
    
  }
  age[p] = 0;
  
}


void reset() {
  
  // clear screen
  if(!showmap) background(palette[crayons][0]);
  
  // reset maxage and particle counter
  maxage = lifelong ? 20 : 10;
  c = 0;
  
}

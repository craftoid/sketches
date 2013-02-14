/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/78541*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */


// T S P /////  //////////////  //////////////
           //  //          //  //          //
      //////  //////  //////  //////  //////
     //          //  //          //  //
    //////////////  //////////////  /////////// W O R M S //
   
   
// An experiment in figure-ground perception 

// What happens if an army of worms 
// walks the path of the travelling salesman?
 
// (c) Martin Schneider 2012


boolean processing2 = P3D == OPENGL; // Is this Processing 2.0 ?

float wtour = 20000.0;       // width of the original TSP tour
int n = 100000;              // number of TSP points
float zoom = 0.9;      
 
int[] x = new int[n];
int[] y = new int[n];
int[] tour = new int[n];

int x1, y1, x2, y2;
int w;


void setup() {

  size(800, 600, processing2 ? JAVA2D : P2D); // JAVA2D is too slow in Processing 1.5
  background(255);
  smooth();

  // Load TSP points
  String[] lines = loadStrings("mona-lisa100K.tsp");
  for (int i = 0; i < n; i++) {
     String[] triple = split(lines[i + 6], ' ');
     x[i] = int(triple[1]);
     y[i] = int(triple[2]);
  }
  
  // Load TSP tour
  lines = loadStrings("monalisa_5757191.tour");
  for (int i = 0; i < n; i++) {
    tour[i] = int(lines[i + 5]) - 1;  
  }

  // start with the end point of the TSP tour
  x1 = x[tour[n-1]]; 
  y1 = y[tour[n-1]];
  
  w = min(width, height);
  
}

void draw() {

  // white background
  background(255);
  
  // flip y-axis and center the image leaving a white border 
  translate(width/2, height/2); 
  scale(zoom, -zoom); 
  translate(-w/2, -w/2);
 
  // rescale tour size to canvas size 
  scale(w/wtour);
  
  // rescale stroke weight ( only for Processing 2.0 or JAVA2D ) 
  if(processing2) strokeWeight(wtour/w);
 
  // draw tour segments 
  for (int i = 0; i < n; i++)
  {
    // get end point of the segment
    x2 = x[tour[i]]; 
    y2 = y[tour[i]];
   
    // this is where the magic happens
    if( (frameCount + i + mouseX) % w < w - mouseY ) line(x1, y1, x2, y2);
    
    // use end point as starting point for the next segment
    x1 = x2;  y1 = y2;
  }
  
}


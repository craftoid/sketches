/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/9741*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */


////////////////////////////////////////////////////////////////

///////// i n t e r  ///////////////////////////////////////////

//////////////////////////////////////////// l a c e d /////////

////////////////////////////////////////////////////////////////

///////// (c) martin schneider 2010 ////////////////////////////

////////////////////////////////////////////////////////////////



// inspired by the work of J.K. Keller:
// http://www.jk-keller.com/works/2009/reverse-keetra



// input 

PImage img;
int[][] edges;
int minborder = -2;

// transform params

float t1, t2; 
int jerk = 2; 
int raster = 2; 
int mirror = -1;
int b = minborder; 
int fc;



////////////////////////////////////////////////////////////////

void setup() {
  

  // Image by Ashley R. Good ( http://www.flickr.com/photos/kmndr/2788742255/ ) CC-by-2.0
  img = loadImage("profile.jpg");
  edges = edges(img, 8, 6);
  
  //img = loadImage("http://www.jk-keller.com/works/images/you-me-you-kd-orig-470.jpg");
  //edges = edges(img, 8, 6);
  
  //img = loadImage(http://www.jk-keller.com/works/images/you-me-you-jk-orig-470.jpg");
  //edges = edges(img, 12, 6);  
 
  size(img.width, img.height); 
}



////////////////////////////////////////////////////////////////

void draw() {
  tint(255, 64);
  int frames = frameCount - fc;
  int tx = frames % raster - raster/2;
  int ty = (frames / raster) % raster;
  image(interlace(img), tx*jerk, ty*jerk);
}



////////////////////////////////////////////////////////////////

void keyPressed() {
  switch(key) {
    case 'j': jerk=jerk^10; raster=raster^10; fc = frameCount; break;
    case 'm': mirror *= -1; break;
   
  }
}




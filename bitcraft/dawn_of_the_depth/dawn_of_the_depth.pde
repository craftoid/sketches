/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6382*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

  ////////////////////////////
  //                        //
  //   Dawn of the Depth    //
  //                        //
  ////////////////////////////
  
  // (c) Martin Schneider 2009

  // This is a nifty little algorithm to make depth-maps come to live again.
  // (All shapes generated using the SuperDuperShape Explorer)
  
  // Uncomment the line at the bottom to resurrect the beautiful art of Kazuki Takamatsu.
    
  
PImage depthmap; 

int offsetx, offsety;  
float imageScale = .9; 

int imageIndex = 0; 
int imageCount = 12;

int maxshift = 32;  
int detail = 3;


void setup() {
  
  size(340, 500, P2D);
  noCursor();
  next();
  
}



void draw() {
  
  background(0); 
   
  // access image data
  loadPixels();
  depthmap.loadPixels();

  // number of layers
  int n = 256>>detail;
  
  // calculate offset between layers
  float shiftx = map(mouseX, 0, width, -maxshift, maxshift) / n ;
  float shifty = map(mouseY, 0, height, -maxshift, maxshift) / n ;
  
  // iterate over all points of the image
  for(int y=0; y < height; y++) 
    for(int x=0; x < width; x++) {
      
      // iterate over all layers starting at the top 
      // working our way down in Z-direction ...
      for(int i=n; i>0; i--) {
        
         // brightness of the current layer
         int bright = i<<detail;
        
         // find the corresponding pixel in the source image that will be mapped to the current pixel
         int pickx =  x + (int)(i * shiftx) - offsetx;
         int picky =  y + (int)(i * shifty) - offsety;
         
         // check if this pixel is inside the bounds of the source image
         if (pickx < 0 | pickx >= depthmap.width | picky < 0 | picky >= depthmap.height) continue;
         
         // get the brightness of the selected pixel
         int pick = depthmap.pixels[pickx + picky * depthmap.width] & 255; 
         
         // if the pixel found is brighter ( = in front of) the current layer we are done
         if(pick >= bright) { 
            pixels[x + y * width] =  255<<24 | bright * 0x010101;
           break; 
         }
         
      }
    }
    
    updatePixels();
    
}


void keyPressed() { 
  
  switch(key) {
    case ' ' : 
      next(); 
      break;
    case '+' :
      detail--; 
      break;
    case '-' : 
      detail++; 
      break;
  }
  
  detail = constrain(detail, 0, 7); 
  
}


void next() {
  
  // pick the next image index
  imageIndex %= imageCount; 
  imageIndex++;
  
  // depthmaps of superdupershapes
  depthmap = loadImage("SuperDuperShape-of-Depth_" + imageIndex +".png");
  
  // uncomment the line below to see the art of Kazuki Takamatsu come alive !
  // depthmap = loadImage("http://www.yatzer.com/assets/Image/2009/october/takamatsu/Kazuki-Takamatsu-yatzer_" + ++imageIndex +".jpg");

  // scale to fit
  float scaling = min( imageScale * width / depthmap.width, imageScale * height / depthmap.height);
  depthmap.resize(int(depthmap.width * scaling), int(depthmap.height * scaling));
  
  // center the image
  offsetx = (width - depthmap.width ) / 2; 
  offsety = (height - depthmap.height ) / 2;
}


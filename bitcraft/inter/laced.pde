

////////////////////////////////////////////////////////////////

///////// interlace transform //////////////////////////////////

////////////////////////////////////////////////////////////////

PImage interlace(PImage img) {
  
  // t1 --- horizontal distance from the center
  t1 += (mouseX - width/2) / 8;
  
  // t2 lags behind
  t2 = lerp(t2, t1, .1);
  
  // border --- vertical distance from the center
  b = (int) max(minborder, height/2 - 1.2*abs(mouseY-height/2));
  
  // copy the image
  PImage pic = img.get();

  // transform every single rasterline
  for(int y=0; y<height; y++) {
     
    // raster line offset by t1 and t2, possibly with mirror effect
    float tx = y % 2 > 0 ? mirror * t1 : t2;
      
    // left and right edges
    int on = edges[0][y], off = edges[1][y];
    
    if(on>0 && off<width-1) { // igonore abberations
      
      // add some border to the raster lines
      on = max(0, on-b); 
      off = min(width-1, off+b);
      int d = off-on;
      
      // the actual raster line transform
      for(int x=0; x<d; x++) 
        pic.set(on+x, y, img.get(on + abs(int( x + tx * float(d) / width )) % d, y));   
    }
    
  }
  
  return pic;
}


////////////////////////////////////////////////////////////////

//////////////////// left and right edges of a profile /////////

////////////////////////////////////////////////////////////////

int[][] edges(PImage img, int treshold, int smoothen) {

  // arrays for left and right edge positions
  int h = img.height;
  int w = img.width;
  int[][] edges = new int[2][h];
  
  for(int y=0; y<h; y++) {
    
    // get brightness values for a single raster line
    int bright[] = new int[w];
    for(int x=0; x<w; x++) 
      bright[x] = (int) brightness(img.get(x,y));
    
    // detect left edge
    for(int x=w-6; x>0; x--)
      if(abs(bright[x] - bright[x+1]) > treshold) 
        edges[0][y] = x; 
         
    // detect right edge
    for(int x=5; x<w-1; x++) 
      if(abs(bright[x] - bright[x-1]) > treshold) 
        edges[1][y] = x;
        
  }  
   
  // smoothen edges
  edges[0] = smoothen(edges[0], smoothen);
  edges[1] = smoothen(edges[1], smoothen);
  
  return edges;
  
}



////////////////////////////////////////////////////////////////

///////// smoothen a sequence of values ////////////////////////

////////////////////////////////////////////////////////////////

int[] smoothen(int[] a, int range) {
  
  int[] a2 = new int[a.length];
  int dleft = range/2;
  int dright = range - dleft;
  int l = a.length - 1;
  
  for(int i=0; i<l; i++) {
    
     // actual range limits
     int jmin = max(0, i - dleft);
     int jmax = min(l, i + dright);
     
     // calculate mean value
     for(int j=jmin; j<jmax; j++) {
       a2[i] += a[j];
     }
     a2[i]/=(jmax-jmin);
     
  }
  return a2;
}





/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/71950*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

/////////////////////////////////////////////////
//                                             //
//        The Turing Pattern Microscope        //
//                                             //
/////////////////////////////////////////////////

// (c) Martin Schneider 2010 - 2012
  
// This is a 3D Version of "The Secret Life of Turing Patterns" ( http://www.openprocessing.org/sketch/17043 )
// using the depth effect from "Dawn of the Depth" ( http://www.openprocessing.org/sketch/6382 )

// Mouse Map

// Use left and right mouse button to draw
// Use the middle mouse button to drag the specimen

// Key Map

// [p] pattern mode
// [i] invert specimen
// [b] border mode / continuous mode
// [r] restart

// [c] colour palette
// [l] lighting on/off
// [f] following on/off
// [s] smoothing mode

// [left] [right] fractality level
// [up] [down]    depth resolution
//
// [SHIFT] + [left] [right] luminance of lighting
// [SHIFT] + [up] [down]    change resolution + reset

// [+] [-] modifiy the turing pattern variable
// [0] reset turing pattern variable
// [1] and [2] for different z-scales


PGraphics canvas;  
int detail = 0, scaleZ = 2;
float mx, my;

color[][] colors = new color[4][256];

void setup() {
  size(300, 300, P2D);
  colorMode(HSB);
  for(int c=0; c<256; c++) {
    colors[0][c] = color(c);
    colors[1][c] = color(64+c/4, c, c);
    colors[2][c] = color(255-c, 255-c,c);
    colors[3][c] = color(255-c,128,192+c/4);
  }
  reset();
  mouseX = width/2;
}


void draw() {

  // constrain the mouse position
  if(border) {
    mouseX = constrain(mouseX,0,width-1);
    mouseY = constrain(mouseY,0,height-1);
  } 

  if (!mousePressed && follow3D) {
    mx = lerp(mx, constrain(mouseX, 0, width-1), .3);
    my = lerp(my, constrain(mouseY, 0, height-1), .3);
  }
  
  // update pattern
  pattern();
  
  // draw depthmap
  canvas.loadPixels();
  int n = 256>>detail;
  int[] pal = colors[palette];
  int maxshift = (8-detail) * 4 * scaleZ / res ;
  int deltax = dx/res, deltay = dy/res;
  float shiftx = map(mx, 0, width, maxshift, -maxshift) / n ;
  float shifty = map(my, 0, height, maxshift, -maxshift) / n ;
  for(int y=0; y < h; y++) {
    for(int x=0; x < w; x++) {
      for(int i=n; i>=0; i--) {
         int level = i<<detail;
         int pickx = x + deltax + (int)(i * shiftx);
         int picky = y + deltay + (int)(i * shifty);
         if (pickx < 0) { if(border) continue; else pickx +=w; } else if (pickx >= w) { if(border) continue; else pickx %=w; }
         if (picky < 0) { if(border) continue; else picky +=h; } else if (picky >= h) { if(border) continue; else picky %=h; }
         int pick = (int) pat[pickx + picky * w]; 
         if(pick  >= level) { 
           int c = light ? (int) (level/2 + pshadow[pickx + picky *w]/2) : level;
           canvas.pixels[x+y*w] = pal[c];
           break; 
         }
      }
    }
  }
  
   // add a circular drop of chemical
  if(mousePressed) {
      if(mouseButton != CENTER) {
      int x0 = mod((mouseX+dx)/res + int(shiftx*n), w);
      int y0 = mod((mouseY+dy)/res + int(shifty*n), h);
      int r = rdrop * scl / res ;
      for(int y=y0-r; y<y0+r;y++)
        for(int x=x0-r; x<x0+r;x++) {
          int xwrap = mod(x,w), ywrap = mod(y,w);
          if(border && (x!=xwrap || y!=ywrap)) continue;         
          if(dist(x,y,x0,y0) < r)
            pat[xwrap+w*ywrap] = mouseButton == LEFT ? 255 : 0;
        }
    }
  }
  
  canvas.updatePixels();;
  if(soft) canvas.filter(BLUR);
  image(canvas,0, 0, width, height);
  
  // println(frameRate);

}

// floor modulo
final int mod(int a, int n) {
  return a>=0 ? a%n : (n-1)-(-a-1)%n;
}



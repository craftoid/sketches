

  ////                      ////
  //                          //
  //        flow map          //
  //                          //
  ////                      ////
  

PImage ff0;
PGraphics ff;

float tx, ty;
float zoom = 1;


// load the selected flow map

void loadFlowmap(int id) {
  ff = createGraphics(width, height, P2D);
  ff0 = loadImage("flowmap-" + (1+id) + ".jpg");
  updateFlowmap();
}


// rather than sampling the flow map directly we rescale it 
// relying on the bilinear interpolation algorithm built into Processing ...
// ( so we get smooth curves and borders, even for extreme zoom values )

void updateFlowmap() {
  float fw = ff0.width / 2f;
  float fh = ff0.height / 2f;  
  float fzoom = zoom * max(w/fw, h/fh);
  ff.beginDraw();
  ff.background(0);
  ff.image(ff0, int(tx + w - fw*fzoom), int(ty + h - fh*fzoom), int(ff0.width * fzoom), int(ff0.height * fzoom));
  ff.endDraw();
}


// the flow map function

float[] f(float x, float y, int w) {
  if ( x<0 | x>width | y<0 | y>width ) return new float[] {0, 0};
  else { 
    color c = ff.get((int)x, (int)y);
    float ang = hue(c) +  HALF_PI / xhatch * w;
    if(ang>TWO_PI) ang-=TWO_PI;
    float d = brightness(c);
    return new float[] { d, ang };
  }
}


// transformations

void zoom(float z) {
   zoom *= z; 
   tx *= z; 
   ty *= z;
   updateFlowmap();
}


void move(int dx, int dy) {
  tx += dx; 
  ty += dy;
  updateFlowmap(); 
}


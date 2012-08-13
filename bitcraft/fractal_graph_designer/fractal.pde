

 /////                           /////
 //                                 //
 //          F R A C T A L          //
 //                                 //
 /////                           /////

 // draw a fractal graph 
 // using an iterated function system.


PMatrix2D[] mat;


/////  f r a c t a l   f u n c t i o n s  /////
  
void fractalDraw() {
  
  // set recursion and stroke
  int d = mousePressed ? min(depth, dragdepth) : depth;
  float o =  opacity/2 * pow(2, 1f/d);
  stroke(c2, o);
 
  // get control points and IFS matrices
  PMatrix2D mm = getUnitMatrix(k1.x, k1.y, k2.x, k2.y);
  getPoints(mm);
  getMatrices();
  
  // draw the fractal
  pushMatrix();
    applyMatrix(mm);
    fractaline(d);
  popMatrix();
  
}


// recursive function

void fractaline(int d) {
  if(d==0) 
    line(0, 0, 1, 0);
  else {
    for(int i=0; i<m; i++) { 
      pushMatrix();
      applyMatrix(mat[i]);
      fractaline(d-1);
      popMatrix();
    }
  }
}


// transform knob positions (screen coordinates) 
// to control points (norm coordinates)

void getPoints(PMatrix2D mm) {
  PMatrix2D m2 = mm.get();
  m2.invert();
  for(int i=0; i<n; i++) {
    Knob k = getKnob(i);
    k.px = m2.multX(k.x, k.y);
    k.py = m2.multY(k.x, k.y);
  } 
}


// precalculate transformation matrices

void getMatrices() {
  mat = new PMatrix2D[m];
  for(int i=0; i<m; i++) {
    Link l = getLink(i);
    Knob a = l.k1, b = l.k2;
    mat[i] = getUnitMatrix(a.px, a.py, b.px, b.py); 
  }    
}


// get a matrix that maps <0,0> <1,0> to <x1,y1> <x2,y2>

PMatrix2D getUnitMatrix(float x1, float y1, float x2, float y2) {
  return getMatrix(x1, y1, x2, y2, true); 
}

PMatrix2D getMatrix(float x1, float y1, float x2, float y2) {
  return getMatrix( x1, y1, x2, y2, false); 
}

PMatrix2D getMatrix(float x1, float y1, float x2, float y2, boolean scaled) {
  float ang = atan2(y2-y1, x2-x1);
  float d = dist(x1, y1, x2, y2);
  PMatrix2D m = new PMatrix2D();
  m.translate(x1, y1);
  m.rotate(ang);
  if(scaled) m.scale(d);
  return m;
}



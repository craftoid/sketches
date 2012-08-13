
/////////////////////////////////////////////////////////////////////////////
//                                                                         //
//    Quick Symmetry mapping - for incremental rotational symmetery        //
//                                                                         //
/////////////////////////////////////////////////////////////////////////////

float[] sinus =   { 0, sin(TWO_PI/1), sin(TWO_PI/2),  sin(TWO_PI/3),  sin(TWO_PI/4),  sin(TWO_PI/5),  sin(TWO_PI/6) };
float[] cosinus = { 0, cos(TWO_PI/1), cos(TWO_PI/2),  cos(TWO_PI/3),  cos(TWO_PI/4),  cos(TWO_PI/5),  cos(TWO_PI/6) };

int getSymmetry(int i, int w, int h) {
  if(symmetry <= 1) return i;
  if(symmetry == 2) return n - 1 - i;
  int x1 = i % w;
  int y1 = i / w;
  float dx = x1 - w/2;
  float dy = y1 - h/2;
  int x2 = w/2 + (int)(dx * cosinus[symmetry] + dy * sinus[symmetry]);
  int y2 = h/2 + (int)(dx * -sinus[symmetry] + dy * cosinus[symmetry]);
  int j = x2 + y2 * w;
  return j<0 ? j+n : j>=n ? j-n : j;
}


void symmetry() {
  if(symmetry <=1) return;
  for(int i = 0; i < n; i++) {
    grid[i] = grid[i] * .9 + grid[getSymmetry(i, w, h)] * .1;
  }
}

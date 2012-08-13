
/// PARAMERIC SHAPE ///

abstract class shapeFn {
  float[] r, rbackup, rmax;
  int[] p;
  int min=0, max=100, maxp = 3;
  String[] labels = {};
  float r0, resRatio = 1;
  shapeFn(float _r0, float[] _r, String[] _labels) {
    r0 = _r0; labels = _labels; r = _r;
    int n = r.length;
    rmax = new float[n]; p = new int[n];
    for (int i=0; i<n; i++) {rmax[i] = max; p[i] = maxp; }
    backup();
  }
  
  abstract float[] eval( float u, float v);
  
  void modify(int i, float delta) {
    if(i<r.length) {
      int f = min(precision, p[i]);
      r[i] = round(r[i] + pow(10,-precision) * delta, f);
      limit(i);
    }
  }
  void limit(int i) {
    r[i] = constrain(r[i], 0, min(rmax[i],max));
  }
  void backup() {
    rbackup = new float[r.length]; 
    arrayCopy(r, rbackup);
  }
  void reset() {
    arrayCopy(rbackup, r);
  } 
  float getRatio() { 
    return resRatio; 
  }
  String getName() {
     return split(getClass().getName(),"$")[1];
  }
}

float round(float n, int d) { return round(n*pow(10,d))/pow(10,d); }

/// SHAPE JUKEBOX ///
  
class fnCycle extends ArrayList {
  int current = 0;
  shapeFn next() {
    shapeFn r = (shapeFn) get(current);
    current = (current + 1) % size();
    return r;
  }
}


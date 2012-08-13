
/// SUPERSHAPES ///

class supershape extends shapeFn {
  supershape(float zoom, float m1, float n11, float n12, float n13, float m2, float n21, float n22, float n23) {
    super( zoom, 
      new float[] {m1, n11, n12, n13, m2, n21, n22, n23},
      new String[] {"m1", "n11", "n12", "n13", "m2", "n21", "n22", "n23"}
    );
  }
  float[] eval(float u, float v)  {
    return superduperformula(r0, u, v, 1, 1, 0, r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], 0, 0, 0, 0);
  } 
}

class supershell extends shapeFn {
  supershell(float zoom, float m1, float n11, float n12, float n13, float m2, float n21, float n22, float n23, float t, float d1, float d2, float c) {
     super( zoom,
       new float[] {m1, n11, n12, n13, m2, n21, n22, n23, t, d1, d2, c},
       new String[] {"m1", "n11", "n12", "n13", "m2", "n21", "n22", "n23", "t", "d1", "d2", "c"}
     );
     rmax[11] = 10;
  } 
  float[] eval(float u, float v)  {
    return superduperformula(r0, u, v, r[11], 1, 0, r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], 0, r[8], r[9], r[10]);
  }
  float getRatio() { 
    return r[11]; 
  }
}

class superdonut extends shapeFn {
  superdonut(float zoom, float m1, float n11, float n12, float n13, float m2, float n21, float n22, float n23, float t, float c) {
    super( zoom,
      new float[] {m1, n11, n12, n13, m2, n21, n22, n23, t, c},
      new String[] {"m1", "n11", "n12", "n13", "m2", "n21", "n22", "n23", "t", "c"}
    );
    rmax[9] = 10;
  } 
  float[] eval(float u, float v)  {
    return superduperformula(r0, u, v, 1, 2, r[9], r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], 0, 0, 0);
  }
  float getRatio() { 
    return r[8]; 
  }   
}

class superduper extends shapeFn {
  superduper(float zoom, float m1, float n11, float n12, float n13, float m2, float n21, float n22, float n23, float t1, float t2, float d1, float d2, float c1, float c2, float c3) {
    super(zoom,
      new float[] {m1, n11, n12, n13, m2, n21, n22, n23, t1, t2, d1, d2, c1, c2, c3},
      new String[] {"m1", "n11", "n12", "n13", "m2", "n21", "n22", "n23", "t1", "t2", "d1", "d2", "c1", "c2", "c3"}
    );
   rmax[12] = 10; rmax[13] = 2; rmax[14] = 10;  
   
  } 
  float[] eval(float u, float v)  {
    return superduperformula(r0, u, v, r[12], r[13], r[14], r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11]);
  }
  float getRatio() { 
    return r[12] * sqrt(1 + r[14]); 
  }   
}
  

/// HELPER FUNCTIONS ///

float superformula(float phi, float a, float b, float m, float n1, float n2, float n3) {
   return pow(pow(abs(cos(m * phi / 4) / a), n2) + pow(abs(sin(m * phi / 4) / b),n3), - 1/n1);
}

float[] superduperformula(
  float r0, float u, float v, 
  float c1, float c2, float c3, 
  float m1, float n11, float n12, float n13, 
  float m2, float n21, float n22, float n23, 
  float t1, float t2, float d1, float d2
  ) {
    float t2c = r0 * pow(c2, d2) * t2 * c1 / 2;
    t2 =  t2 * c1 * u;
    d1 = pow(u * c1, d1); 
    d2 = pow(u * c2, d2);
    u = lerp(-PI , PI, u) * c1;
    v = lerp(-HALF_PI, HALF_PI, v) * c2;
    float v2 = v + c3 * u;
    float r1 = superformula(u, 1, 1, m1, n11, n12, n13);
    float r2 = superformula(v, 1, 1, m2, n21, n22, n23);
    float x = r0 * r1 * (t1 + d1 * r2 * cos(v2)) * sin(u);
    float y = r0 * r1 * (t1 + d1 * r2 * cos(v2)) * cos(u);
    float z = r0 * d2 * (r2 * sin(v2)  - t2) + t2c;
    return gPoint(x,y,z); 
  }
  
// limit coords to prevent processing bug
float[] gPoint(float x, float y, float z) { 
  float pmax=MAX_INT;
  return new float[] {constrain(x, -pmax, pmax), constrain(y, -pmax, pmax), constrain(z, -pmax, pmax)};
}


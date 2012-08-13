
class Gear {

  float x, y, ang, r, spin;
  int cogs;

  Gear(float _x, float _y, int _cogs, float _spin) {
    x = _x; y = _y;  cogs = _cogs; spin = _spin;
    r = cogs * wcog / PI;
  }
    
  Gear(float _x, float _y) {
    this(_x, _y, 6, 1); 
  }

  // set the radius as close to r as possible
  void setRadius(float _r) {
    cogs = int(_r * PI / wcog);
    r = cogs * wcog / PI;  //  the actual radius is determined by the number of cogs
  }

  void draw() {
    int n = cogs * steps; 
    float rbase = r - hcog/2; // inner radius
    beginShape();
    for (int i = 0; i < n; i++) {
      float t = map(i, .5, n + .5, 0, TWO_PI);
      float[] v = gear(x, y, rbase, hcog, cogs, ang, t);
      vertex(v[X], v[Y]);
    }
    endShape();
  }  

  // rotate a tiny step in spin direction
  void step() {
    ang += TWO_PI * spin / steps / cogs / wcog * speed;
  } 

  // maximum radius we could expand to without touching non-connected gears
  float maxRadius(Gear connected) {
    float rmax = MAX_FLOAT;
    for (Gear g : gears) {
      if (g == this || g == connected) continue;
      float d = dist(x, y, g.x, g.y) - g.r - hcog;
      rmax = min(rmax, d);
    }
    return rmax;
  }
}


// function to draw a gear at (x, y) with inner radius r, rotated by ang.
// this is a parametric function of t [0 .. TWO_PI]

float[] gear(float x, float y, float r, float hcog, int cogs, float ang, float t) {
  float u = (t * cogs) / TWO_PI;
  float d = u - floor(u) < .5 ? hcog : 0;
  x += cos(t + ang) * (r + d);
  y += sin(t + ang) * (r + d);
  return new float[] {x, y};
} 


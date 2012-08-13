
class Vignette extends MorphShape {
  
  float x, y, w, h;
  int maxiter;
  
  Vignette(float _x, float _y, float _w, float _h, int _maxiter) {
    maxiter = _maxiter; x = _x; y = _y;  w = _w; h = _h;
   
    // adapt number of samples to complexity of the shape
    int step = (maxiter < 3 || maxiter == MAXITER) ? 1 : 2;
    samples = 8 * (1 << maxiter) / step;
    MorphShape(samples);
  }
 
  // the parametric function for 2d vignettes

  float[] function(float t) {
    
    // a circlular disk
    float x = sin(t *TWO_PI) * radius;
    float y = cos(t* TWO_PI) * radius;
    
    int n = min(maxiter, iter);
    
    for(int j = 0; j < n; j++) {
      
      // frequency doubles with each iteeration
      float freq = 1 << j ;
      
      // amplitude getting smaller ...
      float amplitude = 1.0 / (j + 1);
      
      // the actual shape is determined by composition of the phase shifts ...
      int xshift = (2*j);
      int yshift = (2*j) + 1;
      int xbit = (rule >> xshift) & 1;
      int ybit = (rule >> yshift) & 1;
  
      float xphase = xbit * PI;
      float yphase = ybit * PI;
      
      // summing up the components (fourrier style)
      x += sin(t * TWO_PI * freq + xphase) * amplitude;
      y += cos(t * TWO_PI * freq + yphase) * amplitude;
    }
    return new float[] { x, y };
  }
  
  void draw(float px) {
    
    // rescale the vignette so it fits in nicely
    float zoom = min(w, h);
    float rescale = 1f /5.5 / pow(radius + 1, .6);
    updateShape(tweening ? tweenspeed : 1, rescale * zoom);
    pushMatrix();
      translate(x + w/2, y + h/2);
      if(colors) {
        // shape with an extrabold outline
        noFill(); stroke(color(0, 127)); strokeWeight(4.0 * px); drawShape();
        fill(255); stroke(color(0, 63)); strokeWeight(1.0 * px); drawShape();
      } else {
        // just the curve
        noFill(); stroke(color(0)); strokeWeight(1.0 * px); drawShape();
      }
    popMatrix();
  }
}
  

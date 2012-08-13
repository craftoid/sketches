
// all morphing magic happens here ...

abstract class MorphShape {
  float [][] shapeMemory;
  int samples;
  
  void MorphShape(int _samples) {
    samples = _samples;
    shapeMemory = new float[samples][2];
  }  
    
  void updateShape(float tween, float zoom) {
    for(int i = 0 ; i < samples; i++) {
      float[] p = shapeMemory[i];
      float t = map(i, 0, samples, 0, 1); 
      float[] v = function(t);
      p[X] = lerp(p[X], v[X] * zoom, tween);
      p[Y] = lerp(p[Y], v[Y] * zoom, tween);
    } 
  }
  
  void drawShape() {
    beginShape();
    for(int i = 0 ; i < samples; i++) {
      vertex(shapeMemory[i][X], shapeMemory[i][Y]);
    }  
    endShape(CLOSE);
  }
  
  // feel free to implement your own parametric function :)
  abstract float[] function(float t);
  
}


 ////////////////////////////////////////////////////////////////////
 //                                                                //
 //   a couple of helper functions to map screen coordinates       //
 //   back to world coordinates ...                                //
 //                                                                //
 ////////////////////////////////////////////////////////////////////


// get the Z-depth of a point on screen

float getZ(int x, int y) {
  if ( x<0 || x >= width || y<0 || y >= height) return MAX_FLOAT;
  PGraphics3D g3d = (PGraphics3D) g;
  return g3d.zbuffer[y * width + x];
}



/// INVERSE SCREEN COORDS ////

// these functions are the inverse of screenX, screenY and screenZ
// they can be used to find out where some screen coordinate 
// (such as the current mouse position) is located in space
// considering the current transformations ...


float invScreenX(float x, float y, float z) {
    
  float[] v1 = invScreenScale(x, y, z);
  float[] v2 = new float[4];
    
  PGraphics3D g3d = (PGraphics3D) g;
  PMatrix3D m1 = g3d.modelview.get();
  PMatrix3D m2 = g3d.projection.get();

  m1.invert();
  m2.invert();
  
  m1.apply(m2);
  m1.mult(v1,v2);
  
  if(v2[3] != 0) v2[0] /= v2[3];
  return v2[0];
}


float invScreenY(float x, float y, float z) {

  float[] v1 = invScreenScale(x, y, z);
  float[] v2 = new float[4];

  PGraphics3D g3d = (PGraphics3D) g;
  PMatrix3D m1 = g3d.modelview.get();
  PMatrix3D m2 = g3d.projection.get();

  m1.invert();
  m2.invert();
  
  m1.apply(m2);
  m1.mult(v1,v2);
  
  if(v1[3] != 0) v2[1] /= v2[3];
  return v2[1];
}


float invScreenZ(float x, float y, float z) {
  
  float[] v1 = invScreenScale(x, y, z);
  float[] v2 = new float[4];
    
  PGraphics3D g3d = (PGraphics3D) g;
  PMatrix3D m1 = g3d.modelview.get();
  PMatrix3D m2 = g3d.projection.get();

  m1.invert();
  m2.invert();
  
  m1.apply(m2);
  m1.mult(v1,v2);
  
  if(v1[3] != 0) v1[2] /= v1[3];
  return v1[2];
}


// rescale screen coordinates to normalized projection space {-1, 1}

float[] invScreenScale(float x, float y, float z) {
  float sx = map(x, 0, width, -1, 1);
  float sy = map(y, 0, height, -1, 1);
  float sz = map(z, 0, 1, -1, 1);
  return new float[] {sx, sy, sz, 1};
}




 /////                           /////
 //                                 //
 //        C L I P P I N G          //
 //                                 // 
 /////                           /////

 
 // workaround for P2D clipping bug 
 
void line(float x1, float y1, float x2, float y2) {
  float sx1 = screenX(x1, y1);
  float sy1 = screenY(x1, y1);
  float sx2 = screenX(x2, y2);
  float sy2 = screenY(x2, y2);
  pushMatrix();
  resetMatrix();
  clipLine(sx1, sy1, sx2, sy2);
  popMatrix();

}


// Liang-Barsky line clipping 

void clipLine(float x1, float y1, float x2, float y2) {
  
  float p, q, r;
  float u1 = 0.0, u2 = 1.0;
  float dx = (x2 - x1);
  float dy = (y2 - y1);

  float ap[] = { -1 * dx, dx, -1 * dy, dy  };
  float aq[] = { x1, width - x1, y1, height - y1 };

  for( int i=0; i<4; i++) {
    p = ap[i]; q = aq[i];
    if( p==0 && q<0 ) return;
    r = q/p;
    if(p<0) u1 = max(u1, r);
    if(p>0) u2 = min(u2, r);
    if(u1>u2) return; 
  } 
  
  if(u2 < 1) { x2 = (x1 + u2*dx); y2 = (y1 + u2*dy);}
  if(u1 > 0) { x1 = (x1 + u1*dx); y1 = (y1 + u1*dy);}
  
  try {
    super.line(x1, y1, x2, y2);
  } 
  
   // catching a very weird processing bug...
   
  catch (ArrayIndexOutOfBoundsException e) {
    println("P2D sucks.");
  }  
  
}


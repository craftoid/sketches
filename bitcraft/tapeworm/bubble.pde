

class Bubble {
  
  float x, y, r;
  int c;
 
  Bubble(float _x, float _y, float _r, int _c) {
    x = _x;
    y = _y;
    r = _r;
    c = _c; 
  }

  void move() {
    if(assemble) {
      if(c!=bblcount-1) {
        // attract to sucessor
        Bubble a = getBubble(c + 1);
        float dir = atan2(a.y-y, a.x-x);
        x += speed * cos(dir) ;
        y += speed * sin(dir) ;
      }
    } else y+= 5; // gravity
  }
  
  boolean collide() {
    
    boolean c = false;
  
    // bubble collisions
    for(int i=0; i<bubbles.size(); i++)  {
      c |= collide(getBubble(i));
    }
   
    // wall collisions
    if(x<r)  { x=r ; c = true; }
    if(x>width-r) { x = width-r; c = true; }
    if(y<r) { y = r; c = true; }
    if(y>height-r) { y = height-r; c = true; }
      
    return c;
    
  }
  
  boolean collide(Bubble a) {
    
    if(a == this) return false;  // no self collision

    float d = dist(x, y, a.x, a.y);
    float rr =  r + a.r;
    
    // correct bubble positions
    if (d<rr) {
      float t = (rr-d)/rr;
      float dx =  t * (x-a.x);
      float dy =  t * (y-a.y);
      x += dx; y += dy;
      a.x -= dx; a.y -= dy;
      return true;
    }
    return false;
  }
     
  void draw() {
    bubble(x, y, r, c);
  }
  
}


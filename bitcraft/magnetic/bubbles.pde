

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
    
    // attract to opposite charges
    int n = bubbles.size();
    for(int i=0; i<n; i++)  {
      Bubble a = getBubble(i);
      if(a==this) continue;
      float d = dist(x, y, a.x, a.y);
      float dd = min(500 / d, 1) * a.r * a.r / r / r; 
      float f = (c != a.c) ? dd : -dd;
      float dir = atan2(a.y-y, a.x-x);
      x += f * cos(dir) ;
      y += f * sin(dir) ;
    }
   
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
    bubble(x, y, r, c>0 ? c1 : c2);
  }
  
}


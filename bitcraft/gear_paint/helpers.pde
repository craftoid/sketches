
boolean setPosition(int x, int y) {
  
  // We try to locate the gear as close as possible to (x, y)
  // while satisfying distance constraints towards the other gears.
  // Note: this process is implicitly iterative.
  
  Gear g1 = picked;
  
  // find the nearest gear 
  Gear g2 = nearest(x, y);
  
  // Primum Movens
  if(g2 == null) {
   
    // move the cursor
    g1.x = x;
    g1.y = y;
    
    // and resize it softly
    g1.setRadius(lerp(picked.r,RMIN, tweening));
    
    return true;
  }
    
  // calculate radius needed to touch g2 (using target coordinates)
  float dx = x - g2.x;
  float dy = y - g2.y;
  float rtouch = mag(dx, dy) - g2.r;

  // calculate maximum radius possible without touching any other gears.
  // We are using the actual gear coordinates so the center of the gear 
  // can converge over the course of several iterations.
  float rmax = g1.maxRadius(g2);  

  // the new radius
  float rnew = min(rtouch, rmax, RMAX);

  // is the new radius big enough for a new gear?
  if (rnew >= RMIN) {
    
    g1.setRadius(rnew);
    
    // distance between the gear centers
    float d = rnew + g2.r;
    
    // angle between gear-axis and the x-axis
    float ang = atan2(dy, dx);
    
    // align the angular rotation
    g1.ang = PI + ((ang - g2.ang) * g2.r + ang * g1.r) / g1.r;
    
    // align direction of rotation
    g1.spin = -g2.spin;
    
    // move the gear center to its new location
    g1.x = g2.x + cos(ang) * d;
    g1.y = g2.y + sin(ang) * d;

    return true;
  }
  
  // otherwise just move the cursor
  g1.x = x; g1.y = y;
  return false;
}


// find the gear that is closest to the point (x, y)
// or return null if there's no gear in the vicinity
Gear nearest(int x, int y) { 
  float dmax = RMAX;
  Gear result = null;
  for (Gear g : gears) {
    if (g == picked) continue;
    float d = dist(x, y, g.x, g.y) - g.r;
    if (d < dmax) {
      result = g; 
      dmax = d;
    }
  }
  return result;
}


// drawing the cursor gear
void gearCursor() {
  noCursor();
  fill(cursorcolor);
  picked.step();
  picked.draw();
}


// creating a new gear from the cursor 
void createGear() {
  gears.push(picked);
  picked = new Gear(picked.x, picked.y);
}




 /////                           /////
 //                                 //
 //          L I N K S              //
 //                                 //
 /////                           /////

 // interactive edges of the graph


int m; // number of links
boolean showLinks = true;
boolean showDirection = true;
ArrayList links = new ArrayList();
Link activeLink;


/////  l i n k   c l a s s  /////

public class Link {
  
  Knob k1, k2;
  
  Link(Knob _k1, Knob _k2) {
    k1 = _k1; 
    k2 = _k2;
  }
  
  
  void draw() {
    stroke(c1, opacity);
    if(!showLinks) return;
    if(showDirection)
      arrow(k1.x, k1.y, k2.x, k2.y);
    else
      line(k1.x, k1.y, k2.x, k2.y);

  }
  
  
  // check if the mouse position lies within some 
  // distance from the line (and from its endpoints)
  
  boolean inside() {
    float t = 3; // max distance
    float d = dist(k1.x, k1.y, k2.x, k2.y);
    PMatrix2D m = getMatrix(k1.x, k1.y, k2.x, k2.y);
    m.invert();
    float x = m.multX(mouseX, mouseY);
    float y = m.multY(mouseX, mouseY);
    return (x > -t && x <(d+t) && y>-t && y<t);
  }
  
  
  void mouseEvent(MouseEvent event) {
    
    int e = event.getID();
    
    if(e == MouseEvent.MOUSE_PRESSED && inside() && active != k1 && active != k2) { 
      switch(mouseButton) {
        case LEFT : 
          activeLink = this;
          break;
        case RIGHT :
          deleteLink(this);
          break;
        }
      }
  }
  
}


/////  l i n k   f u n c t i o n s  /////


void resetLinks() {
  while(m>0) removeLink(getLink(0));
  createLinks();
}


void createLinks() {
  int m0 = n0-1;
  for(int i=0; i<m0; i++) createLink(getKnob(i), getKnob(i+1));
}


void createLink(Knob a, Knob b) {
  if(a==b) return;                   // avoid selvedges
  if(getLink(a, b) != null) return;  // avoid multiple edges
  Link l = new Link(a, b);
  links.add(l);
  registerDraw(l);
  registerMouseEvent(l);
  resetCursor();
  m++;
}


// delete a link taking care of the connected knobs

void deleteLink(Link l) { 
  removeLink(l);
  if (countLinks(l.k2) == 0) deleteKnob(l.k2);
  if (countLinks(l.k1) == 0) deleteKnob(l.k1);
}


void removeLink(Link l) {
  links.remove(l);
  unregisterDraw(l);
  unregisterMouseEvent(l);
  m--;
}


Link getLink(int i) {
  return (Link) links.get(i);
}


Link getLink(Knob a, Knob b) {
  for(int i=0; i<m; i++) {
    Link l = getLink(i);
    if(l.k1==a && l.k2 == b) return l;
  } 
  return null;
}


int countLinks(Knob k) {
  return inLinks(k) + outLinks(k); 
}

int inLinks(Knob k) {
  int in = 0;
  for(int i=0; i<m; i++) if (getLink(i).k1 == k) in++;
  return in;
}


int outLinks(Knob k) {
  int out = 0;
  for(int i=0; i<m; i++) if (getLink(i).k2 == k) out++;
  return out;
}


// draw an arrow to indicate link direction

void arrow(float x1, float y1, float x2, float y2) {
 PMatrix2D m = getMatrix(x1, y1, x2, y2);
 float w = 12, d = dist(x1, y1, x2, y2) - w;
 if(d<0) { w = d+w; d = 0; } // extremely small distances
 float h = w * .4;
 pushMatrix();
   applyMatrix(m);
   fill(255);
   line(0, 0, d, 0);
   beginShape();
     vertex(d, +h);
     vertex(d+w, 0);
     vertex(d, -h);
   endShape(CLOSE);
  popMatrix();
 
}



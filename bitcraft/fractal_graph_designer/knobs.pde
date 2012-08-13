

 /////                           /////
 //                                 //
 //          K N O B S              //
 //                                 //
 /////                           /////
  
 // interactive nodes of the graph


int n;  // number of knobs
boolean showKnobs = true;
ArrayList knobs = new ArrayList();

Knob active, active2, k1, k2;



/////  k n o b   c l a s s  /////

public class Knob {
  
  float x, y, r = 5;
  float px, py;


  void move(int _x, int _y) {
    x = _x; y = _y; 
  }
  
  
  void draw() {
    if(!showKnobs) return;
    stroke(this == active || this == active2 ? c3 : c1, opacity);
    
    // draw regular knobs as x-shape
    
    line(x-r, y-r, x+r, y+r);
    line(x-r, y+r, x+r, y-r);
    
    // draw anchor knobs as asterisk
    
    if(this == k1 || this == k2) {
      float r2=r*1.4;
      line(x, y-r2, x, y+r2);
      line(x-r2, y, x+r2, y);
    }
  }
  
  
  // check if the mouse is inside the knob
  
  boolean inside() {
    return  dist(mouseX, mouseY, x, y) <= 1.4 * r;
  }
  
  
  void mouseEvent(MouseEvent event) {

    int e = event.getID();
               
    // activate the knob
    if (e == MouseEvent.MOUSE_PRESSED && inside()) {
      active = this;
    }
   
    /// single knob interaction ///
    
    else if(active==this) {
      switch(mouseButton) {
        case LEFT:
          switch(e) {
            case MouseEvent.MOUSE_DRAGGED : // move knob
              x = mouseX;
              y = mouseY;
              break;
            }
          break;
        case RIGHT:
          switch(e) {   
            case MouseEvent.MOUSE_DRAGGED : // deactivate knob
              active = null;
              mouseEvent(event);
              break;
            case MouseEvent.MOUSE_RELEASED : // delete knob    
              if(inside()) deleteKnob(this);
              break;
          }
          break;
      }       
    } 
    
    
    /// collective knob interaction ///
    
    else if (active==null) {
      if(e == MouseEvent.MOUSE_DRAGGED && activeLink==null) 
      switch(mouseButton) {
        case RIGHT : // move knob positions
          x += mouseX - pmouseX;
          y += mouseY - pmouseY;
          break;
        case CENTER : // scale knob positions
          x -= (x - ppmouseX) * (mouseY - pmouseY) / h;
          y -= (y - ppmouseY) * (mouseY - pmouseY) / h;
          break;
      }
    } 
    
    /// interaction involving two knobs ///
    
    else if(mouseButton == CENTER) {
      switch(e) {
        case MouseEvent.MOUSE_DRAGGED : // pick the second active knob
          active2 = inside() ? this : active2==this ? null : active2;
          break;
        case MouseEvent.MOUSE_RELEASED : // connect the two active knobs
          if (inside()) {
            createLink(active, this);
            active = null; active2 = null; // prevent additional activity
          }
          break;
      }
    }
  }
}



/////  k n o b   f u n c t i o n s  /////


void resetKnobs() {
  while(n>0) removeKnob(getKnob(0));
  createKnobs(n0);
  for(int i=0; i<n; i++) getKnob(i).move(width*(i+1)/(n+1), (int) random(h*.5, h*1.5));
}


void createKnobs(int n) {
   for(int i=0; i<n; i++) createKnob();
   k1 = getKnob(0);
   k2 = getKnob(n-1);
}


Knob getKnob(int i) {
  return (Knob) knobs.get(i); 
} 


Knob createKnob() {
  Knob k = new Knob();
  knobs.add(k);
  registerDraw(k);
  registerMouseEvent(k);
  resetCursor();
  n++;
  return k;
}


// delete a knob taking care of the connected links

void deleteKnob(Knob k) { 
  
  int in = inLinks(k);
  int out = outLinks(k);
  
  if( k==k1 || k==k2 ) return; // do not remove anchor knobs
  if(in > 1 || out >1) return; // do not remove multiply connected knobs
  
  rewireLinks(k); 
  removeKnob(k);

}


void removeKnob(Knob k) {
  knobs.remove(k);
  unregisterDraw(k);
  unregisterMouseEvent(k);
  n--;
}


Knob createKnob(int x, int y) {
  Knob k = createKnob();
  k.move(x, y);
  return k;
}


void rewireLinks(Knob k) {
  Link a = null, b = null;
  for(int i=0; i<m; i++) {
    Link l = getLink(i);
    if (l.k2 == k) a = l; // incoming link
    if (l.k1 == k) b = l; // outgoing link
  }
  if(a!=null && b!=null) createLink(a.k1, b.k2); // rewire
  if(b!=null) removeLink(b); 
  if(a!=null) removeLink(a);
}




 /////                           /////
 //                                 //
 //          C U R S O R            //
 //                                 // 
 /////                           /////

 // provide visual feedback 
 // for graph manipulation.


Cursor cur = new Cursor();
int ppmouseX, ppmouseY; // previous mouse pressed position


/////  c u r s o r   c l a s s  /////

public class Cursor {

  void draw() {
    
    stroke(c3, opacity);
    
    if (active != null) {
      if(mousePressed && mouseButton == CENTER) {
        arrow(active.x, active.y, mouseX, mouseY); 
      }
    }
    else if (mousePressed) {
      int x = mouseButton == CENTER ? ppmouseX : mouseX;
      int y = mouseButton == CENTER ? ppmouseY : mouseY;
     
      line(0, y, width, y);
      line(x, 0, x, height); 
    }
    
  }
  
}


/////  c u r s o r   f u n c t i o n s  /////
  
void resetCursor() {
  unregisterDraw(cur);
  registerDraw(cur); 
}



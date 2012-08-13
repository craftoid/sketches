
 ////////////////////////////////////////////////////////////////////
 //                                                                //
 //   event handling functions to pass mouse and key events        //
 //   to the main sketch, the sketch jockey, or both ...           //
 //                                                                //
 ////////////////////////////////////////////////////////////////////


// We use [ENTER] and [ESCAPE] to switch between control modes.

// The control switch for mouse / keyboard interaction captures the 
// handleKeyEvent and handleMouseEvent methods of PApplet.
// Those methods are used to handle key and mouse events 
// and pass them on to keyPressed() mouseDragged() etc.


final static int CTRL_MIXED=3, CTRL_GLOBAL=2, CTRL_SKETCH=1;
int control= CTRL_MIXED;

void handleKeyEvent(KeyEvent event) {

  
  if(event.getID() == KeyEvent.KEY_PRESSED) {
    
    // switch  ( local -> global -> mixed ) by pressing [ESCAPE]
    if(event.getKeyChar() == KeyEvent.VK_ESCAPE) {
        // if(control==CTRL_MIXED && !online) exit(); // use [ESCAPE] to exit the sketch
        control = min(control+1, CTRL_MIXED);
        return;
    }
    
    // switch ( mixed -> global -> local ) by pressing [ENTER]
    if(event.getKeyChar() == KeyEvent.VK_ENTER) {
      control = max(control-1, CTRL_SKETCH);
      return;
    }
  }
  
  // interaction pass through 
  if((control & CTRL_GLOBAL) > 0) super.handleKeyEvent(event);
  if((control & CTRL_SKETCH) > 0) sjay.handleKeyEvent(event);
  
}

void handleMouseEvent(MouseEvent event) {
  
   // mouse interaction pass through 
   if((control & CTRL_GLOBAL) > 0) super.handleMouseEvent(event);
   if((control & CTRL_SKETCH) > 0) sjay.handleMouseEvent(event);
   
}

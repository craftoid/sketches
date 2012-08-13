
///// DIVING MODE //////

void flyThrough() {

  rotateMouse();
  mouseButtons();

  if (mousePressed) { 
    if (julia && shiftPressed()) {

      // scale julia param
      if (mouseButton == LEFT) { 
        jx +=  map(rmouseX,0, width, -mr, +mr) / fps;  
        jy +=  map(rmouseY,0, height, -mr, +mr) / fps; 
      }

      // scale julia param in opposite direction
      if (mouseButton == RIGHT) { 
        jx -=  map(rmouseX,0, width, -mr, +mr) / fps;
        jy -=  map(rmouseY,0, height, -mr, +mr) / fps;
      }

      // rotate and scale julia param
      if (mouseButton == CENTER) {
        float ang = map(mouseX, 0, width, -PI/fps, PI/fps);
        float dr = pow(.70, 1f/fps);
        float d = map(mouseY, 0, height, dr, 1/dr);
        jx = d * (jx * cos(ang) - jy * sin(ang));
        jy = d * (jx * sin(ang) + jy * cos(ang));     
        println(dist(0,0,jx,jy));
      }

    } 
    else {

      // zoom in and move
      if (mouseButton == LEFT) { 
        mx +=  map(rmouseX,0, width, -mr, +mr) / fps;  // maximum horizontal speed: one window width per second
        my +=  map(rmouseY,0, height, -mr, +mr) / fps; 
        mr *= pow(.70, 1f/fps);                        
      } 

      // zoom out and move
      if (mouseButton == RIGHT) { 
        mx -=  map(rmouseX,0, width, -mr, +mr) / fps;
        my -=  map(rmouseY,0, height, -mr, +mr) / fps;
        mr /=  pow(.70, 1f/fps);  
      } 

      // zoom and rotate      
      if (mouseButton == CENTER) { 
        theta += map(mouseX, 0, width, -PI/fps, PI/fps);
        float dr = pow(.70, 1f/fps);
        mr *= map(mouseY, 0, height, dr, 1/dr);
      } 

    }
  }
}


///// DRAG MODE //////


void mouseDragged() {
  if(flying) return; 
  
  mouseButtons();
  rotateMouse();

  if(julia && shiftPressed()) {
    // drag julia params
    cursor(CROSS);
    switch(mouseButton) {
    case LEFT: // move 
      jx -= map(rmouseX - prmouseX, 0, width, 0, mr);
      jy -= map(rmouseY - prmouseY, 0, height, 0, mr);
      break;
    case RIGHT: // scale julia params
      float d = float(rmouseY - prmouseY) / height;
      jx *= 1 + d;
      jy *= 1 + d;
      break;
    case CENTER: // rotate julia params
      float ang = 2 * (atan2(mouseX - cx, mouseY - cy) - atan2(pmouseX - cx, pmouseY - cy)); 
      float temp = jx * cos(ang) + jy * sin(ang);
      jy = jx * -sin(ang) + jy * cos(ang);
      jx = temp;
      break;
    }

  } 
  else {

    // drag sampling window
    cursor(HAND);
    switch(mouseButton) {
    case LEFT: // move
      mx -= map(rmouseX - prmouseX, 0, cx, 0, mr);
      my -= map(rmouseY - prmouseY, 0, cy, 0, mr);
      break;
    case RIGHT: // zoom
      float d = float(mouseY - pmouseY) / height;
      mr *= 1 + d;
      break;
    case CENTER: // rotate 
      theta += atan2(rmouseX - cx, rmouseY - cy) - atan2(prmouseX - cx, prmouseY - cy) ;   
      break;
    } 
  }
}

void mouseReleased() {
  if(!flying) cursor(ARROW); 
}


/// MOUSE HACKS ///

// add a mousewheel listener ...
void useMouseWheel() {
  addMouseWheelListener(new java.awt.event.MouseWheelListener() { 
    public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt) { 
      mouseWheel(evt.getWheelRotation());
    }
  }
  ); 
}

// use the mousewheel for rotation
void mouseWheel(int delta) {

  float ang = PI / 24 * delta;

  if(julia && shiftPressed()) {
    float temp = jx * cos(ang) + jy * sin(ang);
    jy = jx * -sin(ang) + jy * cos(ang);
    jx = temp;
  } 
  else {
    theta -= ang;
  }
}


// map mouse motions to our rotated coordinate system
void rotateMouse() {
  rmouseX = cx + int(cosinus * (mouseX-cx) - sinus * (mouseY-cy));
  rmouseY = cy + int(sinus * (mouseX-cx) + cosinus * (mouseY-cy));
  prmouseX = cx + int(cosinus * (pmouseX-cx) - sinus * (pmouseY-cy));
  prmouseY = cy + int(sinus * (pmouseX-cx) + cosinus * (pmouseY-cy));
}

// make mac users happy ( mapping modifier keys to mouse buttons )
void mouseButtons() {
  // we have to access the keyEvent directly since processing does not allow to 
  // check for multiple modifier keys at once ...
  if (keyPressed && (keyEvent.getModifiers() & KeyEvent.CTRL_MASK) > 0) mouseButton = CENTER;
  if (keyPressed && (keyEvent.getModifiers() & KeyEvent.ALT_MASK) > 0) mouseButton = RIGHT;
}

boolean shiftPressed() {
  return keyPressed && ((keyEvent.getModifiers() & KeyEvent.SHIFT_MASK) > 0);
}


/// KEYBOARD INTERACTION ///

void keyPressed() {
  switch(key) {
  case 'a': // animate the palette
    startcolor += maxcolors-1; 
    break;
  case 'A':
    startcolor++; 
    break;
  case 's': // smooth colors
    createPalette(maxcolors + 1);
    break;
  case 'S':
    createPalette(maxcolors - 1);
    break;
  case 'd': // deep thought
    maxiterations++ ; 
    break;
  case 'D': 
    maxiterations-- ; 
    break;
  case 'f': // browsing mode 
    flying =! flying; 
    if(flying) noCursor(); else cursor(ARROW);
    break;
  case 'g':
  case 'h':
    goHome();
    break;
  case 'j': // julia mode
    julia =! julia;
    break;
  case 'c': // capture
    saveFrame(screenshotName);
    break;
  case 'C': // capture hires
    saveScreenshot(screenshotName);
    break;
  case 'R': // start recording
    recording = true;
    break;
  case 'r': // stop recording
    recording = false;
    break;
  }
    

}



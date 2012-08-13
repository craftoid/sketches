
/////////////////////////////////////////////////////////////////////////////
//                                                                         //
//                     Mouse and Keyboard Interaction                      //
//                                                                         //
/////////////////////////////////////////////////////////////////////////////


////////////////////////// mouse interaction ////////////////////////////////

int imgMouseX, imgMouseY;
boolean drawing;

void interaction() {
  // interaction inside the image
  imgMouseX = mouseX - spacing;
  imgMouseY = mouseY - spacing;
  cursor (drawing ? CROSS : ARROW);
  if(mousePressed) mouseDown();
}

boolean insideImage() {
  return imgMouseX>0 && imgMouseX < imgWidth && imgMouseY > 0 && imgMouseY < imgHeight; 
}

void mousePressed() {
  if(mouseButton!=CENTER) {
    drawing = insideImage();
  }
}

void mouseReleased() {
  drawing = false; 
}

void mouseDragged() {
  if (mouseButton==CENTER) {
    colorOffset += 256 * (dist(pmouseX, pmouseY, mouseX, mouseY) / width);
  }
}

void mouseDown() {
  
  // add a circular drop of chemical
  
  if(drawing && mouseButton != CENTER) {
  int x0 = imgMouseX / resolution;
  int y0 = imgMouseY / resolution;
  int brushIndex = levels - 4 + constrain(brush, 1, 3);
  int r = radii[brushIndex] / resolution;
  int xmin = max(0, x0-r), xmax = min(w, x0+r);
  int ymin = max(0, y0-r), ymax = min(h, y0+r);
  for(int y = ymin; y < ymax; y++) for(int x = xmin; x < xmax; x++) {
      if(dist(x, y, x0, y0) < r)
        grid[x + w*y] = mouseButton == LEFT ? gmax : gmin;
    }
  }
}


////////////////////////// keyboard interaction /////////////////////////////

void keyPressed() {
  
  switch( key ) {
    
    case ' ': resetParams(true); break;
    
    case 'c': colMode = !colMode; break;
    case 'i': invertMode = !invertMode; break;
    
    case 'l': resolution = 2; resetParams(); break;
    case 'h': resolution = 1; resetParams(); break;
    
    case '+': brush = min(3, brush+1); break;
    case '-': brush = max(1, brush-1); break;

    
    case 'q': stepOffset += .001; break;
    case 'w': stepScale += .001; break;
    case 'e': blurFactor += .01; break; 
    case 'r': colorOffset =  (colorOffset + 1) % 256; break;
    
    case 'a': stepOffset -= .001; break;
    case 's': stepScale -= .001; break;
    case 'd': blurFactor -= .01; break;
    case 'f': colorOffset = (colorOffset + 256 - 1) % 256; break;
    
    default:
      // select symmetry via number keys
      if(key>='0' && key <= '6') {
        symmetry = key - '0';
        if(symmetry == 1) symmetry = 0;
        resetParams();
      } else return;
  }
  
  stepScale = constrain(stepScale, stepScaleMin, stepScaleMax);
  stepOffset = constrain(stepOffset, stepOffsetMin, stepOffsetMax);
  blurFactor = constrain(blurFactor, 0, 1);
  
  updateParams(); 
  updateControls();
}


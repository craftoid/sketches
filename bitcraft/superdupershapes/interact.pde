
/// INTERACTION ///

boolean navigationMode = true;
int precision = mousePrecision[0];
int paramKey=0;
String paramKeys = "1234qwerasdf789";

// FRAME-BASED INTERACTION 

void interact() {    
  if( mousePressed && !navigationMode) {
    fn.modify(paramKey, mouseX-pmouseX-mouseY+pmouseY);
    updateMesh();
  } 
}


// EVENT-BASED INTERACTION 

void keyPressed() {
  if (keyCode == 112) key='h'; // F1
  switch(key) {
    case ' ': fn = fns.next(); updateMesh(); break;
    case 'u': fn.reset(); updateMesh(); break;
    case 'm': mode = (mode+1) % 3; updateResolution(); break; 
    case 'g': grid = !grid; faces = !faces; updateImage(); break;
    case 'c': colors = !colors; updateImage();  break;
    case 'l': light = !light;  updateImage(); break;
    case 'o': output = true; updateImage(); break;
    case 'x': xchange =! xchange; break;
    case 'h': help = !help; break;    
    case 'i': info = !info; break;
    case 'p': params = !params; break;
  } 
  if(paramKey()) {
    navigationMode = false; 
    paramKey = paramKeys.indexOf(key);
  }
}

boolean paramKey() {
   return paramKeys.substring(0, fn.r.length).indexOf(key) != -1;
}

void mousePressed() {
  precision = mousePrecision[mouseEvent.getButton()-1];
  if(mode==MIXRES) updateResolution();
}

void mouseReleased() {
  precision = mousePrecision[0];
  if(mode==MIXRES) updateResolution();
}

void keyReleased() {
  if(paramKey()) navigationMode = true;
}

void mouseDragged() {
  if (navigationMode) {
    if (mouseButton == LEFT) {
      rotX -= float(mouseY-pmouseY) * 4/ height;
      rotY += float(mouseX-pmouseX) * 4/ width;
      rotX = constrain(rotX, -HALF_PI, HALF_PI);
    }
    if (mouseButton == RIGHT) {
      zoom -= float(mouseY-pmouseY) * 4/ height;
      zoom = constrain(zoom, minZoom, maxZoom);
      rotZ += ( height/2+moveY-mouseY >0 ? 1 : -1) * float(mouseX-pmouseX) * 4/ width;
    }
    if (mouseButton == CENTER) {
      moveY += float(mouseY-pmouseY) ;
      moveX += float(mouseX-pmouseX) ;
    }
    updateImage();
  }
}


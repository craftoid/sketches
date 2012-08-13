

  ////                      ////
  //                          //
  //       interaction        //
  //                          //
  ////                      ////
  

void mousePressed() { 
  showmap = true; 
}


void mouseReleased() { 
  showmap = false; 
  reset(); 
}


void mouseDragged() {
  if(mouseButton == LEFT) 
    move(mouseX - pmouseX, mouseY - pmouseY);
 else 
    zoom(1 - (mouseY - pmouseY) / h);
}


void keyPressed() {
  
  switch(key) {
    
    case ' ' : mapid++; mapid %= mapids; loadFlowmap(mapid); break;
    
    case 'd' : dodge = !dodge; break;
    case 'b' : brush = !brush; break;
    case 'g' : fine =! fine; break;
    case 'l' : lifelong =! lifelong; break;
      
    case 'c' : crayons = ++crayons %  palettes; break;
    case 'i' : isolines = ++isolines % 4; break; 
    case 'w' : whirl = ++whirl % 4; break;
    
    case 'z' :; case 'y' : xhatch = max(--xhatch, 1) ; break;
    case 'x' : ++xhatch; break;
 
    case '0' : tx = 0; ty = 0; zoom(1/zoom); break;
    case 's' : saveFrame("codex-processianus-#####.png"); break;
    
    default: return;
    
  }
  
  reset();
  
}



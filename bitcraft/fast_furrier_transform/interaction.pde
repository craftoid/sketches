

// user interaction via keyboard and mouse ...


void keyPressed() {
  
  int ppat = pat;
  
  // keys to change weights
  
  String[] keys = { "1234567", "qwertyu" };  
  int i = keys[0].indexOf(key); if(i>=0) weights[pat][i] ++; 
  int j = keys[1].indexOf(key); if(j>=0) weights[pat][j] --;

  // control keys
  
  switch(key) {
    case 'p' : presets(); break;                                 // load presets
    case 'c' : pal = (pal + 1) % palmax; return;                 // color palette
    case 'b' : borderMode = !borderMode;  break;                 // border on/off
    case 'o' : furMode(); outputMode(); break;                   // output animation
    case 'l' : drawMode(); inputMode(); break;                   // load seed image
    case 'z' : key = 'y'; keyPressed(); return;                  // quertz - keyboard
    case ENTER :
    case ' ' : if(!drawMode) drawMode(); else furMode(); break;  // switch between modes             

    case CODED :                                                 // change weight vector
      switch(keyCode) {                       
        case UP :   pat++; break;
        case DOWN : pat--; break;
        case LEFT : dirs--; break;
        case RIGHT: dirs++; break;
      }
      dirs = constrain(dirs, 3, dirmax);
      pat = constrain(pat, 0, patmax-1);
      break;
  }
  
  // output weights on the console
  if(i>=0||j>=0||pat!=ppat) println("weights: " + join(nf(weights[pat],0), ", "));
  
  reset(); // get furry!
  
}

void mousePressed() {
  drawMode();
}



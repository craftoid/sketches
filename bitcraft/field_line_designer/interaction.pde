
void keyPressed() {
  float dy = yrange / yscale;
  switch(key) {
    
    case ' ' : newcharge = charge > 0 ? -1 : 1;  break;
    case TAB:
    case '#': if(++renderMode > XYLINES) renderMode = XLINES; break;
    
    case 'f': filterMode = (filterMode + 1) % 5; break;
    case 'b': smooth = !smooth; break;
    case 'm': moiree = !moiree; break;
    case '-': edge = (edge + 1) % (res + 1); break;
    case 't': tiles = !tiles; break;
    case 'i': fgcolor ^= bgcolor; bgcolor ^=fgcolor; fgcolor ^= bgcolor; break;
    
    case 'q': above += dy; yscale++; break;
    case 'a': if(yscale > 1) above -= dy; yscale--; break;
    case 's': above -= dy; below += dy; break;
    case 'w': above += dy; below -= dy; break;
    case 'e':  if(yscale > 1) below -= dy; yscale--; break;
    case 'd': below += dy; yscale++; break;
    case 'l': limited = !limited; break;
    
    case 'g': resetGrid(); break;
    case 'r': resetNice(res); break;
    case '1': resetNice(1); break;
    case '2': resetNice(2); break;
    case 'R': reset(res); break;
    
    case CODED:
      if(keyEvent.isShiftDown()) switch(keyCode) {
        case DOWN: yscale--; renderMode |= YLINES; break;
        case UP: yscale++; renderMode |= YLINES; break;
        case LEFT: xscale--; renderMode |= XLINES;  break;
        case RIGHT: xscale++; renderMode |= XLINES; break;
      } else switch(keyCode) {
        case DOWN: yshift++; break;
        case UP: yshift --; break;
        case LEFT: xshift--; break;
        case RIGHT: xshift++; break;
      }
  }
  
  if(moiree && renderMode ==  XYLINES) renderMode = XLINES;
  
  xscale = max(xscale, 1);
  yscale = max(yscale, 1); 

}


void mousePressed() {
  if (mouseButton == LEFT)  newcharge = charge > 0 ? -1 : +1;
  if (mouseButton == RIGHT) newcharge = charge > 0 ? +1 : -1;
}


void mouseReleased() {
  addCharge(mouseX * xres, mouseY * yres, newcharge);
}

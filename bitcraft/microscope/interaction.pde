
// moving the canvas
void mouseDragged() {
  if(mouseButton==CENTER && !border) {
    dx = mod(dx - mouseX + pmouseX, width);
    dy = mod(dy - mouseY + pmouseY, height);
  }
}

void keyPressed() { 
  switch(key) {
    case ' ':;
    case 'p': pattern = (pattern + 1) % 4; break;
    case 'c': palette = (palette +1) % 4; break;
    case 'b': border = !border; dx=dy=0; break;
    case 'i': for(int i=0; i<s; i++) pat[i]=255-pat[i]; break;
    case 's': soft = !soft; break;
    case 'l': light = !light; break;
    case 'd': lightdir = (lightdir + 1) % 8; emboss(lightdir); break;
    case 'k': lux -= 1; break;
    case 'j': lux += 1; break;
    case 'f': follow3D = !follow3D; break;
    case '1': scaleZ = 1; break;
    case '2': scaleZ = 2; break;
    case '+': lim += 1; break;
    case '-': lim -= 1; break;
    case '0': lim = 128; break;
    case 'r': reset(); break;
    case CODED:
      if(keyEvent.isShiftDown()) switch(keyCode) {
        case UP: lux+=8; break;
        case DOWN: lux-=8; break;
        case LEFT:  res = min(res+1, 4); reset(); break;
        case RIGHT: res = max(res-1, 1); reset(); break;
       
      }
      else switch(keyCode) {
        case UP: detail--; break;
        case DOWN:detail++; break;
        case LEFT: scl -=1; break;
        case RIGHT: scl +=1; break;
      }
      break;
  }
  detail = constrain(detail, 0, 6);
  scl = constrain(scl, 1, 5);
  lim = constrain(lim, 0, 255);
  lux = constrain(lux, 0, 255);
  dlux = (255-lux) / 92.0;
}


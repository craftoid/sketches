
void keyPressed() {
  
  key = Character.toLowerCase(key);
 
  // querty keyboards ...
  if(key == 'z') key = 'y'; 
  
  // set individual bits using the keyboard
  int xindex = "qwertyuio".indexOf(key);
  int yindex = "asdfghjkl".indexOf(key);
  if(xindex >= 0) { 
    rule ^= 1 << (2 * (xindex % 9));
  }
  if(yindex >= 0) { 
    rule ^= 1 << (2 * (yindex % 9) + 1);
  } 
  
  switch(key) {
    case ' ': colors = !colors; tweening = !colors; break;
    case '+': radius += .5; break;
    case '-': radius -= .5; break;
    case '0': rule = 0; break;
    case TAB:
    case '1': tweening = !tweening; break;
    case '2': showlabels = !showlabels; break;
    case '3': showicons = !showicons; break;
    case 'x': flipRule(); break;
    case 'c': invertRule(); break;
    case 'v': invertRuleX(); break;
    case 'b': invertRuleY(); break;
    case 'n': negateRule(); break; 
    
    case CODED: switch(keyCode) {
      case UP: rule++; break;
      case DOWN: rule--;  break;
      case RIGHT: iter++; break;
      case LEFT: iter--; break;
    }
  }
  radius = constrain(radius, 0, maxradius);
  iter = constrain(iter, 1, MAXITER);
  
  // supersmooth transitions whenever [SHIFT] is pressed
  if(keyEvent.isShiftDown()) tweenspeed = .1;
}

void keyReleased() {
  if(! keyEvent.isShiftDown()) tweenspeed = .5;
}


/////////////////////////////////////////////////////////////////////////////

float mradius, mrule; 
void mousePressed() {
  // use extra variables for continuous interpolation ...
  mrule = rule;
  mradius = radius; 
}

void mouseDragged() { 
  float dx = mouseX - pmouseX;
  float dy = mouseY - pmouseY;
  // vertical or horizontal mouse movement ?
  if(abs(dx) > abs(dy)) {
    // horizontal -> change rule number 
    float step = 5.0;
    mrule += dx / step;
  } else {
    // vertical -> change radius
    float step = height / 2 / maxradius;
    mradius -= dy / step;
    mradius = constrain(mradius, 0, maxradius);
  }
  // obtain discrete values ...
  int maxrule =  (1 << (iter * 2)) - 1;
  rule = int(mrule) & maxrule;
  radius = round(mradius * 2) / 2.0;
}


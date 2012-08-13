
void keyPressed() {
  switch(key) {
    case ' ': setup(); return;
    case BACKSPACE: if(!gears.empty()) gears.pop(); break;
    case CODED:
      switch(keyCode) {
        case DOWN: speed -= .5; break;
        case UP: speed += .5; break;
        case LEFT: picked.spin = -1; break;
        case RIGHT: picked.spin = +1; break;
      } 
      break;
  }
  speed = constrain(speed, -2, 2);
}

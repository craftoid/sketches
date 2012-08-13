

// Swarming behaviour for digits of PI

// digit position inside the precalculated pi-shape
PVector pishape(int i) {
  return (PVector) pishape.get(i);
}

// digit position on the rotating ring
PVector circle(int i, int dir) {
  float dr = .40 +  float(i)/digits * .45;
  float theta = -TWO_PI / w * 4;
  float delta = -frameCount * theta * .3 ;
  float x = w/2 + r * dr * cos(i*theta + delta);
  float y = h/2 + r * dr * sin(i*theta + delta) * dir;
  return new PVector(x*.8 + y*.2, x*.2 + y*.8);
}

// interpolated digit position
PVector digit(int i) { 
  PVector v1 = circle(i, -1);
  PVector v2 = pishape(i);
  PVector v3 = circle(i, 1);
  float d = (mouseX-center.x)/w*2;
  float d1 = d > 0 ? d : 0;
  float d2 = d < 0 ? -d : 0;
  PVector v = lerp(lerp(v2, v3, d1), v1, d2);
  return lerp(center0, v, 1 + (center.y-mouseY)/h);
}

// move center to mouse position if the mouse is pressed
void centerTween() {
  PVector mouseV = new PVector(mouseX, mouseY);
  tweener = constrain(tweener +  (mousePressed ? 1 : -1), 0, tween);
  center = lerp(center0, mouseV, tweener/tween);
}

// linear interpolation between vectors
PVector lerp(PVector v1, PVector v2, float d) {
  return new PVector(lerp(v1.x, v2.x, d), lerp(v1.y, v2.y, d));  
}


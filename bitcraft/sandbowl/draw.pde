
void clearBowl() {
  g.beginDraw();
  g.noStroke();
  if(fishbowl) {
    g.background(beam);
    g.fill(liquid);
    g.ellipse(w/2,w/2,w,w);
  } 
  else
    g.background(liquid);
  g.endDraw();
  r = 0;
}

void drawBeam() {
  float w = max(flow/2,1);
  g.beginDraw();
  g.strokeWeight(w);
  g.stroke(beam&-bits); 
  if(w>1) g.line(x0,y0,mxc,myc); 
  else neumannLine(x0,y0,mxc,myc); 
  g.endDraw();
}

void drawCursor() {
  stroke(cursor,50);
  switch(mode) {
  case DRAW_SAND:; 
  case ERASE_SAND: 
    cursor(HAND);
    if(inside()) {
      strokeWeight(2*flow*pixel);
      strokeCap(ROUND);
      point(mouseX, mouseY);
    }
    break;
  case DRAW_BEAM:  
    cursor(CROSS);
    if(inside()) {
      strokeWeight(flow*pixel);
      strokeCap(SQUARE);
      line(sx0,sy0, mouseX, mouseY); 
    }
    break;
  case MOVE:
    cursor(MOVE);
    break;
  default:        
    cursor(ARROW);
  } 
}

// this is a quick hack to get 4-connected lines...
void neumannLine(float x0, float y0, float x1, float y1) {
  int dx=0, dy=0; 
  if(abs(y1-y0) > abs(x1-x0)) dy=1; 
  else dx=1;
  x0 = constrain(x0,0,w-1-dx);
  y0 = constrain(y0,0,w-1-dy);
  x1 = constrain(x1,0,w-1-dx);
  y1 = constrain(y1,0,w-1-dy);
  g.line(x0, y0, x1, y1);
  g.line(x0+dx, y0+dy, x1+dx, y1+dy);  
}



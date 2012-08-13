

float r, mr, mrc, pr, ma, pa, mx, my, mxc, myc, x0, y0, sx0, sy0;

static final int 
  IDLE=0, SAND=1, BEAM=2, DRAW=4, MOVE=8,  
  ERASE_SAND=1, DRAW_SAND=5, DRAW_BEAM=6;

int mode;

void keyPressed() {
  switch(key) {
  case '+': flow++; break;
  case '-': flow = max(1,flow-1); break;
  case 'c': fishbowl=!fishbowl; clearBowl(); break;
  default: sand=color(hue(sand) + 8 ,saturation(sand),brightness(sand)); 
  }
}

void mousePressed() {
  getPos(); 
  if(inside()) {
    if(mouseButton==LEFT) mode=DRAW_SAND;
    if(mouseButton==CENTER) mode=ERASE_SAND;
    if(mouseButton==RIGHT) mode=DRAW_BEAM;
  } else mode=MOVE; 
  updatePos();
}

void mouseReleased() {
  if(mode==DRAW_BEAM) { getPos(); drawBeam();}
  mode=IDLE;
}

void mouseDragged()  { 
  if((mode&SAND)>0) {getPos(); updatePos();}
  if(mode==MOVE)    {getPos(); r-=ma-pa; updatePos();}
}

boolean inside() {
  getPos();
  return (fishbowl && mr==mrc || !fishbowl && mx==mxc && my==myc);
}

void getPos() {
  mr=dist(mouseX,mouseY,s/2,s/2)/pixel;
  mrc=min(w/2+edge,mr);
  ma=atan2(mouseX-s/2,mouseY-s/2);
  mx=w/2+ int(mr*sin(r+ma));
  my=w/2+ int(mr*cos(r+ma));
  mxc = constrain(mx,-edge,w-1+edge);
  myc = constrain(my,-edge,w-1+edge);
}

void updatePos() {
  x0=mx;
  y0=my;
  sx0=mouseX;
  sy0=mouseY;
  pa=ma;
}



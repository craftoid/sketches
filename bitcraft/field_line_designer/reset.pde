
void resetNice(int res) {
  reset(res);
  addCharge(w/4, h/2, -1);
}


void reset(int resolution) {
  res = resolution;
  w = res * width;
  h = res * height;
  n = w * h;
  buffer = new int[n];
  field = new float[w][h][2];
  hires = createImage(w, h, RGB);
  tween = res == 1 ? 0.5 : 1.0 ;
  csum = 0;
  newcharge = 1;
}


void resetGrid() {
  renderMode = XYLINES;
  xscale = 20;
  yscale = 10;
  above = 1;
  below = 1;
  filterMode = 1;
  edge = res-1;
  tiles = false;
  limited = true;
  moiree = false;
  smooth = (res == 1);
}



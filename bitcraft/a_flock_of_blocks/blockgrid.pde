

class BlockGrid {
  
  int[] grid;
  
  BlockGrid() { 
    clear();
  }

  void clear() {
    grid = new int[w*h];
  }
  
  int get(int x, int y) {
    if(x<0||x>=w||y<0||y>=h) return -1;
    return grid[y*w+x];
  }
  
  void set(int x, int y, int c) {
    if(x<0||x>=w||y<0||y>=h) return;
    grid[y*w+x] = c;
  }
  
  void drawOutlines() {    
    float d = border > 1 ? deltab/2 : 0; // line overshoot
    float t = (border%2)/2f/zoom;        // pixel balance
    translate(-t, -t); 
    if(border>0) {
      strokeWeight(border);
      stroke(0);
      for(int y=-1; y<h; y++) for(int x=-1; x<w; x++) {
        int c0 = get(x,y), cx = get(x+1,y), cy = get(x,y+1);
        if(c0 != cy && (c0+cy) >= 0) line(x-d, y+1, x+1+d, y+1); // horizontal line
        if(c0 != cx && (c0+cx) >= 0) line(x+1, y-d, x+1, y+1+d); // vertical line
      }
    }
  }
}



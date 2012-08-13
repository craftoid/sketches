


// color palette
color[] colors = { #00dddd, #0000ff, #ff9900, #ffff00, #00dd00, #cc00ff, #ff0000 };  


class Block {

  int id, px, py, type, rotation;

  Block(int _type, int _rotation, int _px, int _py) {
    
    // create block
    type = _type; 
    rotation = _rotation;
    px = _px;
    py = _py;
  
    // try to add it to the block list and block grid
    if(!collide(0, 0)) {
      blocks.add(this);
      mark(id = ++n+1);
    }
    
  }
    
  void draw() {
    for(int y=0; y<d; y++) for(int x=0; x<d; x++) 
      if(bblocks[rotation][type][y][x]) {
        fill(colors[type]);
        rect(px+x, py+y, 1, 1);
      }
  }
  
  void drawOutline() {
    for(int y=0; y<d; y++) for(int x=0; x<d; x++) 
      if(bblocks[rotation][type][y][x]) {
        fill(0);
        rect(px+x-deltao, py+y-deltao, 1+2*deltao, 1+2*deltao);
      }
  }

  // check for collisions
  boolean collide(int dx, int dy) {
    for(int y=0; y<d; y++) for(int x=0; x<d; x++) {
      if(bblocks[rotation][type][y][x]) {
        int b = grid.get(px+x+dx, py+y+dy);
        if( b != 0 && b != id) return true;
      }
    }
    return false;
  }
  
  void move(int dx, int dy) {
    if(!collide(dx, dy)) {
      mark(0); 
      px+=dx;
      py+=dy; 
      mark(id);
    }
  }
  
  void mark(int m) {
    for(int y=0; y<d; y++) for(int x=0; x<d; x++) 
      if(bblocks[rotation][type][y][x]) 
        grid.set(px+x, py+y, m);  
  }
 
}

  

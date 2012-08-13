
color bg = #ffffff;                // background color
int mx, my;                        // mouse position in grid coordinates


class BlockList extends ArrayList {
  
  Block get(int i) { 
    return (Block) super.get(i); 
  }
  
  void interact() { 
    
    // update mouse position
    mx = mouseX/zoom-d/2;
    my = mouseY/zoom-d/2; 
    
  }
  
  void create() {
    
    if(frameCount % rate == 0) { 
      int rot = floor(random(d));
      if (keyPressed && key>='1' && key < '1' + types) 
        new Block(key - '1', rot, mx, my);  
      else if (mousePressed) 
        new Block(floor(random(types)), rot, mx, my);
    }  
  }
  
  
  void move(Function f) {
     
    int[][] moves = new int[n][3];
    int m = 0;
    
    // identify movable blocks
    for(int i=0; i<n; i++) {
      Block b = get(i);
      int[] d = f.fn(b);
      if(!b.collide(d[0], d[1])) moves[m++] = new int[] { i, d[0], d[1] };
    }
    
    // move em!
    for(int i=0; i<m; i++) {
      int[] d = moves[i];
      get(d[0]).move(d[1], d[2]);
    }
    
  }
  
  void draw() {
   
    translate((width % zoom)/2, (height % zoom)/2);   // center display
    background(bg);
    scale(zoom);
   
    // outline to separate shapes from the background
    noStroke();
    if(outline >= 1) for(int i=0; i<n; i++) get(i).drawOutline();
   
    // fill shapes with color
    for(int i=0; i<n; i++) get(i).draw();
    
    // draw outlines to seperate shapes from one another
    if(border >= 1) grid.drawOutlines(); 
  }
  
}  






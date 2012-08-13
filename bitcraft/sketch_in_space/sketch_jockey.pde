
 ///////////////////////////////////////////////////
 //                                               //
 //   a class to run sketches inside a sketch     //
 //                                               //
 ///////////////////////////////////////////////////


class SketchJockey {
  
  SketchInSpace[] sketches;
  SketchInSpace sketch;
  PImage img;
  int w, h;
  
  int select = -1;
  
  SketchJockey(SketchInSpace[] _sketches) {
    sketches = _sketches;
    next();
   // next();
  }
  
  void next() {   
    
    // stop previous sketch
    if(sketch != null) sketch.stop(); 
    
    // increase sketch index
    select = (select + 1) % sketches.length;
      
    // start next sketch
    sketch = sketches[select];
    if(sketch.frameCount < 1) {
      sketch.init();
      sketch.run();  // is this the right way to do it? 
      sketch.sketchPath = sketchPath; // use the same sketch path as we do
    }
    
    println("selected sketch :" + sketch);
    w = sketch.width;
    h = sketch.height;
    img = sketch.g;
    
  }
  
  void draw(int x, int y) {
    draw(x, y, w, h); 
  }
  
  void draw(int x, int y, int w, int h) {
    translate(-width/2, -height/2);
    
    // control frame around the local sketch
    drawFrame(2, 4, (control == CTRL_SKETCH) ? #ff6666 : #000000);
    
    // draw sketch in space
  
    sketch.handleDraw();
    img = sketch.g;
    img.loadPixels();

   
    smooth();  // we need to use smooth mode to get accurate textures and depthmaps
    image(img, x, y, w, h);
    
    // control frame around the global sketch
    if(control == CTRL_GLOBAL) {
      cam.beginHUD();
      drawFrame(5, 0, #ff6666);
      cam.endHUD();
    }

  }
  
  void drawFrame(float t, float b, color c) {
    pushStyle();
    smooth();
    noFill();
    stroke(c);
    strokeWeight(t);
    rect(-b, -b, width+2*b, height+2*b);
    popStyle();
  }
  
  void handleKeyEvent(KeyEvent event) {    
    sketch.handleKeyEvent(event);
  }
  
  void handleMouseEvent(MouseEvent event) {    
   
    // get mouse event coordinates
    int mx = event.getX();
    int my = event.getY();
    float mz = getZ(mx, my);
    if(mz == MAX_FLOAT) return;
    
    // map global mouse coords to local sketch coordinates
    int lmx = int ( invScreenX(mx, my, mz) * sketch.width / width);
    int lmy = int ( invScreenY(mx, my, mz) * sketch.height / height);

    // let the sketch handle the modified mouse event    
    event.translatePoint(lmx - mx ,lmy - my);
    sketch.handleMouseEvent(event); 
  }
  
}


// extending PApplet to make protected event handling methods accessible

class SketchInSpace extends PApplet {
  public void handleKeyEvent(KeyEvent event) {
    super.handleKeyEvent(event); 
  }
  public void handleMouseEvent(MouseEvent event) {
    super.handleMouseEvent(event); 
  }
}


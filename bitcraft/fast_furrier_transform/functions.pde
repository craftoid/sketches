

// various utility functions ...


//////////   drawing and loading seed images   ////////// 


//  spray drawing
void spray() {
  if(mousePressed) {
    int r1 = 20;
    fill(color(mouseButton==LEFT ? 0 : 255), 64);
    ellipse(mouseX, mouseY, r1, r1);
  }
}


// load seed image
void loadSeed() {
  
  inputMode = false;
  
  // pick image file (use default image for online demo)
  String name = online ? sampleImg : selectInput("Select seed image");
  if(name==null) return;
  loadSeed(name);
 
}


void loadSeed(String name) {

  // load image 
  PImage img = loadImage(name);

  // center image
  if(img != null) {
    float d = min(float(h) / img.height, float(w) / img.width);
    float dx = d * img.width, dy = d * img.height;
    float tx = (w - dx)/2, ty = (h - dy)/2;
    image(img, tx, ty, dx, dy);
  }
  
}


void savePatternAnimation() {
  if(frameCount == 1) {
    outputFolder = selectFolder("Select output folder");
    if(outputFolder==null) {
      outputMode = false;
      return;
    }
  } 
  saveFrame(outputFolder + File.separator  + "fur-#####.png");
  if(frameCount >= outputFrames) outputMode =false; 
}



//////////  creating fur  ////////// 

// get chemical distribution from an image 
void furFromImage(PImage g) {
  randomSeed(100);
  g.loadPixels();
  fur = new int[2][w][h];
  for(int y=0; y<h; y++) for(int x=0; x<w; x++) {
    fur[0][x][y] = fur[1][x][y] = random(255) > brightness(g.get(x, y))  ? 0 : 1;
  } 
}


//////////   switching modes   ////////// 

void furMode() {
  if(!drawMode) return;
  img = get();
  furFromImage(img);
  drawMode = false;
}

void drawMode() {
  if(drawMode) return;
  image(img, 0, 0);
  drawMode = true; 
}

void outputMode() {
  if(outputMode) return;
  frameCount = 0;
  outputMode = true; 
}

void inputMode() {
  outputMode = false;
  inputMode = true; 
}


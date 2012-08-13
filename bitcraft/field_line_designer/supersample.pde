
PImage hires;

void loadPixels() {
  if(w == width && h == height) super.loadPixels();
  else {
    hires.loadPixels();
    pixels = hires.pixels;
  }
}

void updatePixels() {
  if (w == width && h == height) super.updatePixels();
  else {
    hires.updatePixels();
    image(hires, 0, 0, width, height);
  }
}


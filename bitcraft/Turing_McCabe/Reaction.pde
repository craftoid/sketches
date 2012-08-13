
/////////////////////////////////////////////////////////////////////////////
//                                                                         //
//     Algorithm for the Multi-Color Multi-Level Turing Pattern            //
//                                                                         //
/////////////////////////////////////////////////////////////////////////////

int gmin, gmax;

void calculatePattern() {

  float[] source = grid;
  float[] target = diffusionRight;
  
  for (int level = 0; level < levels; level++) {
    
    // diffuse chemical to the target layer
    int radius = radii[level]; 
    if(level <= blurlevels) blur(source, blurBuffer, w, h);
    collect(target, blurBuffer, w, h, radius);
    
    // check/save bestLevel and bestVariation
    for (int i = 0; i < n; i++) {
      float variation = abs(source[i] - target[i]);
      if (level == 0 || variation < bestVariation[i]) {
        bestVariation[i] = variation;
        bestLevel[i] = level;
        direction[i] = source[i] > target[i];
      }
    }
    
    // update diffusion matrices
    if(level==0) {
      source = target;
      target = diffusionLeft;
    } else {
      float[] swap = source;
      source = target;
      target = swap;
    }
    
  }
 
  // update grid from bestLevel
  gridmin = colormin = MAX_FLOAT;
  gridmax = colormax = MIN_FLOAT;
  for (int i = 0; i < n; i++) {
    float curStep = stepSizes[bestLevel[i]];
    if (direction[i]) {
      grid[i] += curStep;
      colorgrid[i] += curStep * colorShift[bestLevel[i]];
    }
    else {
      grid[i] -= curStep;
      colorgrid[i] -= curStep * colorShift[bestLevel[i]];
    }
    gridmin = min(gridmin, grid[i]);
    gridmax = max(gridmax, grid[i]);
    colormin = min(colormin, colorgrid[i]);
    colormax = max(colormax, colorgrid[i]);   
  }
 
  // normalize to [-1, +1]
  float range = (gridmax - gridmin) / 2;
  float colorrange = (colormax - colormin) / 2;
  for (int i = 0; i < n; i++) {
    grid[i] = ((grid[i] - gridmin) / range) - 1;
    colorgrid[i] = ((colorgrid[i] - colormin) / colorrange) - 1;
  }
  
}


void renderPattern(PImage img) {
  img.loadPixels();
  color[] pixels = buffer.pixels;
  gmin = invertMode ? -1 : +1;
  gmax = invertMode ? +1 : -1;
  for (int i = 0; i < n; i++) {
    float h = int(map(colorgrid[i], gmin, gmax, 0, 127) + colorOffset)  % 256;
    float b = map(grid[i], gmin, gmax, 0, 255);
    float s = (255-b) / 2;
    pixels[i] = colMode ? color(h, s, b) : color(b);
  }
  img.updatePixels();
}


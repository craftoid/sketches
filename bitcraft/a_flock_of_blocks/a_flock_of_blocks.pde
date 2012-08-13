/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/7686*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

     ////////////////////////
    //                    //
   //   a  F l o c k     //
  //                    //
 /////////////   o f   /////////////
           //                    //
          //     B l o c k s    //
         //                    //
        ////////////////////////
        
  // (c) Martin Schneider 2010


BlockList blocks;         // list of all blocks
BlockGrid grid;           // block grid for detecting collisions and finding block borders
int n;                    // block counter

Function shakeIt, dropIt, followIt; // motion functions


void setup() {
  size(500, 500, P2D);
  initBlocks(); 
  shakeIt = new ShakerFn();
  dropIt = new GravityFn();
  followIt = new SwarmFn();
  incZoom(3); 
  incBorder(1);
  incOutline(1); 
  reset(); 
}

void reset() {
  n = 0;
  blocks = new BlockList();
  grid = new BlockGrid();
}


void draw() {
  blocks.interact();
  blocks.create();
  if(drop) blocks.move(dropIt); else blocks.move(followIt);
  if(shake) blocks.move(shakeIt);
  blocks.draw();
}


// motion functions

abstract class Function {
   abstract int[] fn(Block b);
}

class GravityFn extends Function {
   int[] fn(Block b) { return new int[] { 0, gravity }; } 
}

class ShakerFn extends Function {
  int[] fn(Block b) { return new int[] {random(1) > .5 ? 1 : -1, 0}; } 
}

class SwarmFn extends Function {
  int[] fn(Block b) { 
    float jitter = .3;
    float ang = atan2(my-b.py, mx-b.px) + random(-PI*jitter, PI*jitter);
    return new int[] {round(cos(ang)), round(sin(ang))}; 
  }
}

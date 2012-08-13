/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6009*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */


 //  cavecavecavecavecavecavecavecavec
 //  e                               a
 //  v                               v
 //  a        Platon's  Dream        e
 //  c                               c
 //  e                               a
 //  vacevacevacevacevacevacevacevacev
 
  // (c) Martin Schneider 2009

 // http://www.k2g2.org/blog:bit.craft
 

 // This is a sketch about Platon's cave and its modern version the multimedia cave.
 // It shows the fractal implications of considering "the platonic idea of a cave".

 // The experiment is very simple. It's based on a rotating cube.
 // We take a picture of the cave from the outside, and project this image onto each of its six walls in the next frame.
 // As a result we get an animated pseudo-3D iterative function system.

 

color bg = #ffffff;    // white background
color fg = #000000;    // black border
int border = 32;       // border thickness
float opacity = 200;   // somewhat transparent
float shady   = 200;   // somewhat shady

boolean transparent = false;
boolean shadow = false;

float s;               // size of our sketch 
PImage alphaImg;       // used for transparency


void setup(){
 
  // set the size of the sketch
  size(512, 512, P3D); 
  s = width;
 
  // create alpha image for transparency effect
  background(opacity);
  alphaImg = get();
}


void draw(){
  
  // get a slightly transparent copy of the visible scene
  PImage img = get();
  if(transparent) img.mask(alphaImg);
  
   
  // DRAW BACKGROUND
  
  if(shadow) {
    
    // add some shading by fading the previous frame
    hint(DISABLE_DEPTH_TEST);
    fill(bg, 255-shady);
    noStroke(); 
    rect(0, 0, s, s);
    hint(ENABLE_DEPTH_TEST);
    
  } else {
    background(bg); 
  }


  // DRAW SCENE
  
  pushMatrix();
  
  // translate origin to the center
  translate(s/2,s/2,s/2);
  
  // take the red pill
  translate(0,0,-s);
  
  // rotate the cube 
  rotateX(frameCount * .01); 
  rotateY(frameCount * .005);
  
  // draw all six faces of the cube
  for(int i=0;i<6;i++) {
    
    // roatate to next face direction
    rotateY(-PI/2* ( (i+1) %2)); 
    rotateX(PI/2 * (i%2)); 
   
    face(img);
  }
  
  popMatrix(); 
  
  
  // DRAW FOREGROUND
    
  // draw an extra thick frame around the viewport
  hint(DISABLE_DEPTH_TEST);
  stroke(fg); 
  noFill();
  strokeWeight(border);
  rect(0, 0, s, s);
  hint(ENABLE_DEPTH_TEST);

}


void face(PImage img) {
   
  pushMatrix();
    
   // "explode" the face if the mouse is moved
   float z = 1 + float(mouseY)/s;
   scale(1/z);
   translate(0, 0, s/2 * z); 

   // project the image onto the face
   fill(0); noStroke(); 
   textureMode(NORMALIZED);
   beginShape();
   texture(img);
     vertex(-s/2, -s/2, 0, 0);
     vertex(-s/2, s/2, 0, 1);
     vertex(s/2, s/2,0, 1, 1);
     vertex(s/2, -s/2, 0, 1, 0);
   endShape();
    
   popMatrix(); 
}


void keyPressed() {
  switch(key) {
    case 't':  // toggle transparency
      transparent = !transparent; 
    break;
    case 's':  // toggle shadow
      shadow = !shadow;
    break;
  }
}



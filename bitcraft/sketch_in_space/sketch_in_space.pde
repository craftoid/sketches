/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6573*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */


       /////////////////////////////
      //                         //
     //                         //                                      
    //     SKETCH IN SPACE     //
   //                         //
  //                         //
 /////////////////////////////

 // (c) Martin Schneider 2009


import peasy.*;

PeasyCam cam;
SketchJockey sjay;

void setup() {

  size(400, 400, P3D); 
  cam = new PeasyCam(this, width * 1.5);

  // create sketches 
  SketchInSpace[] sketches = {
    new Sketch5000()
  , new Sketch3659()
  , new Sketch4312()
  , new Sketch4574()
 };

  // pass them to the sketch jockey
  sjay = new SketchJockey(sketches);
}

void draw(){
  background(255);
  sjay.draw(0, 0, width, height);
}

void keyPressed() {
  if(key == ' ') sjay.next(); 
  println("global: key pressed '" + key + "'");
}




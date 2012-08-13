/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6727*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

////////////////////////////
//                        //
//    raining bricks      //
//                        //
////////////////////////////

// (c) Martin Schneider 2009


import org.jbox2d.p5.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.common.*;
import org.jbox2d.collision.*;

Physics p;
Body bat;
Body brick;
float w, h;

final static int VIS_WHITE = 1, VIS_3D = 2;
float d = 10, l=150;
float prand = 30;
float depth = 50;
int visMode = VIS_3D | VIS_WHITE;
int dropFrequency = 30;
float brickSpin;
boolean lines;


void setup() {
  
  size(800, 500, P3D);
  w = width/2;
  h = height/2;

  p = new Physics(this, width, height);
  p.removeBorder();
  p.setCustomRenderingMethod(this, "draw"); 
  p.setFriction(.5);
  
  // create bat
  p.setDensity(200);
  bat = p.createRect(w-l, height - 3*d, w+l, height-d);
  bat.allowSleeping(false);
  
  p.setDensity(100);
  //p.getSettings().hz = 30;   
  frameRate(60);
  
  colorMode(HSB);
  noCursor();
}


void draw() {
    
  // set stroke and background according to vismode
  color c = ((visMode & VIS_WHITE) > 0) ? 0 : 255; 
  if(lines) stroke(c); else noStroke();
  background(c);
  
  // setup lights and bat color
  if((visMode & VIS_3D) > 0) {
    float d = 2 - visMode ;
    float b = 220;
    directionalLight(0, 0, b, 1, 0, d);
    directionalLight(0, 0, b, -1, 0, d);
    directionalLight(0, 0, b, 0, 1, d);
    directionalLight(0, 0, b, 0, -1, d);
    bat.setUserData(new Style(200));
  } else {
    c = ((visMode & VIS_WHITE) > 0) ? 255 : 0;  
    bat.setUserData(new Style(c));
  }
  
  // control the bat
  interaction();

  // drop the bricks
  if(frameCount % dropFrequency == 10) dropBrick();
}


void interaction() {
  
  // tilt direction can be controlled via mouse buttons
  float tilt = mousePressed ? (mouseButton == LEFT ? 1 : -1) : 0;
  
  // adjust velocity of the bat towards target position
  float x = p.worldToScreen(bat.getXForm().position.x) + w;
  float y = p.worldToScreen(bat.getXForm().position.y) + h;
  float mx = constrain(mouseX, tilt==0 ? l:0, tilt==0 ? width-l : width);
  float my = height - constrain(mouseY, d, height-d);
  float vx = (mx - x) * 1.0;
  float vy = (my - y) * 1.0;
  bat.setLinearVelocity(new Vec2(vx, vy));
  
  // adjust angular velocity of the bat towards horizontal or tilted position
  float a2 = tilt * map(mx, 0, width, -HALF_PI, HALF_PI);
  bat.setAngularVelocity( (a2-bat.getAngle()) * 10);
  
}


void dropBrick() {
  final int BLOCK=1, TRIANGLE=2;      
  float y = random(5, 40);
  float x = prand; prand = y;
  float c = 0;
  float px = random(w-l/2, w+l/2);
     
  int type = random(1) < .8 ? BLOCK : TRIANGLE;
  switch(type) {
    case BLOCK:
      brick = p.createRect(px-x,-2*y-depth,px+x,-depth);
      c = random(150, 190); // blueish
      break;
    case TRIANGLE:
      brick = p.createPolygon(px-x,-depth, px+x,-depth, px,-2*y-depth);
      c = random(0, 40); // reddish
      break;  
  }
  brick.setUserData(new Style(color(c, 128, 255)));
  brick.setAngularVelocity(brickSpin * PI/2);
}

void keyPressed() {
  float a = 0;
  switch(key) {

    case 'd': lines =! lines; break;
    case 'f': visMode = (visMode + 1) % 4; break;
    
    case 'w': brickSpin = 1; break;
    case 'e': brickSpin = 0; break;
    case 'r': brickSpin = -1; break;
  }
  // if(brick!=null) brick.setAngularVelocity(brickSpin * PI/2);
}



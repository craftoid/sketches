/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/17344*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

  ////////////////////////////
  //                        //
  //        doodle 4        //
  //                        //
  ////////////////////////////

  // (c) Martin Schneider 2010


int nx = 28, ny = 32, xmin = 20, sym = 5;
boolean inside, soft = true, details = true;
float zoom = 1;
int w, h, sx, sy;

void setup() {
  size(300, 300);
}

void draw() {
  
  startSuperSample();
  
  if(details) sx=sy=8; else sx=sy=4;
  smooth();
  background(255);
  translate(w/2, h/2);
  
  for(int i=0; i<ny; i++) {
    float y = i * TWO_PI/ny;
    for(int j=xmin*sx; j<nx*sx; j++) {
      float x1 = j*TWO_PI/nx/sx ;
      float x2 = (j+1)*TWO_PI/nx/sx;
      lines(fn(x1,y), fn(x2,y));
    }
  }
  
  for(int i=xmin; i<=nx; i++) {
    float x = i * TWO_PI/nx;
    for(int j=0; j<ny*sy; j+=1) {
      float y1 = j * TWO_PI/ny/sy;
      float y2 = (j+1) * TWO_PI/ny/sy;
      lines(fn(x,y1), fn(x,y2));
    }
  }
  
  endSuperSample();
  
}

void lines(float[][] p1, float[][] p2) {
  int l = p1.length;
  for(int i=0; i<l; i++) {
    float x1 = p1[i][0], y1 = p1[i][1];
    float x2 = p2[i][0], y2 = p2[i][1];
    float d = dist(x1, y1, x2, y2);
    float c = d * 8;
    if(c<255) {
      stroke(0, 255-c);
      line(x1, y1, x2, y2);
    }
  }
}

// this is where the magic happens ...

float[][] fn(float x, float y) {
  float[][] p = new float[sym][2];
  float x1 = exp(x) * cos(y) + (width/2 - mouseX);
  float y1 = exp(x) * sin(y) + (height/2 - mouseY);
  float d = zoom * (inside ? .05 * pow(sym, 1.5) * pow(mag(x1, y1), 1f/sym) :  10f / log(sym)  * pow(mag(x1, y1), -1f/sym) );
  float arg = atan2(x1, y1) * -1f/sym;
  for(int i=0; i<sym; i++) {
    float x2 = d * cos(arg + i * TWO_PI/sym);
    float y2 = d * sin(arg + i * TWO_PI/sym); 
    p[i] = new float[] { w*x2/TWO_PI , h*y2/TWO_PI };
  }
  return p;
}


// supersampling

PGraphics G, Gtemp;
void startSuperSample() {
  int factor = 2;
  w = width * factor;
  h = height * factor;
  G = createGraphics(w, h, P2D);
  G.beginDraw();
  Gtemp = g; g = G;
  strokeWeight(soft ? 2: 1);
}

void endSuperSample() {
  G.endDraw();
  g = Gtemp;
  smooth(); image(G,0,0,width, height);
}


// interaction

void keyPressed() {
  switch(key) {
    case '-': zoom *= 9/10f; break;
    case '+': zoom *= 10/9f; break;
    case 'd': details =!details; break;
    case 's': soft = !soft; break;
    case ' ': inside = !inside; break;
    case CODED: switch(keyCode) {
      case LEFT: ny--; break;
      case RIGHT: ny++; break;
      case UP: nx++; break;
      case DOWN: nx--; break;
    };
    default:
    if(key>='2' && key <= '9') 
        sym = key - '0' ;
  }
  nx = constrain(nx, xmin+1, 36);
  ny = constrain(ny, 18, 76);
}


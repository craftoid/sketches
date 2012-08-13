/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/2638*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */


  /////////////////////////////////////
  //                                 //
  //  /////// superduper shapes      //                          
  //  //                             //
  //  /////////////////////////////////
  //
  /////////// (c) Martin Schneider 2009 
  
  // http://www.k2g2.org/blog:bit.craft
  

final static int LORES=0, MIXRES=1, HIRES=2;
boolean grid = false, faces = true, light = true, colors = true, output=false;
int loRes = 60, hiRes = 180;
int mode = LORES;
float minZoom = 1, maxZoom = 100;
float rotX=PI/4, rotY=-PI/8, rotZ=-PI*2/3, moveX, moveY, zoom = 2;
int[] mousePrecision = {1,2,0};

PGraphics g3d;
PFont font, bfont;

float[][][] m,  mHires;
fnCycle fns = new fnCycle();
shapeFn fn;
int mc0, mc1; // mesh update counters
int ic0, ic1; // image update counters

void setup() {
  size(500, 500, JAVA2D);
  g3d = createGraphics(width, height, P3D);
  font = loadFont("FreeSans-12.vlw");
  bfont = loadFont("FreeSansBold-12.vlw");
  
  fns.add(new supershape(40, 4, 10, 10, 10, 4, 10, 10, 10)); // cube
  fns.add(new supershape(40, 6, 5, 10, 10, 4, 10, 10, 10)); // star
  fns.add(new supershape(40, 3, 1.5, 12, 3, 0, 3, 0, 0)); // heart 
  fns.add(new supershell(20, 0, 10, 0, 0, 0, 10, 0, 0, 2, 1, 1, 5));  // cork screw
  fns.add(new supershell(20, 10, 3, 0, 3, 4, 10, 10, 10, 0.6, 0.7, 2.5, 6)); // flower shell    
  fns.add(new superdonut(20, 10, 10, 10, 10, 10, 10, 10, 10, 2, 0)); // star donut
  fns.add(new superdonut(20, 0, 10, 10, 10, 5, 6, 12, 12,  3, 0.2)); // umbilic donut
  fns.add(new superduper(20, 0, 10, 0, 0, 6, 10, 6, 10, 3, 0, 0, 0, 4, 0.5, 0.25));  // moebius donut 
  fns.add(new superduper(20, 0, 11, 0, 0, 7, 10, 15, 10, 4, 0, 0, 0, 5, 0.3, 2.2));  // superduper meobius
 
  fn = fns.next();
  updateMesh();
}

void draw() {
  interact();
  if (ic0 > ic1) redrawImage();
  image(g3d, 0, 0); 
  drawDisplay();
}

void redrawImage() {
  g3d.beginDraw();
  beginOutput(g3d);
  g3d.background(#666699);
  if(light) {
    float al = 180, dl = 80;
    g3d.ambientLight(al,al,al);
    g3d.directionalLight(dl,dl,dl,1,1,0);
    g3d.directionalLight(dl,dl,dl,-1,1,0);
  };
  g3d.translate(width/2, height/2);
  g3d.translate(moveX, moveY);
  g3d.rotateX(rotX); g3d.rotateY(rotY); g3d.rotateZ(rotZ); 
  g3d.scale(zoom);
  render(m, g3d);
  endOutput(g3d);
  g3d.endDraw();
  ic1=ic0;
}

void updateImage() {
  ic0++; 
}

void updateResolution() { 
  if (mode > LORES && !mousePressed) {
    if(mc0 > mc1) mHires = mesh(fn, yres(hiRes), hiRes);
    m = mHires; mc1 = mc0;
  } else {
    m = mesh(fn, yres(loRes), loRes);
  } 
  updateImage();
}

void updateMesh() {
   int res = (mode > LORES && !mousePressed) ? hiRes : loRes;
   m = mesh(fn, yres(res), res ); mc0++;
   updateImage();
}

float[][][] mesh(shapeFn fn, int imax, int jmax) {
 float[][][] m = new float[imax+1][jmax+1][3];
 for(int i=0; i<=imax; i++) {
    for(int j=0; j<=jmax; j++) {
      float u = map(i, 0, imax, 0, 1);
      float v = map(j, 0, jmax, 0, 1);
      m[i][j] = fn.eval(u,v);   
    } 
  }   
  return m;
}

void render(float[][][] mesh, PGraphics g) {
  int imax = mesh.length;
  int jmax = mesh[0].length;
  if (grid) g.stroke(255,255,255,50); else g.noStroke();  
  for(int i=0; i<imax-1; i++) {
    float p[];
    if (faces) g.fill(colors ? Color.HSBtoRGB(float(i)/imax, 0.5, 1.0) : 255); else g.noFill();    
    g.beginShape(QUAD_STRIP);  
    for(int j=0; j<jmax; j++) {
       p = m[i][j]; g.vertex(p[0],p[1],p[2]);
       p = m[i+1][j]; g.vertex(p[0],p[1],p[2]);
    }
    g.endShape();
  }
}

int yres(int res) {
  return  int(fn.getRatio() * res);
}

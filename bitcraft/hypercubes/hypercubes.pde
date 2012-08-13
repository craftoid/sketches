/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/3298*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
   
      ///////////       
     //       //
    //  //////////    
   //  //  //  //    
  //////////  //     Hypercubes
     //      //     
    //////////      (c) Martin Schneider 2009    
 
 
float tspeed, speed, sf, a1, a2, zoom, zf;
int dmax, pdim, dim, nodes, face, t;
int[][] n, l;
boolean grid, faces, light;

void setup() {
  size(500,500);  
  tspeed = .0001; sf = 4 * tspeed; 
  dmax = 9;  dim = pdim = 6; 
  grid = true; light = true; faces = false; face = 1;
  smooth(); strokeWeight(0); 
  a1 = 1; mouseX=width; mouseY = height/2;
  hyper(dim);
}

void draw() {
  
  tspeed = sf * (mouseX - width/2) / width;
  zoom   = zf * (height - mouseY) / height;
  speed  = lerp(speed, tspeed, .9);
  a1 += float(millis() - t) * speed; 
  a2 = -a1;
  t = millis();

  fill(255, 100); rect(0,0,width, height);
  translate(width/2, height/2);
  scale(zoom);
    
  for(int i=0; i<nodes; i++)  {
    float[] n1 = project(n[i]);
    float[] n0 =  project(n[l[i][dim-1]]);
    for (int d=0; d<dim; d++) {
      float[] n2 = project(n[l[i][d]]);
      float c = light ? 192/dim * (d + 1) : 128;
      if(faces) {
        noStroke(); fill(c, 5);
        if(d < face) quad(n1[0], n1[1], n0[0], n0[1], n0[0]+n2[0]-n1[0], n0[1]+n2[1]-n1[1], n2[0], n2[1]);
        n0 = n2;
      }
      if(grid) {
        stroke(c, 150);
        line(n1[0], n1[1], n2[0], n2[1]);
      }
    }
  } 
  
}

void keyPressed() {
  switch(key) {
    case 'l': light =!light; break;
    case 'f': faces =!faces; break;
    case 'g': grid = !grid; break;
    case CODED:
      switch(keyCode) {
        case UP   : dim++; break;
        case DOWN : dim--; break;
        case LEFT : face--; break;
        case RIGHT: face++; break;
      }
      dim = constrain(dim, 1, dmax);
      face = constrain(face, 1, dim);
      hyper(dim);
      break;
  }
}

void hyper(int dim) { 
  nodes = 1<<dim;
  n = new int[nodes][dim];
  l = new int[nodes][dim];
  for(int i=0; i<nodes; i++) for (int d=0; d<dim; d++) {
      n[i][d] = (i & 1<<d) > 0 ? -1 : 1;
      l[i][d] = i ^ 1<<d;
  } 
  background(255); 
  zf = float(height)/dim;
  a1 = a1/pdim * dim; 
  pdim = dim;
  
}

float[] project(int[] p) {
  float[] r = new float[2];
  for(int d=0; d<dim; d++) {
    float ang = PI/dim * d;
    r[0] += sin(ang * a1 + a2 * PI) * p[d];
    r[1] += cos(ang * a1 + a2 * PI) * p[d];
  }
  return r;
}

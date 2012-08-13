

import peasy.org.apache.commons.math.geometry.*;

void drawMolecule(AtomSetCollection asc) {

  // center molecule
  
  if(reset) {
    xmin=+MAX_FLOAT; ymin=+MAX_FLOAT; zmin=+MAX_FLOAT;
    xmax=-MAX_FLOAT; ymax=-MAX_FLOAT; zmax=-MAX_FLOAT;
    for(int i=0; i<asc.getAtomCount(); i++)  {
      Atom a = asc.getAtom(i);
      xmin = min(xmin, a.x); ymin = min(ymin, a.y); zmin = min(zmin, a.z);
      xmax = max(xmax, a.x); ymax = max(ymax, a.y); zmax = max(zmax, a.z); 
    }
    dx = (xmax+xmin)/2; dy = (ymax+ymin)/2; dz = (zmax+zmin)/2;
    dmax = max(max(xmax-xmin, ymax-ymin), zmax-zmin);
    reset = false;
  }
  
  // draw molecule
  
  scale(1,-1); // flip y-axis
  scale(width/dmax);
  translate(-dx, -dy, -dz);
  rt = sqrt(ra*ra - rb*rb); // tube offset;
  
  // draw bonds
  for(int i=0; i<asc.getBondCount(); i++) {
     Bond b = asc.getBond(i);
     Atom a1 = asc.getAtom(b.atomIndex1);
     Atom a2 = asc.getAtom(b.atomIndex2);
     fill(cb, transparent ? opacity : 255);
     tube(a1.x, a1.y, a1.z, a2.x, a2.y, a2.z, rb);    
  }
  
  // draw atoms  
  for(int i=0; i<asc.getAtomCount(); i++)  {
    Atom a = asc.getAtom(i);
    pushMatrix();
    translate(a.x, a.y, a.z);
    fill(ca, transparent ? opacity : 255);
    sphere(ra);
    popMatrix();
  }
  

}


// draw a tube between two points

void tube(float x1, float y1, float z1, float x2, float y2, float z2, float r) {
  float d = dist(x1, y1, z1, x2, y2, z2);
  if (2*rt > d) return;
  pushMatrix();
  translate(x1, y1, z1);
  Rotation rot = new Rotation(new Vector3D(0, 0, 1), new Vector3D(x2-x1, y2-y1, z2-z1));
  beginShape(QUAD_STRIP);
  for(int i=0; i<=detail; i++) {
    float a = i * TWO_PI / detail;
    float x = r * cos(a);
    float y = r * sin(a);
    rvertex(x, y, d - rt, rot);
    rvertex(x, y, rt, rot);
  }
  endShape(CLOSE);
  popMatrix();
}

// rotated vertices
void rvertex(float x, float y, float z, Rotation rot) {
  Vector3D v = rot.applyTo(new Vector3D(x,y,z));
  vertex((float)v.getX(), (float)v.getY(), (float)v.getZ());
}

// nice lighting
void lights() {
  int w=120, m=-1, p=+1;
  ambientLight(w,w,w);
  directionalLight(w, w, w, m, m, m);
  directionalLight(w, w, w, p, p, p);
  directionalLight(w, w, w, m, m, p);
  directionalLight(w, w, w, p, p, m); 
}


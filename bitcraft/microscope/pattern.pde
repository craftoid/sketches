
// this is where the magic happens ...

int scl = 3, dirs = 12, rdrop = 8, lim = 128;
int res = 3, palette = 1, pattern = 0, lux = 80;
int dx, dy, w, h, s;
float dlux = (255-lux) / 92.0;
boolean border, soft, light = true, follow3D = true;
float[] pat, pshadow;
PImage img;
 
// shadow matrix
float[][] kemboss;
int lightdir;

void emboss(int dir) {
  int[][] dirs = {{-1,-1},{-1,0},{-1,1},{0,1},{1,1},{1,0},{1,-1},{0,-1}};
  float[] t = {1, -.25, -.5, -.25 };
  int krad = t.length, klen = krad * 2 +1;
  kemboss = new float[klen][klen];
  int dx = dirs[dir][0], dy = dirs[dir][1];
  for(int i=0; i<t.length; i++) kemboss[krad+i*dx][krad+i*dy] = t[i] * (dir%2 >0 ? 1: .8);
}

void reset() {
  w = width/res; 
  h = height/res; 
  s = w*h;
  canvas = createGraphics(w, h, P2D);
  pat = new float[s];
  pshadow = new float[s];
  emboss(lightdir);
  // random init
  for(int i=0; i<s; i++)  
    pat[i] = floor(random(256));
}

void pattern() {
  
  // random angular offset
  float R = random(TWO_PI);

  // copy chemicals
  float[] pnew = new float[s];
  for(int i=0; i<s; i++) pnew[i] = pat[i];

  // create matrices
  float[][] pmedian = new float[s][scl];
  float[][] prange = new float[s][scl];
  float[][] pvar = new float[s][scl];

  for(int i=0; i<scl; i++) {
    float d = (2<<i) ; 
    for(int j=0; j<dirs; j++) {
      float dir = j*TWO_PI/dirs + R;
      int dx = int (d * cos(dir));
      int dy = int (d * sin(dir));
      for(int l=0; l<s; l++) {
        int x = l%w + dx, y = l/w + dy;
        if(x<0) if(border) continue; else x = w-1-(-x-1)% w; else if(x>=w) if(border) continue; else x = x%w;
        if(y<0) if(border) continue; else y = h-1-(-y-1)% h; else if(y>=h) if(border) continue; else y = y%h;
        pmedian[l][i] += pat[x+y*w] / dirs;  
      }
    }
    
    for(int j=0; j<dirs; j++) {
      float dir = j*TWO_PI/dirs + R;
      int dx = int (d * cos(dir));
      int dy = int (d * sin(dir));
      for(int l=0; l<s; l++) {
        int x = l%w + dx, y = l/w + dy;
        if(x<0) if(border) continue; else x = w-1-(-x-1)% w; else if(x>=w) if(border) continue; else x = x%w;
        if(y<0) if(border) continue; else y = h-1-(-y-1)% h; else if(y>=h) if(border) continue; else y = y%h;
        pvar[l][i] += abs( pat[x+y*w] - pmedian[l][i]);
        prange[l][i] += pat[x+y*w] < lim ? -1 : 1;     
      }
    }   
  }

  // update chemicals
  for(int l=0; l<s; l++) {
    
    // min max variance and ranges
    int imin=0, imax=scl, jmin=0, jmax=scl;
    float vmin = MAX_FLOAT, rmin = MAX_FLOAT;
    float vmax = -MAX_FLOAT, rmax = -MAX_FLOAT;
    for(int i=0; i<scl; i++) {
      if (pvar[l][i] <= vmin) { vmin = pvar[l][i]; imin = i; }
      if (pvar[l][i] >= vmax) { vmax = pvar[l][i]; imax = i; }
      if (abs(prange[l][i]) <= rmin) { rmin = abs(prange[l][i]); jmin = i; }
      if (abs(prange[l][i]) >= rmax) { rmax = abs(prange[l][i]); jmax = i; }
    }   

    switch(pattern) {
      case 0: for(int i=imin; i<=imax; i++) pnew[l] += prange[l][i]; break;
      case 1: for(int i=0; i<=imin; i++)    pnew[l] += prange[l][i]; break;
      case 2: for(int i=jmax; i<scl; i++)   pnew[l] += prange[l][i]; break;
      case 3: for(int i=imin; i<=imax; i++) pnew[l] += prange[l][i] + pvar[l][i]/dirs; break;
    }
    
  }

  // rescale values
  float vmin = MAX_FLOAT;
  float vmax = -MAX_FLOAT;
  for(int i=0; i<s; i++)  {
    vmin = min(vmin, pnew[i]);
    vmax = max(vmax, pnew[i]);
  }
  float dv = vmax - vmin;
  for(int i=0; i<s; i++) 
    pat[i] = (pnew[i] - vmin) * 255 / dv;
  
  // shadow matrix
  for (int l=0; l<s; l++) { 
    float sum = 0;
    int klen = kemboss.length, krad = klen/2, ksize = klen * klen;
    int x = l%w, y =l/w;
    if(border && (x==0||y==0||x==w-1||y==w-1)) 
      pshadow[l] = 0;
    else {
      for (int k=0; k<ksize; k++) {
        int kx = k%klen, ky =k/klen;
        int x1 = x + kx - krad, y1 = y + ky -krad;
        if(x1<0) { if(border) continue; else x1 +=w;} else if(x1>=w) { if(border) continue; else x1 %= w; }
        if(y1<0) { if(border) continue; else y1 +=h;} else if(y1>=h) { if(border) continue; else y1 %= h; }
        sum += kemboss[ky][kx] * pat[x1+w*y1];
      }
      pshadow[l] =  constrain( lux + dlux * sum, 0, 255);
    }

  }
   
}





void edgeFilter(int edges, int d) {
  for(int e = 0; e < edges; e++) {
    color c1 = (e == edges - 1) ? fgcolor : 0;
    color c2 = (e == edges - 1) ? bgcolor : 255;
    for(int y = 0; y < h; y++) for(int x = 0; x < w; x++) {
      int i = y * w + x;
      int c = pixels[y * w+x] & MASK;
      int cmin = 256;
      for(int dy = -d; dy <= d; dy+=d) {
        for(int  dx= -d; dx <= d ;dx+=d) {
          int px = constrain(x + dx, 0, w - 1);
          int py = constrain(y + dy, 0, h - 1);
          cmin = min(cmin, pixels[px + w * py] & MASK);
          color col = c - cmin > 64 ? c1 : c2;
          buffer[i] = col;
        }
      }
    }
    arrayCopy(buffer, pixels);
  }
}

void blurFilter(int dmax) { 
   for(int d = 1; d <= dmax; d++) {  
      for(int x = 0; x < w; x++) for(int y = 0; y < h; y++) {
        int p = y * w + x;
        int E = x >= w-d ? 0 : d;
        int W = x >= d ? -d : 0;
        int N = y >= d ? -w*d : 0;
        int S = y >= (h-d) ? 0 : w*d;
        int p0 = p+N, p1 = p+S, p2 = p+W, p3 = p+E, p4 = p0+W, p5 = p0+E, p6 = p1+W, p7 = p1+E;
        int r = (  (r(pixels[p])<<2) + (r(pixels[p0]) + (r(pixels[p1]) + r(pixels[p2]) + r(pixels[p3]))<<1) + r(pixels[p4]) + r(pixels[p5]) + r(pixels[p6]) + r(pixels[p7]) )>>4;
        int g = (  (g(pixels[p])<<2) + (g(pixels[p0]) + (g(pixels[p1]) + g(pixels[p2]) + g(pixels[p3]))<<1) + g(pixels[p4]) + g(pixels[p5]) + g(pixels[p6]) + g(pixels[p7]) )>>4;
        int b = (  (b(pixels[p])<<2) + (b(pixels[p0]) + (b(pixels[p1]) + b(pixels[p2]) + b(pixels[p3]))<<1) + b(pixels[p4]) + b(pixels[p5]) + b(pixels[p6]) + b(pixels[p7]) )>>4;
        buffer[p] = 0xff000000 + (r<<16) | (g<<8) | b;
      }
      arrayCopy(buffer, pixels); 
   }
}

final static int r(color c) {return (c >> 16) & 255; }
final static int g(color c) {return (c >> 8) & 255;}
final static int b(color c) {return c & 255; }




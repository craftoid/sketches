
/////////////////////////////////////////////////////////////////////////////
//                                                                         //
//           Fast Diffusion Algorithm for Turing Patterns                  //
//                                                                         //
/////////////////////////////////////////////////////////////////////////////


void blur(float[] from, float[] buffer, int w, int h) {
  for (int y = 0; y < h; y++) for (int x = 0; x < w; x++) {
    int i = y * w + x;
    int E = x > 0 ? - 1 : 0;
    int N = y > 0 ? - w : 0;
    buffer[i] = buffer[i+N] + buffer[i+E] - buffer[i+N+E] + from[i];
  }
}

void collect(float to[], float[] buffer, int w, int h, int radius) {
  for (int y = 0; y < h; y++) for (int x = 0; x < w; x++) {
    int minx = max(0, x - radius);
    int maxx = min(x + radius, w - 1);
    int miny = max(0, y - radius);
    int maxy = min(y + radius, h - 1);
    int area = (maxx - minx) * (maxy - miny);
    to[y * w + x] = (buffer[maxy * w + maxx] - buffer[maxy * w + minx] - buffer[ miny * w + maxx] + buffer[miny * w + minx]) / area;
  }
}

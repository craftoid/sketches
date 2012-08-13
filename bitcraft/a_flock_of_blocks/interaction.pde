
int gravity = 1;            // direction of gravity
int rate = 1;               // block dropping rate 

int zoom;                   // size of a block unit in pixels
int outline, border;        // absolute outline and border
float deltao, deltab;       // relative outline and border
boolean shake, drop = true; // toggles for drop / follow and shaking behaviour             
int w, h;                   // block grid dimensions


// user interaction

void keyPressed() {

  switch(key) {
    
    case ' ' : reset(); break;
    
    case 'g' : gravity *= -1; break;
    case 's' : shake = !shake; break; 
    case 'd' : drop = true; break;
    case 'f' : drop = false; break;
    case 'r' : rate++; break;
    case 'R' : rate = max(rate-1, 1); break;
    case 'e' : saveFrame("blockflock-####.png"); break;
    
    case '+' : incZoom(+1); break;
    case '-' : incZoom(-1); break;
    case 'b' : incBorder(1); break;
    case 'B' : incBorder(-1); break;
    case 'o' : incOutline(1); break;
    case 'O' : incOutline(-1); break;
    
  }
}


// keep relative and absolute line thickness in sync across zoom levels

void incBorder(int b) {
  float d = float(border + b) / zoom;
  if(d>=0 && d<=.8) {
    deltab = d;
    border += b;
  }
}

void incOutline(int o) {
  float d = float(outline + o) / zoom;
  if(d>=0  && d<=.4) {
    deltao = d;
    outline += o;
  }
}

void incZoom(int z) {
  zoom = max(zoom + z, 1);
  outline = int(deltao * zoom);
  border = int(deltab * zoom);
  w = width/zoom;
  h = height/zoom;
  reset();
}


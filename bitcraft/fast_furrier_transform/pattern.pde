   

// this is where the magic happens ...


void pattern() {
  
  // get weight vector
  int[] v = weights[pat];
  
  // iterate over connected cells of increasing distance
  for(int i=0; i<weightmax; i++) {
    
    if(v[i]==0) continue;
    int d = 1<<(i+1);

    // iterate over connected cells by direction    
    for(int j=0; j<dirs; j++) {
      
      int dx = int (d * cos(TWO_PI/dirs * j));
      int dy = int (d * sin(TWO_PI/dirs * j));
      
      for(int y=0; y<h; y++) for(int x=0; x<w; x++) {
        
        // coordinates of the connected cell
        int x1 = x+dx, y1 = y+dy;
        
        // skip if the cell is beyond the border or wrap around
        if(x1<0) if(borderMode) continue; else x1+=w; else if(x1>=w) if(borderMode) continue; else x1-=w;
        if(y1<0) if(borderMode) continue; else y1+=h; else if(y1>=h) if(borderMode) continue; else y1-=h;
        
        // update chemical concentration
        if(fur[p][x1][y1]>0) fur[q][x][y] += v[i]; 
      }
    }
  }  
}




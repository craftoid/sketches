
final static int types = 7, d = 4; // number and diameter of blocks
boolean[][][][] bblocks;           // block sprites


void initBlocks() {
    
  // block sprites
  String b[][] = { 
    { "0000", "0000", "0000", "0000", "0000", "0000", "0000"},
    { "0000", "1000", "0001", "0110", "0110", "0100", "0110"},
    { "1111", "1110", "0111", "0110", "1100", "1110", "0011"},
    { "0000", "0000", "0000", "0000", "0000", "0000", "0000"}
  };
  
  // create blocks
  bblocks = new boolean[4][types][d][d];
  for(int t=0; t<types; t++) {
    
     // convert block to boolean format
    for(int y=0; y<d; y++) for(int x=0; x<d; x++) {
      bblocks[0][t][y][x] = (unbinary(b[y][t]) & 8>>x) > 0;
    }
    
    // create rotated versions
    for(int r=1; r<4; r++) for(int y=0; y<d; y++) for(int x=0; x<d; x++) {
      bblocks[r][t][y][x] = bblocks[r-1][t][x][d-1-y];
    } 
    
  }
}



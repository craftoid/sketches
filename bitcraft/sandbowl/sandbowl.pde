/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/3790*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

           ////////////
        ///            ///
     //                   //
   //     x                 //
  //    xXXXx                //
  //  xXXXXXXXx              //
  //  S A N D  x  G L O B E  //
  //           x             //
  //           x             //
   //          X            //
     //      xXXXx        //  
       /// xXXXXXXXx   ///
          /////////////      (c) Martin Schneider 2009
                       
                       
color sand=#ffcc00, beam=#000000, liquid=#ffffff, cursor=#ff0000;
int pixel=1, edge=2, wp=360, s=512, bits=65793, w=wp/pixel;
boolean fishbowl=true;
float motion=.25;
float flow=2;

PGraphics g;
int t;

void setup() {
  size(s,s);
  colorMode(HSB);
  background(beam);
  g = createGraphics(w,w,P2D);
  clearBowl();
}

void draw() {
  
  step();
    
  background(beam);
  pushMatrix();
    translate(s/2,s/2);
    rotate(r);
    image(g,-wp/2,-wp/2,w*pixel,w*pixel);
  popMatrix();

  drawCursor();

}

void step() {
  
  float dr= random(-PI*motion,PI*motion);
  int dy= round(-cos(r+dr));
  int dx= round(-sin(r+dr));
  for(int y=t%2;y<w;y+=2) 
    for(int x=(t%4)/2;x<w;x+=2){
      
      // gravity & floating
      int a=g.get(x,y);
      int b=g.get(x+dx,y+dy);
      if(a==liquid && (b&bits)==bits ) {
        g.set(x,y,b);
        g.set(x+dx,y+dy,a);      
      }   
      
      // drawing 
      if((mode&SAND)>0) {
        float d= dist(mx,my,x,y);
        if(d<flow) {
          if(mode == ERASE_SAND && (a&bits)==bits) g.set(x,y,liquid);
          if(mode == DRAW_SAND  && a==liquid     ) g.set(x,y,sand|bits);
        }
      }
    }  
  t++;
  
}




 //////////////////////////
 //                      //
 //    tiny sketches     //
 //                      //
 //////////////////////////


///// a small slection of tiny sketches /////

// sand box
class Sketch3659 extends SketchInSpace {
  int s,a,n,d,b,o,x;
  void setup(){size(250, 250);}
  void draw(){stroke((key-1&15)*17);rect(mouseX,mouseY,9,0);o=2+n--%5;for(x=-1;x++<250;)for(d=n%2;d<250;a=get(x,d+=2),b=get(x+o,d-1))if((a&13|2*b&2)==14){set(x,d,b);set(x+o,d-1,a);}} 
}

// fractal cauliflower
class Sketch4312 extends SketchInSpace {
  int i,w=125,d=-96;
  void setup() {size(250,250);}
  void draw(){if(mousePressed|frameCount<2)background(0);noStroke();fill(-1,2*d);translate(w,w);ellipse(i=0,0,d,d);PImage p=get();p.mask(p);p.filter(11);for(;i++<4;image(p,d,d,w,w))rotate(mouseX*.01);} 
}

// portal
class Sketch4574 extends SketchInSpace {
  float i,r,a,t;
  void setup(){size(250,250,P3D);}
  void draw(){stroke(-1);tint(-999);image(g,0,1);for(i=0;i++<9*mouseX;a=noise(i%64)*9+t/r,point(r+r*cos(a),r+r*sin(a),-r-40))r=abs(noise(i)-.2)*mouseY;t++;}
}





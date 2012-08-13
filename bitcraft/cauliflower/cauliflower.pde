/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4312*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int i,w=250,d=-192;void draw(){if(mouseY<w)background(0);noStroke();fill(-1,d);translate(w,w);ellipse(i=0,0,d,d);PImage p=get();p.mask(p);p.filter(11);for(;i++<4;image(p,d,d,w,w))rotate(mouseX*.01);}

/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4575*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
float x,i,w=250;void draw(){smooth();noStroke();colorMode(3,24,1,1);fill(key&31,1,1,32);translate(w,w);x=x*.9+mouseX*.1;for(background(i=0);i++<60;scale(mouseY/w/2),ellipse(0,125,w,w))rotate(PI/w*x);}

/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4277*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
float i,s=256,h;void setup(){size(512,512,P3D);}void draw(){lights();noStroke();translate(s,0);for(background(i=0);i++<s;translate(0,mouseY/s),fill(h=135+sin(i*.04)*120),box(8,8,h))rotateY(mouseX/s);}
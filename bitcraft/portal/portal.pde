/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4574*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
float i,r,a,t;void setup(){size(500,500,P3D);}void draw(){stroke(-1);tint(-999);image(g,1,1);for(i=0;i++<9*mouseX;a=noise(i%64)*9+t/r,point(r+r*cos(a),r+r*sin(a),-r-40))r=abs(noise(i)-.2)*mouseY;t++;}
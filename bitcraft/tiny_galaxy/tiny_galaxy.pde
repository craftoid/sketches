/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4573*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
float i,r,a,t;void setup(){size(800,400,P3D);}void draw(){stroke(-1);tint(#f5faff);image(g,.5,.5);for(i=0;i++<1E4;a=noise(i%64)*9+t/r,point(400+cos(a)*r,200+sin(a)*r/2))r=abs(noise(i)-.2)*mouseX;t++;}
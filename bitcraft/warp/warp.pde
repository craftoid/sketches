/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4190*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
PImage o;int i,x,y,a,b,r,w=500;
void draw(){if(i<1)o=get();for(i=0;i<w*w;r=(int)dist(a=mouseX/8*8,b=mouseY/8*8,x=i%w,y=i++/w),set(x,y,o.get(a+(x-a)*w*r/w/w,b+(y-b)*w*r/w/w)))if(r<4)o.set(x,y,key-11);}
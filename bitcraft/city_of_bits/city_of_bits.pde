/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4276*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int c,i,t,y;
void setup(){size(512,512,P3D);}
void draw(){lights();for(background(i=0);i++<4096;translate(y<1?-504:8,y<1?8:0),fill(c=int(255*noise(t+y))&int(255*noise(t+i/64))),box(5,5,c))y=i%64;t++;}
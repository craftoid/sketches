/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4630*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int s=256,i,j;float x,y,n;void draw(){smooth();for(background(i=-1);++i<8*s;)line(x,y,x=f(0),y=f(1));}float f(int d){for(n=s,j=9;j-->1;n+=sin(PI*(d*.5+(mouseX>>(j-d)&1)+i/8f/(s>>j)))*s/3/j);return n;}
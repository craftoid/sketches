/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/3625*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
float s=256,c,t,z;int i,j;void draw(){t-=.02;rect(-1,-1,2*s,2*s);c=(2-mouseY/s);fill(0,90);for(i=0;i<s;i++)for(j=0;j<s;stroke(i^j,i,j),point(s+c*(i-s/2+z*sin(t)),s+c*(j++-s/2+z*cos(t))))z=(i^j)-s/4;}
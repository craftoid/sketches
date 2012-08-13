/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/3835*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int j,i,n,g=64;void setup(){textFont(createFont("",9),g);}void draw(){background(192);for(i=0;i<g;i++)for(n=-g;n<0;text(char(i+311*g),g*(i%8)-n,g*(i/8+1)-n++))fill(255+n,n>sin(j*i*.002)*g?0:255);j++;}
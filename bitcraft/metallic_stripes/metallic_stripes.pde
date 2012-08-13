/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4262*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int x,y,d,e;void draw(){e+=(mouseY-99)/9*4;d+=4;noStroke();background(-key*8);fill(0,15);for(x=0;x<200;x++)for(y=0;y<200;y+=4)rect(x,y,f(x+d),f(y+e));}int f(int n){return 4<<int(4*noise(n/5*.5));}
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4263*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int x,y,t;
void draw(){rectMode(3);noStroke();background(-1);fill(0,31);for(x=0;x<404;x+=4)for(y=0;y<404;y+=4)rect(x,y,f(x),f(y));t+=(mouseY-200)/20;}
int f(int n){return 4<<int(3*noise((t*4+n)*.1));}
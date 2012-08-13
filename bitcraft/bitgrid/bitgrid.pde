/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4257*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int x,y,t,s=400;void draw(){rectMode(3);noStroke();background(0);fill(-1,31);for(x=0;x<s;x+=4)for(y=0;y<s;y+=4)rect(x,y,f(y),f(x));t-=4;}int f(int n){return 4<<int(3*noise((t+abs(n-s/2))*mouseY/s));}
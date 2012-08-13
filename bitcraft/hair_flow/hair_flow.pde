/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4107*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int h,a,i,r=500;void draw(){smooth();a-=mouseX-r/2;i-=mouseY-r/2;for(background(h=-1);++h<r;)for(float y=h,x=noise(y)*r,n,c=0;++c<9;line(x,y,x+=sin(n)*9,y+=cos(n)*9))n=noise((x+a/9)/99,(y+i/9)/99)*6;}
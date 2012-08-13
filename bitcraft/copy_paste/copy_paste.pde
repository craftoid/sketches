/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4392*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int w=256,r=16,i,t;void draw(){for(i=0;i<w*w;i++)set(i%w,i/w,2*noise(i%w/r,i/w/r)>1?-1:-w<<(dist(mouseX/r,mouseY/r,i%w/r,i/w/r)<3?0:r));copy(t%12*r,t/12*r,80,80,w+r,0,80,80);t+=key<r?random(144)-t:0;}
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4133*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int l,i,f,e,
c=-1,s=400;void draw(){PImage h=get();for(l++;e<s*s;h.set(e%s,e/s,l<2?-e%3:get(e%s,e/s)==c?f>2&&f<5?c:0:f==3?c:0),e++)for(i=f=0;i<9;i++)f+=get(e%s-1+i%3,e/s-1+i/3)==c?1:0;image(h,e=0,0);}
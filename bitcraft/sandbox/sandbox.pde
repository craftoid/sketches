/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/3659*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int s,a,n,d,b,o,x;
void draw(){stroke((key-1&15)*17);rect(mouseX,mouseY,9,0);o=2+n--%5;for(x=-1;x++<500;)for(d=n%2;d<500;a=get(x,d+=2),b=get(x+o,d-1))if((a&13|2*b&2)==14){set(x,d,b);set(x+o,d-1,a);}}

/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/3540*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
float d=300,e,f,x,y,i,t,z,q;void draw(){q+=.01;z=7*(1.5+cos(q))/d;for(x=0;x<d;x++)for(y=0;y<d;stroke(abs(e),30),point(y++,x),e=f=0)for(i=0;i++<d&&e*e<9/z;f=2*e*f+(y-d/2)*z,e=e*e-t+(x-d/2)*z)t=f*f;}

/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/3542*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
float d=300,e,f,x,y,i,t,z;void draw(){z=1/d+5*mouseY/d/d;for(x=0;x<d;x++)for(y=0;y<d;stroke(abs(e)),point(y++,x),e=f=0)for(i=0;i++<d&&e*e<9/z;f=2*e*f+(y-d+mouseX)*z,e=e*e-t+(x-d/2)*z)t=f*f;}


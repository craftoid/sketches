/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4634*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
void draw(){
	background(0);stroke(-1);for(int t,a,b,j,i=0,x=64,s=1+mouseY/x;i<2*x;i++)
	for(j=t=0,a=b=256;j<8*x/s;j++){t=j|mouseX;line(a,b,a+=s*int(2*cos(PI*(i^t)/x)),b+=s*int(2*sin(PI*(i^t)/x)));}
}
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4461*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int b,i,t,d,a,n,c,e;
void draw(){n=key&63;for(background(i=0);i++<n*n;stroke(-1,e+=n-dist(a=f(),b=f(),c=f(),d=f())-e))if(e>0)line(a,b,c,d);}int f(){return int(500*noise(t++%4>1?i/n:i%n,t%2*n+t/1E6));}
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6478*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int t,i,n,y,w=99;
void draw(){
	n=key&15;
	for(i=0;i<w*w;i++){
	float e=w;
	for(y=0;y<n;y++)
		e=min(dist(i/w,i%w,w*noise(y,1+t/1E7),w*noise(y,t++/1E7)),e);
	stroke(255-e*key/8);
	point(i/w,i%w);
	}
}
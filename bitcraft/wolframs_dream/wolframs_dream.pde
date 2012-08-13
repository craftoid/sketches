/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4552*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int x,y,i,n,s=256,c=#000000,r=110;
void draw(){
	for(y=s;y>=0;y--)
		for(x=0;x<s;x++){
			for(i=n=0;i<3;i++)n=2*n+(get((x+i-1+s)%s,y-1)==c?1:0);
			set(x,y,x==mouseX&y==mouseY|(r>>n&1)>0?c:-1);
		}
}

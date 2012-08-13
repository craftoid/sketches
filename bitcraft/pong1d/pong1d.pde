/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/3455*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int x=195,s=1;void draw(){x=keyPressed?195:x;x+=s;if(x<9||x>381)s=-s;fill(0,1);rect(0,0,398,10);fill(255);rect(1,1,8,8);rect(389,1,8,8);rect(198,3,4,4);rect(x,1,8,8);filter(11);}

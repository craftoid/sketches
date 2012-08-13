/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/3549*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int t,i,x,f,w=500;PFont p=createFont("",100);void draw(){background(0);String s=loadStrings("../t.pde")[0];for(i=3;i<8;f=w/45*i,fill(1<<i++),textFont(p,f),text(s,w+(f*.004*t--)%(w+textWidth(s)),f));}

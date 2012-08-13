/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/3066*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

  /////    ///    
  // //   ///                         
  /////  ///                              
        ///                          
       ///  /////  
      ///   // //     Modulo Visualizer  
     ///    /////     (c) Martin Schneider 2009    
     
     
// inspired by Herbert Spencer's Modulo Sketch:
// http://www.openprocessing.org/visuals/?visualID=2775


int modFn, ruler, fillUp;
int remainder, divisor, dividend;
PFont font1, font2;
int m, ht;
String[] fnName = {"trunc", "floor", "euclid"};
int[][] scheme = {{0,0}, {1,0}, {0,1}}; 
color[] pal = {#666666, 0, #ff6666};
int shades = 8;
int light = 0;
int mark = 0;


void setup(){
  
  size(301, 401);
  
  textAlign(CENTER); 
  rectMode(CORNERS); 
  colorMode(HSB);
  strokeWeight(0);
  
  ht = height - width; 
  m = width/2;
  font1 = createFont("Georgia", 28); 
  font2 = createFont("Georgia", 11); 
  
  dividend = m*3/5;
  divisor = -m/5; 
  
  ruler = 1;
  fillUp = 3;
 
} 
 
 
void draw(){ 
  background(255);
  interaction();
  graph();
  legend();   
} 

  
void graph() {
  
  int d = abs(divisor);
  int dm = -d/2;
  int dp = d/2 + d%2;
  int mm = (2 + m/d) * d -1;
  int x=0, xs=0;
  
  pushMatrix();
  translate(m, m+ht);
  for(int i = mm; i >= -mm; i--){ 
    int d1=0, d2=0;
    switch(modFn) {
      case 0: x = i % divisor;  d1 = i <0 ? 1 : 0; break;
      case 1: x = modFloor(i, divisor); d1 = d2 = divisor <0 ? 1 : 0; break;
      case 2: x = modEuclid(i, divisor); 
      break;
    }
    if  (dividend == i) remainder = x; 
    color c = ((i<0 && i<dividend+d1) || (i>=0 && i<dividend+d2)) ? pal[2] : pal[0]; 
    shade(c,0);
    switch(fillUp) {
      case 0: line(i, 0, i, -x); break;
      case 1: line(i, -x, i-x, -x); break;
      case 2: line(i+dm+1, -x, i+dp-1, -x); break;   
      case 3: 
        line(i+dm+1, -x, i+dp-1, -x); 
        shade(c,1); line(i+dm, -x-1, i+dm, -x-d+2);
        if(x-xs>1) { shade(c,2); stroke(255); rect (i+dp+1, -x-1, i+dm+1, -x-d); }
        break;
    }   
    xs=x;
  }
  popMatrix();  
}


void legend() {

  if(ruler>0) {
    stroke(100, 100); 
    line(m,ht,m,height);
    line(0,m+ht,width,m+ht);
  }
  
  if(ruler>1) {
    stroke(pal[2]); line(0,ht+m-remainder,width,ht+m-remainder);
    mark(0); line(m+dividend,ht,m+dividend,height);
    mark(1); line(0,ht+m-divisor,width,ht+m-divisor);
  }  
    
  fill(255,200); noStroke(); rect(0,0,width, ht);
  
  textFont(font1);  
  float ta1 = textAscent();
  float td1 = textDescent();
  float ty = (ht + ta1)/2; 
  
  mark(0); text(dividend, width*1/6, ty); 
  fill(0); text("%", width*2/6, ty);
  mark(1); text(divisor, width*3/6, ty); 
  fill(0); text("=", width*4/6, ty);
  fill(pal[2]);  text(remainder, width*5/6, ty); 

  textFont(font2); 
  float ta2 = textAscent();
  float td2 = textDescent();  

  fill(pal[0]);
  text("[right] +", width*1/6, ty - ta1 - td2); 
  text("[left] -", width*1/6, ty + td1 + ta2);
  text("[space]", width*2/6, ty - ta1 - td2);  
  text("[up] +", width*3/6, ty - ta1 - td2); 
  text("[down] -", width*3/6, ty + td1 + ta2);
  
  fill(0); 
  text(fnName[modFn], width*2/6, ty + td1 + ta2); 
}


void interaction() {  
  int dir=CENTER;
  
  if(keyPressed) dir = keyCode; 
  else if(mousePressed) 
    switch(mouseButton) {
      case LEFT: 
        dividend = mouseX-m;
        dir = LEFT; 
        break;
      case RIGHT: 
        divisor = height-mouseY-m-1;  
        dir = UP; 
        break;
    }    
     
  mark = (dir==LEFT || dir==RIGHT) ? 1 : (dir==UP || dir==DOWN) ? 2 : 0;

  divisor = constrain(divisor, -m, m);
  dividend = constrain(dividend, -m, m);
  if(divisor==0) divisor += (dir==UP) ? 1 : -1;
}

void keyPressed() {
  switch(key) {
    case ' ': modFn = ++modFn % 3; break;
    case '+': ruler = ++ruler % 3; light = ruler>1 ? 2 : 0; break;
    case RETURN:; case ENTER: fillUp = ++fillUp % 4; break;
  }
  switch(keyCode) {
    case RIGHT: dividend++; break;
    case LEFT: dividend--; break;
    case UP: divisor ++; break;
    case DOWN: divisor -- ; break;
  }
}


void mark(int i) {
  stroke(pal[scheme[mark][i]], 200);
  fill(pal[scheme[mark][i]]);
}

void shade(color c, int shade) {
  shade += light;
  shade *= (255/shades);
  color s = color(hue(c), saturation(c)-shade, brightness(c)+shade);
  stroke(s); fill(s);
}

// modulo functions

int modEuclid(int a, int n) {
  return n > 0 ? modFloor(a,n) : modCeil(a,n);  
}

int modFloor(int a, int n) {
  return a - n * floor(float(a)/n);
}

int modCeil(int a, int n) {
  return a - n * ceil(float(a)/n);
}


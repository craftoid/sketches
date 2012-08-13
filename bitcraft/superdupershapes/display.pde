
/// DISPLAY PANE ///

boolean xchange = true, help = true, info = true, params = true;
int fontSize = 12, cols;
float cWidth = 100, blendSpeed = .1;
String[] infoStyle = {"",":  "}, helpStyle = {"[ "," ] "};

float hHelp, hInfo, tableTop, yInfo, yHelp;
String[] cellStyle;

void drawDisplay() {
  float t;
  // info bar
  t = (info && xchange)  ? hInfo : (info && !xchange ? -hInfo : 0);
  yInfo = lerp(yInfo,t,blendSpeed) ;
  tableTop = yInfo + height; drawInfo(); 
  hInfo = tableTop-yInfo-height; 
  tableTop = yInfo - hInfo; drawInfo();
  // help bar
  t = (help && !xchange) ? hHelp : (help && xchange ? -hHelp : 0);
  yHelp = lerp(yHelp,t,blendSpeed);
  tableTop = yHelp + height; drawHelp();
  hHelp = tableTop-yHelp-height; 
  tableTop = yHelp - hHelp;  drawHelp(); 
}

void drawHelp() {
  cols = 4; cellStyle = helpStyle;
  drawTable("display", new String[][] {{"h", "help"}, {"i", "info"}, {"p", "params"}, {"x", "xchange"}});
  drawTable("render", new String[][] {{"m", "mode"}, {"c", "color"}, {"l", "light"}, {"g", "grid"}});
  drawTable("shape", new String[][] {{"space",  "next"}, {"u", "undo"}, {"o", "output"}});  
  int p =  fn.labels.length; 
  String[][] pt = new String[p][];
  for(int i=0; i< p; i++) pt[i] = new String[] {str(paramKeys.charAt(i)), fn.labels[i] };
  drawTable("params", pt);  
  String[] speed = {"superfast", "fast", "slow", "superslow"};
  String[][] mt = navigationMode ? 
    new String[][] {{"left", "tumble"}, {"middle", "move"}, {"right", "rotate & zoom"}} :
    new String[][] {{"left", speed[mousePrecision[0]]}, {"middle", speed[mousePrecision[1]]}, {"right", speed[mousePrecision[2]]}};
  drawTable("mouse buttons", mt);  
}

void drawInfo() {
  cellStyle = infoStyle;
  if(params) {
    cols = 4; 
    int p = fn.labels.length;
    String[][] pt = new String[p][];
    String name = fn.getName();
    for(int i=0; i< p; i++) 
      pt[i] = new String[] {fn.labels[i], str(fn.r[i])};
    drawTable(name + " params", pt);
  }
  else {
    String[] res = {"lores", "dynamic", "hires"};
    int ures = mode > 0 ? hiRes : loRes;
    int vres = int(ures * fn.getRatio());
    cols = 3; drawTable("render params", new String[][] {
      {"mode",res[mode]}, {"u", str(ures) }, {"v", str(vres)}, 
      {"color", colors ? "on" : "off" },  {"light", light ? "on" : "off"}, {"grid", grid ? "on" :"off"}
    });
  }
}

void drawTable(String headline, String[][] t) {
  float lh = fontSize + 2, bx = 6, by = 3, ts = 1;
  float ty, tw = width - 2 * by;
  float th = (1 + ceil(float(t.length) / cols)) * lh + 4*by ;
  ty = tableTop; tableTop += th + ts;
  noStroke(); fill(255,30); rect(0, ty, width, th);
  pushMatrix(); 
  translate(bx, ty + by + fontSize);
  fill(255); textFont(bfont,fontSize); text(headline,0,0); 
  translate(0, lh+by);
  for(int i=0; i<t.length; i++) 
    drawCell(t[i],  min(cWidth,width/cols) * (i%cols), i/cols * lh);
  popMatrix();    
}

void drawCell(String[] entry, float x, float y) {
  PFont[] f = {font, bfont, font};
  String[] s = {cellStyle[0], entry[0], cellStyle[1] + entry[1]};
  float w, x1 = x;
  for(int i=0; i<3; i++) {
    textFont(f[i], fontSize); w=textWidth(s[i]); text(s[i], x1, y); x1+=w;
  } 
}

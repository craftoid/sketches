
void drawLabels() {
  int allrules = (1 << (iter * 2));
  int vignetteNo = 1 + (rule  & (allrules - 1));
  label("Iteration", str(iter), LEFT);
  label("Vignette", "" + vignetteNo + "/" + allrules, CENTER);
  label("Radius",  str(radius), RIGHT);

}

void label(String title, String value, int align) {
  String sep = ": ";
  float wtitle, wvalue, px, py;
  fill(colors ? color(0, 191) : 0); 
  noStroke();
  
  // we need to take care of the alignment our selves 
  // since we are using different fonts for title and labels
  
  textFont(font); wtitle = textWidth(title + sep);
  textFont(bfont);  wvalue = textWidth(value);
  px = align == LEFT ? xborder + wtitle: align == RIGHT ? width - xborder - wvalue: width / 2;
  py = yborder + fontsize;
  textAlign(RIGHT); textFont(font); text(title + sep, px, py);
  textAlign(LEFT); textFont(bfont); text(value, px, py);
}



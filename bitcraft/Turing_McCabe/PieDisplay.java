
/////////////////////////////////////////////////////////////////////////////
//                                                                         //
//    Pie Button Controls - for use with Radiobuttons or Checkboxes        //
//                                                                         //
/////////////////////////////////////////////////////////////////////////////

import controlP5.*;
import processing.core.PApplet;

public class PieDisplay implements ControllerDisplay {
  int r, slices;
  
  PieDisplay(int r) {
    this.r = r;
    this.slices = 0;
  }
  PieDisplay(int r, int slices) {
    this.r = r;
    this.slices = slices;
  }
  
  public void display(PApplet app, Controller ctrl) {
    app.pushStyle();
    Toggle bttn = (Toggle) ctrl;
    if (ctrl.value() == 1.0) {
      app.fill(ctrl.color().getActive());
    } else {
      app.fill(ctrl.color().getForeground());
    }
    int h = ctrl.getHeight();
    float ang = app.TWO_PI/slices ;
    app.smooth();
    app.ellipseMode(app.CENTER);
    app.ellipse(h/2,h/2, r, r);
    app.stroke(ctrl.color().getBackground());
    for(int i=0; i<slices; i++) {
      int r = h/2;
      float x = r + r * app.cos(ang * i - app.HALF_PI);
      float y = r + r * app.sin(ang * i - app.HALF_PI);
      app.line(r, r, x, y);
    }
    app.popStyle();
  }
}



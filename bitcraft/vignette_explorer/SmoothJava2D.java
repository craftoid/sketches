
// Fixing a Processing bug ...

// We force Java2D to create strokes with subpixel accuracy.
// this seems to be the default for the Processing IDE
// but this is not necessarily the case for the JRE running inside your browser!

import java.awt.*;
import  processing.core.PGraphicsJava2D;

public class SmoothJava2D extends PGraphicsJava2D {
  public void smooth() {
    super.smooth();
    g2.setRenderingHint(RenderingHints.KEY_STROKE_CONTROL, RenderingHints.VALUE_STROKE_PURE); 
  }
}


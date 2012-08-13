
/// OUTPUT IMAGE ///

import processing.dxf.*;
import processing.pdf.*;

PGraphics og;

void beginOutput(PGraphics g) {
  if (!output) return;
  output = false;
  String writer = null;
  String filename = selectOutput("Output "+fn.getName());
  if(filename == null) return;
  String ext = filename.substring(filename.lastIndexOf('.') + 1, filename.length()).toLowerCase();
  if (ext.equals("pdf")) writer = PDF; 
  if (ext.equals("dxf")) writer = DXF;
  if (writer == null) {
    g.format = RGB; // fix jpg transparency bug in processing
    g.save(filename);
    return; 
  }
  output = true;   
  og = createGraphics(width, height, writer, filename);
  g.hint(ENABLE_DEPTH_SORT);
  g.beginRaw(og);
}

void endOutput(PGraphics g) {
  if (!output) return;
  g.endRaw();
  g.hint(DISABLE_DEPTH_SORT);   
  output = false;
}

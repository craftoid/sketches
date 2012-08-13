/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6271*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

///// Beef it Up ! /////

// This sketch shows how you can 
// beef up the standard PShapeSVG class
// to create 3d animations from SVG files

// beef image based on:
// http://commons.wikimedia.org/wiki/File:British_Beef_Cuts.svg 

// (c) Martin Schneider 2009


int svgWidth, svgHeight;
Shape3D[] shapes;
int num;

float rot;
float intensity;
float zoom = .7;


void setup() {
   
  size(500, 350, P3D);

   // load XML 
   XMLElement xml = new XMLElement(this, "British_Beef_Cuts.svg");
   svgWidth = xml.getIntAttribute("width");
   svgHeight = xml.getIntAttribute("height");
  
   // create 3d SVG shapes 
   XMLElement[] kids = xml.getChild(0).getChildren();
   num = kids.length;
   shapes = new Shape3D[num];
   
   for(int i=0; i<num; i++) {
     String id = kids[i].getStringAttribute("id");
     shapes[i] = new Shape3D(id, kids[i]);
   }
   
   mouseX = width * 1/2; mouseY = height * 4/5;
   colorMode(HSB, num);
   noStroke();
  
}
 
 
void draw() {

  intensity = lerp(intensity, mousePressed ? 1 : 0, .05);
  
  background(#ffffff);
  lights();
  
  // some transformations,  
  translate(width/2, height/2); 
  rotateX(float(height/2-mouseY) / height * HALF_PI);
  rotateY(float(mouseX-width/2) / width * HALF_PI);
  rotateZ(rot);
  scale(min(width * zoom/svgWidth, height * zoom/svgHeight));
  translate(-svgWidth/2, -svgHeight/2);

  // draw 3d shapes
  for(int i=0; i<num; i++) {

    Shape3D s = shapes[i];
    color c;
    
    pushMatrix();
  
      // set shape attributes   
      if(s.id.equals("Cow")) {
        
         // flat base plane
         s.depth = 0;
         translate(0, 0, -1);
         c = color(0, 0, 0);  
         
      } else {        
        
         // extrude other shapes
         float elevation =  i * (1.5 + sin(frameCount *.1 + i) ) / 2.5 / num;
         s.depth = lerp(10, max(width,height) / 4, elevation * intensity);
         c = color(i, 128, 255);
         
      }
           
      // draw shape with custom color
      s.disableStyle();
      fill(c);
      shape(s, 0, 0);
    
    popMatrix();
  } 
}


class Shape3D extends PShapeSVG {

  String id;  
  float depth;

  Shape3D(String _id, XMLElement xml) {
    super(null, xml); 
    parsePath();  //  create vertices
    id = _id;
  }
  
  public void draw(PGraphics g) {
   
    // draw bottom
    quickDraw(g);
    
    if(depth > 0) {  
      
      // draw top
      g.pushMatrix();
      g.translate(0, 0, depth);
      quickDraw(g);
      g.popMatrix();
      
      // draw side faces
      g.beginShape(QUAD_STRIP);
      for(int i=0; i<vertexCount; i++) {
        float[] v = vertices[i];
        g.vertex(v[0], v[1], 0);
        g.vertex(v[0], v[1], depth);
      }
      g.endShape();
    }
    
  } 
  
  // quick and dirty - no curves just straight lines
  void quickDraw(PGraphics g) {
    g.beginShape();
    for(int i=0; i<vertexCount; i++) 
      g.vertex(vertices[i][0], vertices[i][1]);
    g.endShape();
  }

}


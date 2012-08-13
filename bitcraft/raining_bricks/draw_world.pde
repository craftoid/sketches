

// custom drawing for JBox2D

void draw(World world) {
  
  // draw all bodies of the world
  for (Body body = world.getBodyList(); body != null; body = body.getNext()) {
    
    boolean inside = false;
    
    // draw all shapes of the body
    for(org.jbox2d.collision.Shape s = body.getShapeList(); s != null; s = s.getNext()) {

      // apply style
      Style style = (Style) body.getUserData();
      if (style!=null) style.begin();
      
      // draw polygon
      if (s.getType() == ShapeType.POLYGON_SHAPE) {
        
        beginShape();
        Vec2[] vlist = ((PolygonShape) s).getVertices();
        for(int i = 0; i < vlist.length; i++) {
          Vec2 v = p.worldToScreen(body.getWorldPoint(vlist[i]));
          inside |= (v.y < height + depth & v.x > -depth & v.x < width + depth);
          vertex(v.x, v.y);
          
        } 
        endShape(CLOSE);  
        
        // draw 3d effect
        if((visMode & VIS_3D) > 0) {
          int n = vlist.length;
          for(int i = 0; i < n; i++) {
            Vec2 v1 = p.worldToScreen(body.getWorldPoint(vlist[(i+n-1)%n]));
            Vec2 v2 = p.worldToScreen(body.getWorldPoint(vlist[i]));
            beginShape();
              vertex(v1.x, v1.y, 0);
              vertex(v2.x, v2.y, 0);
              vertex(v2.x, v2.y, -depth);
              vertex(v1.x, v1.y, -depth);
            endShape(CLOSE);
          }
        }
      } 
      if (style!=null) style.end();
      
      // remove bodies beyond left, right and bottom border
      if(!inside) p.removeBody(body);

    }
  }
}


// style associated with a body

class Style {
  color fillColor;
  Style(color c) {
    fillColor = c;
  }
  void begin() {
    pushStyle();
    fill(fillColor);
  }
  void end() {
    popStyle();
  }
}


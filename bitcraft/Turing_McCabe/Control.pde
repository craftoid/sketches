
/////////////////////////////////////////////////////////////////////////////
//                                                                         //
//                            ControlP5 based GUI                          //
//                                                                         //
/////////////////////////////////////////////////////////////////////////////

import controlP5.*;

ControlP5 controlP5;
CheckBox checkbox;
RadioButton radio;
Textlabel label;
Slider slider;

final static int CONTROLLER = 0, TAB = 1, GROUP = 2;
final static int RESOLUTION = 1, SYMMETRY = 2, OPTIONS = 3, BRUSH = 4;
final static int STEP_OFFSET = 5, STEP_SCALE = 6, COLOR_OFFSET = 7, BLUR_LEVEL = 8;
final static int OPT_COLOR = 0, OPT_INVERT = 1;

boolean isInit, isUpdate;

int imgWidth, imgHeight;
int id;
int cx, cy;
int ygap = 36;
int controlWidth = 98;


/////////////////////////////// draw ////////////////////////////////////////

void drawControls() {
  controlP5.draw();
}


void drawImage(PImage img) {
  pushMatrix();
    translate(spacing, spacing);
    noFill();
    stroke(0);
    rect(-1,-1, imgWidth+1, imgHeight+1);
    image(img, 0, 0, imgWidth, imgHeight);
  popMatrix();
}


////////////////////////////// setup ////////////////////////////////////////

void setupControls() {
  
  isInit = false;
  controlP5 = new ControlP5(this);
  
  cx = imgWidth + 2 * spacing;
  cy = spacing;
   
  // custom color scheme
  controlP5.setColorActive(140);
  controlP5.setColorBackground(220);
  controlP5.setColorLabel(0);
  controlP5.setColorForeground(190);
    
  setupResolutionControl();
  setupSymmetryControl();
  setupOptionsControl();
  setupParamsControl();
  setupBrushControl();
  
  isInit = true;
  
}

void setupResolutionControl() {
  heading("RESOLUTION");
  radio = controlP5.addRadioButton("resolution", cx, cy);
  radio.setNoneSelectedAllowed(false);
  radio.setId(RESOLUTION);
  radio.setItemsPerRow(3);
  radio.setSpacingColumn(40);
  radio.addItem("resolution2" ,2).setLabel("lores");
  radio.addItem("resolution1", 1).setLabel("hires");
  cy += ygap;
}

void setupSymmetryControl() {
  heading("SYMMETRY");
  radio = controlP5.addRadioButton("symmetry", cx, cy);
  radio.setNoneSelectedAllowed(false);
  radio.setId(SYMMETRY);
  radio.setItemsPerRow(3);
  radio.setSpacingColumn(12);
  radio.setSpacingRow(10);
  radio.setItemHeight(20);
  radio.setItemWidth(20);
  for(int i=0; i<=6; i++) {
    if(i==1) continue;
    radio.addItem("symmetry" + i, i).setDisplay(new PieDisplay(20, i));
  }
  cy += 40 + ygap;
}

void setupOptionsControl() {
  heading("OPTIONS");
  checkbox = controlP5.addCheckBox("options",cx, cy);
  checkbox.setId(OPTIONS);
  checkbox.setItemsPerRow(2);
  checkbox.setSpacingColumn(40);
  checkbox.setSpacingRow(10);
  checkbox.addItem("color", OPT_COLOR);
  checkbox.addItem("invert", OPT_INVERT);
  cy += ygap;  
}

void setupParamsControl() {
  heading("PARAMS");
  cy += 5;
  makeSlider("step offset").setId(STEP_OFFSET);
  makeSlider("step scale").setId(STEP_SCALE);
  makeSlider("diffusion").setId(BLUR_LEVEL);
  slider = makeSlider("color offset");
  slider.setId(COLOR_OFFSET);
  slider.setLabel("color");
  cy += ygap/2;
}

void setupBrushControl() {
  heading("BRUSH"); 
  radio = controlP5.addRadioButton("brush",cx, cy);
  radio.activateEvent(false);
  radio.setNoneSelectedAllowed(false);
  radio.setId(BRUSH);
  radio.setItemsPerRow(4);
  radio.setSpacingColumn(10);
  radio.setItemHeight(20);
  radio.setItemWidth(20);
  for(int i=3; i>=1; i--) {
    radio.addItem("brush" + i, i).setDisplay(new PieDisplay((1+i)*5)); 
  } 
  cy += ygap;   
}


////////////////////////////// update ///////////////////////////////////////

// mapping: params ==> controls

void updateControls() {
  if(isInit) {
    isUpdate = false;
    updateResolutionControl();
    updateSymmetryControl();
    updateOptionsControl();
    updateParamsControl();
    updateBrushControl();
    isUpdate = true;
  }
} 

void updateResolutionControl() {
  getRadioButton("resolution").activate("resolution" + resolution); 
}

void updateSymmetryControl() {
  getRadioButton("symmetry").activate("symmetry" + symmetry);
}

void updateParamsControl() {
  updateSlider("step offset", stepOffsetMin, stepOffsetMax, stepOffset);
  updateSlider("step scale", stepScaleMin, stepScaleMax, stepScale);
  updateSlider("color offset", 0, 255, colorOffset);
  updateSlider("diffusion", 0, 1, blurFactor);
}

void updateOptionsControl() {
  checkbox = getCheckBox("options");
  getToggle("color").setValue(colMode);
  getToggle("invert").setValue(invertMode);
}

void updateBrushControl() {
  getRadioButton("brush").activate("brush" + brush);
}


/////////////////////////////// events ///////////////////////////////////////

//  mapping: controls ==> params

void controlEvent(ControlEvent theEvent) {
  

   // ignore events triggered during setup
  if(!isInit || !isUpdate) return;
  
  // all other events are handled via their type and ID
  int val, id, type = theEvent.type();
  
  switch ( type ) {
    
    case GROUP:
    
      ControlGroup theGroup = theEvent.group();
       // println("group "+theGroup.name());
      val = (int) theGroup.value();
      id = theGroup.id();
      
      switch ( id ) {
        
        case SYMMETRY:
          symmetry = val;
          resetParams();
          break;
          
        case BRUSH:
         brush = val;
         break;
         
        case OPTIONS: 
          boolean[] opts = toBoolean(theGroup.arrayValue());
          colMode = opts[OPT_COLOR];
          invertMode = opts[OPT_INVERT];
          break;
          
        case RESOLUTION:
          resolution = val;
          resetParams();
          break;
      }
      break;
      
    case CONTROLLER:
    
      Controller theController = theEvent.controller();
      // println("controller "+ theController.name());
      val = (int) theController.value();
      id = theController.id();
      
      switch ( id ) {
        
        case COLOR_OFFSET:
          colorOffset = (int) map(val, 0, 100, 0, 255);
          break;
          
        case STEP_SCALE:
          stepScale = map(val, 0, 100, stepScaleMin, stepScaleMax);
          updateParams();
          break;
          
        case STEP_OFFSET:
          stepOffset = map(val, 0, 100, stepOffsetMin, stepOffsetMax);
          updateParams();
          break;
          
        case BLUR_LEVEL:
          blurFactor = map(val, 0, 100, 0, 1);
          updateParams();
          break;
      }

      break;
  }   
}


////////////////////////// helper functions //////////////////////////////////

RadioButton getRadioButton(String name) {
  return (RadioButton) controlP5.group(name);
}

CheckBox getCheckBox(String name) {
  return (CheckBox) controlP5.group(name);
}

Slider getSlider(String name) {
  return (Slider) controlP5.controller(name);
}

Toggle getToggle(String name) {
  return (Toggle) controlP5.controller(name); 
}

void heading(String str) {
  label = controlP5.addTextlabel("heading" + id++, str, cx, cy);
  label.setFont(controlP5.grixel);
  label.setColorValue(0);
  label.setLetterSpacing(2);
  label.setWidth(controlWidth);
  cy += ygap / 2;
}

Slider makeSlider(String name) {
  cy += 11;
  slider = controlP5.addSlider(name, 0, 100,50, cx, cy, 100, 12);
  slider.setDecimalPrecision(0);
  slider.captionLabel().style().moveMargin(-15,0,0,-103);
  cy += 22;
  return slider;
}

void updateSlider(String name, float vmin, float vmax, float val) {
  getSlider(name).setValue((int) map(val, vmin, vmax, 0, 100));
}

boolean[] toBoolean(float[] a) {
  boolean[] a2 = new boolean[a.length];
  for(int i = 0; i < a.length; i++) a2[i] = (a[i] == 1);
  return a2;
}

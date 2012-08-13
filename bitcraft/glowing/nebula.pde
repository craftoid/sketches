
//NEBULA 

//Matt Schroeter 
//December 1st, 2008 
//matthanns.com 

float depth = 200;  

void setup(){ 
  size(400, 300, P3D); 
  noStroke();
} 

void draw(){ 
  background(15); 

  float cameraY = height/1; 
  float cameraX = width/1; 

  translate(width/2, height/2, -depth/2); 

  rotateY(frameCount*PI/500); 

  float fov = cameraX/float(width) * PI/2; 
  float cameraZ = cameraY / tan(fov / 2.0); 
  float aspect = float(width)/float(height); 

  perspective(fov, aspect, cameraZ/2000.0, cameraZ*4000.0); 


  translate(width/10, height/10, depth/2); 

  directionalLight(4, 166, 230, 1, 10, 0); 
  directionalLight(6, 230, 280, 10, 10, 0);
  
  for(int i=0; i<10; i++) { 

    rotateX(frameCount*PI/1000);

    for (int y = -2; y < 2; y++) { 
      for (int x = -2; x < 2; x++) { 
        for (int z = -2; z < 2; z++) { 

          pushMatrix(); 
          translate(400*x, 300*y, 300*z); 
          box(5, 5, 100); 
          popMatrix(); 

          pushMatrix(); 
          translate(400*x, 300*y, 50*z); 
          box(100, 5, 5); 
          popMatrix(); 

          pushMatrix(); 
          translate(400*x, 10*y, 50*z); 
          box(50, 5, 5); 
          popMatrix(); 

          pushMatrix(); 
          rotateY(frameCount*PI/400); 
          translate(100*x, 300*y, 300*z); 
          box(60, 40, 20); 
          popMatrix(); 

        } 
      } 
    } 
  } 
  if(!keyPressed) glow(4, 2);
} 


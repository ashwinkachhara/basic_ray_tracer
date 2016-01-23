class Sphere{
  PVector pos = new PVector();
  PVector Ca = new PVector();
  PVector Cd = new PVector();
  float radius;
  
  Sphere(PVector p, float r, PVector ka, PVector kd){
    pos = p.copy();
    radius = r;
    Ca = ka.copy();
    Cd = kd.copy();    
  }
  
  Sphere(){
    
  }
}
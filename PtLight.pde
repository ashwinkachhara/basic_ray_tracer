class PtLight{
  PVector pos = new PVector();
  PVector lColor = new PVector();
  
  PtLight(PVector p, PVector c){
    pos = p.copy();
    lColor = c.copy();
  }
  
  PtLight(){
  }
  
  boolean visible(PVector pt, PVector normal){
    PVector v1 = PVector.sub(pos,pt);
    float d = v1.dot(normal);
    return d>0;
  }
}
class PtLight{
  PVector pos = new PVector();
  PVector lColor = new PVector();
  
  PtLight(PVector p, PVector c){
    pos = p.copy();
    lColor = c.copy();
  }
  
  PtLight(){
  }
}
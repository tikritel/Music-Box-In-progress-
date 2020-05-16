class Mover {
 
//Our object has two PVectors: location and velocity.
  PVector l;
  
  
  //Ορισμός Μεταβλητών
  
  float x,y,w;
  //constructor
  Mover(PVector l) {
    x =l.x;
    y= l.y;
    w =l.z;
    
  }
 
  
 
  void display() {
    
    fill(0,250);
    ellipse(x,y,w,w);
  }
  
 
 
  void checkEdges() {
    if (x > width) {
      x = 0;
    } else if (x < 0) {
      x = width;
    }
 
    if (y > height) {
      y = 0;
    } else if (y < 0) {
      y = height;
    }
  }
}

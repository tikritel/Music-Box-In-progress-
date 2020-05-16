class Rings{
float location_x,location_y;
float life=200;
float s=60;
ArrayList<PVector> RingsHistory;   
int h=6000;

Rings(float x_, float y_){
location_x=x_;
location_y=y_;
RingsHistory = new ArrayList<PVector>();
}



void show(){
  if(!fadeout()){
    
 //directionalLight(255, 255, 255, 1, 1, -1);
  pushMatrix();
  
  //translate(width/2, height/2);
  translate(100,100);
  
  rotateY(location_x*1.0f/width*TWO_PI);
 rotateX(location_y*1.0f/height*TWO_PI);
  stroke(0);
  //render.drawEdges(mesh);
  fill(255);
  noStroke();
  //render.drawFaces(mesh);
  //selrender.drawFaces(mesh);
  fill(255, 0, 0);
  //Antialiasing on face edges can lead to false selection.
  //Use getKeyAA() to use a 3x3 sampling cross.
  
  //for(int i=22;i<83;i=i+6){
  // for(int k=22; k<=i; k=k+6){
   //πρέπει να φτιάξω πίνακα με τα χρώματα που θέλω
   //fill(location_x+i, location_y+i,380+i,life+k);
   //fill(200,40,80);
   for(int i=0;i<50;i++){
    render.drawPoint(source.nextPoint(),1);
   }
  // }
  //} 
  popMatrix();
}
}

void update(){
  
    for (int i = 0; i < this.RingsHistory.size(); i++) {
      RingsHistory.get(i).x += random(-s, s);
      RingsHistory.get(i).y += random(-s, s);
       }

    PVector v = new PVector(location_x,location_y);
    RingsHistory.add(v);
    if (RingsHistory.size() > h) {
      RingsHistory.remove(0);
    }  
  
  
}



boolean fadeout() {
    
    // Balls fade out
    life=life-2;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }
}

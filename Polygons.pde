class Polygons{
float location_x,location_y;
float life=100;
float s=60;
ArrayList<PVector> PolygonHistory; 
ArrayList<PVector> PolygonShapes;  
int h=600;

Polygons(float x_, float y_){
location_x=x_;
location_y=y_;
PolygonHistory = new ArrayList<PVector>();
}



void show(){
  if(!fadeout()){
    println("i am working in show");
  //directionalLight(255, 255, 255, 1, 1, -1);
  //directionalLight(127, 127, 127, -1, -1, 1);
  pushMatrix();
  translate(location_x, location_y);
  
  //πόσο γρήγορα θα κινείται
  rotateY(frameCount*0.07);
  stroke(0);
  //render.drawEdges(mesh);
  fill(255);
  noStroke();
  //render.drawFaces(mesh);
  //selrender.drawFaces(mesh);
  fill(255, 0, 0);
  //Antialiasing on face edges can lead to false selection.
  //Use getKeyAA() to use a 3x3 sampling cross.
  
  for(int i=22;i<83;i=i+6){
   for(int k=22; k<=i; k=k+6){
   //πρέπει να φτιάξω πίνακα με τα χρώματα που θέλω
   //fill(location_x+i, location_y+i,380+i,life+k);
   fill((k-30)*30,(k-30),(k-30)*10,80*life);
  
   }
  } 
  popMatrix();
}
}

void update(){
  
location_x += random(-16, 16);
location_y += random(-16, 16);
    

    for (int i = 0; i < this.PolygonHistory.size(); i++) {
      PolygonHistory.get(i).x += random(-s, s);
      PolygonHistory.get(i).y += random(-s, s);
       }

    PVector v = new PVector(location_x,location_y);
    PolygonHistory.add(v);
    if (PolygonHistory.size() > h) {
      PolygonHistory.remove(0);
    }  
  
  
}



boolean fadeout() {
    
    // Balls fade out
    life=life-10;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }
}

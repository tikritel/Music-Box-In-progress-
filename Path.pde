
// Path Following

class Path {

  // A Path is an arraylist of points (PVector objects)
  ArrayList<PVector> points;
  // A path has a radius, i.e how far is it ok for the boid to wander off
  float radius;

  Path() {
    // Arbitrary radius of 20
    radius = 20;
    points = new ArrayList<PVector>();
    //baζουμε καποια αρχκα σημεια
    PVector intpoint = new PVector(300,400);
    points.add(intpoint);
  }

  // Add a point to the path
  void addPoint(float x, float y) {
    PVector point = new PVector(x, y);
    points.add(point);
  }
  
  PVector getStart() {
     return points.get(0);
  }

  PVector getEnd() {
     return points.get(points.size()-1);
  }


  // Draw the path
  void display() {
    // Draw thick line for radius
    stroke(230, 230, 255);
    strokeWeight(radius*1.5);
    noFill();
    beginShape();
    for (PVector v : points) {
      curveVertex(v.x, v.y);
    }
    endShape();
    
    //// Καθορίζει με καποιο τροπο to περιγραμμα των κυκλων ?
    strokeWeight(1.2);
    //Fill();
    //beginShape();
    //for (PVector v : points) {
    //  println("v.x",v.x);
    //  println("v.y",v.y);
    //  curveVertex(v.x, v.y);
    //}
    //endShape();
   
  }
}

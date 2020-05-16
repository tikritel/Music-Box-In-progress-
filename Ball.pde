class Ball{
//αρχικοποιηση μεταβλητων
PVector l,location,acceleration,velocity,predict,predictLoc,neww;
float v_y,gravity,maxforce,maxspeed;
float life=250 ;
boolean isOnThePath = false;
  //Uα εχω μια boolean metavliti opote einai false tha stamataei kai oso einai true tha sinexiei na paizei
  
  //Constructor
  Ball(PVector l){
     acceleration = new PVector(0,0);
     v_y= random(0.5,4);
     velocity =new PVector(0,v_y);
     location = new PVector(l.x,l.y,l.z*random(0.1,0.5));
     //life=6;
     gravity=0.1;
     maxspeed = 2;
     maxforce = 0.1;
     //PVector surfaceMouse = surface.getTransformedMouse();
     //life = 250*tempo;
}
  
PVector getNormalPoint(PVector p, PVector a, PVector b) {
//PVector that points from a to p
    PVector ap = PVector.sub(p, a);
//PVector that points from a to b
    PVector ab = PVector.sub(b, a);
 
//Using the dot product for scalar projection
    ab.normalize();
    ab.mult(ap.dot(ab));
//Finding the normal point along the line segment
    PVector normalPoint = PVector.add(a, ab);
 
    return normalPoint;
  }
  
  //Functions
  
  void display(){
  //  offscreen.beginDraw();
    
  //offscreen.background(255);
  ////text("edooooo",location.x,location.y);
  //offscreen.stroke(0,life);
  //offscreen.fill(colorBall[0],colorBall[1],colorBall[2]);
  //offscreen.ellipse(location.x,location.y,location.z,location.z);
  //  offscreen.endDraw();
 
  
  //text("edooooo",location.x,location.y);
 stroke(0,life);
fill(colorBall[0],colorBall[1],colorBall[2]);
ellipse(location.x,location.y,location.z,location.z);
   

    
  }
  
  void move()
{
velocity.y=velocity.y+gravity;
//println("location.y is",location.y);
//r= random(2,10);
location.y=location.y+0.1*velocity.y;
// If square reaches the bottom
    // Reverse speed
    if (location.y > height) {
      // Dampening
      velocity.y = velocity.y * -1;
      location.y = height;
    }
//mporeis na βαλεις speed και για το x αξονα
  }
  
  void arrive(PVector target) {
    
    PVector desired = PVector.sub(target,location);
 
//The distance is the magnitude of the vector pointing from location to target.
    float d = desired.mag();
    desired.normalize();
//If we are closer than 100 pixels...
    if (d < 100) {
//...set the magnitude according to how close we are.
      float m = map(d,0,100,0,maxspeed);
      desired.mult(m);
    } else {
//Otherwise, proceed at maximum speed.
      desired.mult(maxspeed);
    }
 
//The usual steering = desired - velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  
void run() {
move();
display();
}
  
  boolean fadeout() {
    
    // Balls fade out
    life--;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void seek(PVector target) {
    //println("target",target);
    PVector desired = PVector.sub(target, location);  // A vector pointing from the position to the target

    // If the magnitude of desired equals 0, skip out of here
    // (We could optimize this to check if x and y are 0 to avoid mag() square root
    if (desired.mag() == 0) return;

    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force

      applyForce(steer);
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  
void follow(Path p) {

    // Predict position 50 (arbitrary choice) frames ahead
    // This could be based on speed 
    PVector predict = velocity.get();
    predict.normalize();
    predict.mult(50);
    PVector predictpos = PVector.add(location, predict);

    // Now we must find the normal to the path from the predicted position
    // We look at the normal for each line segment and pick out the closest one

    PVector normal = null;
    PVector target = null;
    float worldRecord = 1000000;  // Start with a very high record distance that can easily be beaten

    // Loop through all points of the path
    for (int i = 0; i < p.points.size()-1; i++) {

      // Look at a line segment
      PVector a = p.points.get(i);
      PVector b = p.points.get(i+1);
      

      // Get the normal point to that line
      PVector normalPoint = getNormalPoint(predictpos, a, b);
      // This only works because we know our path goes from left to right
      // We could have a more sophisticated test to tell if the point is in the line segment or not
      if (normalPoint.x < a.x || normalPoint.x > b.x) {
        // This is something of a hacky solution, but if it's not within the line segment
        // consider the normal to just be the end of the line segment (point b)
        normalPoint = b.get();
        
      }

      // How far away are we from the path?
      float distance = PVector.dist(predictpos, normalPoint);
      // Did we beat the record and find the closest line segment?
      if (distance < worldRecord) {
        worldRecord = distance;
        // If so the target we want to steer towards is the normal
        normal = normalPoint;

        // Look at the direction of the line segment so we can seek a little bit ahead of the normal
        PVector dir = PVector.sub(b, a);
        dir.normalize();
        // This is an oversimplification
        // Should be based on distance to path & velocity
        dir.mult(10);
        target = normalPoint.get();
        //if(!player.isPlaying()){
        //player.loop();
        //}
        target.add(dir);
        
      }
    }

    // Only if the distance is greater than the path's radius do we bother to steer
    if (worldRecord > p.radius) {
      seek(target);
      
      //move();
    }


    
    
  }

  boolean isInThePath(Path p, PVector location) {
    // Predict position 50 (arbitrary choice) frames ahead
    // This could be based on speed 
    PVector predict = velocity.get();
    predict.normalize();
    predict.mult(50);
    PVector predictpos = PVector.add(location, predict);

    // Now we must find the normal to the path from the predicted position
    // We look at the normal for each line segment and pick out the closest one

    PVector normal = null;
    PVector target = null;
    float worldRecord = 1000000;  // Start with a very high record distance that can easily be beaten

    // Loop through all points of the path
    for (int i = 0; i < p.points.size()-1; i++) {

      // Look at a line segment
      PVector a = p.points.get(i);
      PVector b = p.points.get(i+1);
      

      // Get the normal point to that line
      PVector normalPoint = getNormalPoint(predictpos, a, b);
      // This only works because we know our path goes from left to right
      // We could have a more sophisticated test to tell if the point is in the line segment or not
      if (normalPoint.x < a.x || normalPoint.x > b.x) {
        // This is something of a hacky solution, but if it's not within the line segment
        // consider the normal to just be the end of the line segment (point b)
        normalPoint = b.get();
        //to target ειναι η πιο κοντινη προβολη στο ball
        target = normalPoint.get();
        
      }
    }
    PVector desired = PVector.sub(target,location);
 
//The distance is the magnitude of the vector pointing from location to target.
    float d = desired.mag();
    desired.normalize();
//If we are closer than 100 pixels...
    if (d < 10) {
return true;
    }else{
      return false;
    }

}
}

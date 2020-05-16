class Triangle{
PVector position,point2,point3,point1,velocity,acceleration;
int h,s;
float location_x,location_y,v_y,maxspeed,maxforce;
float life=200;
ArrayList<PVector> history;

//Constructor
Triangle(float x_, float y_){
location_x=x_;
location_y=y_;
maxspeed=20;
maxforce = 0.1;
acceleration = new PVector(0,0);
v_y= random(0.5,4);
     velocity =new PVector(0,v_y);
history = new ArrayList<PVector>();
h=5;
s=9;

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
  
 void show() {
    if(!fadeout()){
   stroke(0);
    //fill(0,150);
    
    // TRAIL
    
    //ellipse(location_x,location_y,24,24);
    //println("x",x);
    for (int i = 0; i < history.size(); i++) {
     PVector  pos = history.get(i);
     fill(random(255));
     //ellipse(pos.x,pos.y,i,i);
     }
    beginShape();
    for (int i = 0; i < history.size(); i++) {
      PVector  pos = history.get(i);
      noStroke();
      //στο opacity μπορουμε να βαλουμε και i*20
      fill(random(pos.x),random(50,100),random(pos.y),life);
       //ellipse(pos.x, pos.y, i*8, i*20); // CIRCLES
      vertex(pos.x, pos.y);
 
     
    }
    endShape();
  
    } 
  };  
 
 void update() {
   //αυτο παει για το follow
   velocity.add(acceleration);
    velocity.limit(maxspeed);
   float velocity_x= velocity.x;
   float velocity_y= velocity.y;
   //float velocity_z= velocity.z;
   location_x +=velocity_x;
    location_y +=velocity_y;
     
    acceleration.mult(0);
    //allo
    location_x += random(-6, 6);
    location_y += random(-6, 6);
    

    for (int i = 0; i < this.history.size(); i++) {
      history.get(i).x += random(-s, s);
      history.get(i).y += random(-s, s);
       }

    PVector v = new PVector(location_x,location_y);
    history.add(v);
    if (history.size() > h) {
      history.remove(0);
    }
    
  };  
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

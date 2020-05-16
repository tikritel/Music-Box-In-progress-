//task gια σημερα 2/3:
//
//φτιαχνω χρωματικη παλετα με 5  tempo που αποθηκευεται σαν μεταβλητη πανω αριστερα στην οθονη! 
//και κανει ολα τα samples  se ayto to  tempo
//gain πόσο πάνω η κάτω ειναι το χέρι στο  leap?
//πρπει να φτιάξω συνάρτηση void ειναι το χερι μ στη διαδρομή 1? Τοτε παιξε το  σαμπλε  σε λουπα

//Παραδειγματα που θελω να ενταξω
//https://www.youtube.com/watch?v=ZI1dmHv3MeM&list=PLRqwX-V7Uu6bgPNQAdxQZpJuJCjeOr7VD&index=11https://www.youtube.com/watch?v=ZI1dmHv3MeM&list=PLRqwX-V7Uu6bgPNQAdxQZpJuJCjeOr7VD&index=11

//https://www.youtube.com/watch?v=RTc6i-7N3mshttps://www.youtube.com/watch?v=RTc6i-7N3ms
//Εισαγωγή βιβλιοθηκών
import deadpixel.keystone.*;
import codeanticode.syphon.*;
import de.voidplus.leapmotion.*;
import peasy.*;
//import peasy.org.apache.commons.math.*;
LeapMotion leap;
import processing.sound.*;
import ddf.minim.*;
//gia mesh
import wblut.math.*;
import wblut.processing.*;
import wblut.hemesh.*;
import wblut.geom.*;
WB_RandomPoint source;
WB_Render3D render;

//keystone
Keystone ks;
CornerPinSurface surface1,surface2,surface3,surface4;
PGraphics offscreen;

//Για Syphon
//PGraphics canvas;
SyphonServer server;
//Αρχικοποίηση για fluid
final int N = 128;
final int iter = 16;
final int SCALE = 6;
float t = 0;
float ballsInThePath = 0;
float location_x,location_y;
//Αρχικοποιηση
ArrayList<Ball> balls,ballsAnimation;
ArrayList<Triangle> triangles;
ArrayList<Rings> rings;
Button[] buttons;

//φτιαξιμο array  για το χρώμα των κουμπιων
int[] colorR = { 143, 212, 138,133,148 };
int[] colorG = { 153, 104, 171,120,24 };
int[] colorB = { 168, 28, 169,158,80};
int[] colorBall = new int[3];
float[] tempo = {0.9,1,1.25,1.5,1.7};
final PVector[] hand_position =new PVector[10];
// PVector[] Rhand_position =new PVector[10];
//final PVector[] Lhand_position =new PVector[10];
Mover mover;
Sound s;
Reverb reverb;
SoundFile[] mySoundFiles = new SoundFile[4];
AudioOutput out;
Ball ball;
Ball defaultBall;
Fluid fluid;
PVector l,k,location,ballLocation,handLocation;
Path path;
String gesture;
boolean isGrab = false;
boolean onThePath= false;
float tempoVar=250;
float INTERACTION_SPACE_WIDTH = 235.247; // left-right from user
float INTERACTION_SPACE_DEPTH = 150; // away-and-toward user
float INTERACTION_SPACE_HEIGHT = 235;//PANO KATO
float n;
int extendedFingers = 0;
boolean stop;

boolean testing =false;
void setup() {
leap = new LeapMotion(this).allowGestures("circle"); 

ks = new Keystone(this);
surface1 = ks.createCornerPinSurface(00, 150, 20);
surface2 = ks.createCornerPinSurface(400, 300, 20);
surface3 = ks.createCornerPinSurface(400, 300, 20);
surface4 = ks.createCornerPinSurface(400, 300, 20);
offscreen = createGraphics(300, 150, P3D); 

source=new WB_RandomCircle().setRadius(200);
render=new WB_Render3D(this);
stop=true;  

//fluid = new Fluid(0.2, 0, 0.0000001);
size(512, 512,P3D);
//size(812, 812,P3D);
//Create syphon server to send frames out
server = new SyphonServer(this,"Processing Syphon");
leap = new LeapMotion(this).allowGestures();
colorBall[0] = 143;
colorBall[1]= 168;
colorBall[1]=153;


//Ηχος
s=new Sound(this);
reverb = new Reverb(this);
//Φόρτωση Samples στον πίνακα των Samples
mySoundFiles[0] = new SoundFile(this, "093_jazzy-distant-drums.aif");
mySoundFiles[1] = new SoundFile(this, "acid-jazz-trumpet-1.wav");
mySoundFiles[2] =new SoundFile(this, "090_breath-jazz-sax-2.wav");
reverb.process(mySoundFiles[0]);
//Create an empty ArrayList (will store Ball objects) για το  animation και για το interactive κομματι
balls = new ArrayList<Ball>();
//δημιουργία των χρωματιστών buttons
buttons =new Button[6];
//Create Particles
triangles = new ArrayList<Triangle>();
rings = new ArrayList<Rings>();

//Create objects
l = new PVector(100,100,20);
mover = new Mover(l);
path = new Path();
newPath();
}
//void mousePressed() {
//  for(int i=0; i<3; i++){
//    mySoundFiles[i].stop();
//  }
//}
  

void leapOnCircleGesture(CircleGesture g, int state){
  println("i am working on gesture");
  int     id               = g.getId();
  Finger  finger           = g.getFinger();
  PVector positionCenter   = g.getCenter();
  float   radius           = g.getRadius();
  float   progress         = g.getProgress();
  long    duration         = g.getDuration();
  float   durationSeconds  = g.getDurationInSeconds();
  int     direction        = g.getDirection();
  
  switch(state){
    
    case 1: println("case1");
    //println("CircleGesture: " + id);
   // makePolygons(positionCenter);
      break;
    case 2: println("case2");
 
   testing =true;
  
    // Update
      break;
    case 3: println("case3");// Stop
      println("CircleGesture: " + id);
  //    void mousePressed() {
  //for(int i=0; i<3; i++){
  //  mySoundFiles[i].stop();
  //}
  //    }
      break;
  
  }
  switch(direction){
    case 0: // Anticlockwise/Left gesture
      break;
    case 1: // Clockwise/Right gesture
      break;
  }
  }

void mousePressed() {
    for(int i=0; i<3; i++){
    if(mySoundFiles[i].isPlaying()){
    mySoundFiles[i].stop();
    }
  }
}

void draw() {

background(0);
//if(testing){
 
// for(int i=0; i<3; i++){
// if(mySoundFiles[i].isPlaying()){
//   mySoundFiles[i].pause();
// }
//}
//}


//path.display();

//Δημιουργία Κουμπιών
for (int i=1; i<6; i++){
  //println(i);
  buttons[i] = new Button(colorR[i-1],colorG[i-1],colorB[i-1],20,(i*20));
  buttons[i].display();
  }
  
   

for (Hand hand : leap.getHands ()) {
boolean handIsLeft         = hand.isLeft();
boolean handIsRight        = hand.isRight();
PVector indexTip = hand.getIndexFinger().getPosition();
Finger index = hand.getIndexFinger();
Finger middle = hand.getMiddleFinger();
Finger ring = hand.getRingFinger();
Finger pinky = hand.getPinkyFinger();
int numOut = hand.getOutstretchedFingers().size();
println("nummm",numOut);
println("indextipPosition",indexTip);
PVector hp = hand.getPosition();
text("egoooo",hp.x,hp.y);
//println("egoooo",hp.x,hp.y);

//int extendedFingers = 0;
//for (int f = 0; f < hand.Fingers.Count; f++) {
//    Finger digit = hand.Fingers [f];
//    if (digit.IsExtended)
//        extendedFingers++;
//}

//kai sta dyo xeria
//if(index.isExtended()){
//  for(int i=0; i<3; i++){
//    mySoundFiles[i].stop();
//  }
  
//}



float h_x = map(hp.x, 0,INTERACTION_SPACE_WIDTH*2, 0, width);
//float h_x = map(hp.x, -INTERACTION_SPACE_WIDTH,INTERACTION_SPACE_WIDTH, 0, width);
//εδω mapping με το πλάτος του κουτιου?
//float h_z = map(hp.z, -INTERACTION_SPACE_DEPTH,INTERACTION_SPACE_DEPTH, 0, height);
float h_y = map(hp.y, 0,495,0,height);
PVector hand_position =new PVector(h_x,h_y,hp.z);
//Hover Κουμπιών
for (int i=1; i<6; i++){
  
  
  if(buttons[i].overRect(hand_position,20,i*20)){
    println("hand position is",hand_position,"over Rect");
    fill(colorR[i-1],colorG[i-1],colorB[i-1]);
    colorBall[0] = (colorR[i-1]);
    colorBall[1]=colorG[i-1];
    colorBall[2] =colorB[i-1];
    for(int j=0;j<3;j++){
    mySoundFiles[j].rate(tempo[i-1]);
    }
    tempoVar = tempo[i-1];
    
  }
  
}

//if(numOut==3){
  
// for(int i=0; i<3; i++){
// mySoundFiles[i].pause();
// }  
//}
//Παιρνουμε τις ιδιοτητες των χεριων
float grab = hand.getGrabStrength();
float pinch = hand.getPinchStrength();
float roll = hand.getRoll();
println(grab);
println(pinch);
println("Rroll",roll);

checkGesture(grab,pinch,index,numOut);
println("gesture is",gesture);

if(handIsLeft){

leaveballs(hand_position);
 makeButterflies(hand_position);
 makeRings(hand_position);
 pause();
 if(gesture == "grab"){
   
   isGrab = true;
 }
   else if(gesture == "nograb"){
//makeButterflies(hand_position);
   }
 else if(gesture == "pinch"){
   //makeRings(hand_position);
   
 }
 else{
   
      }
    
  }

//εδω θα γινει void checkHeight
if(handIsRight){
  //float effectStrength = map(hand_position.x, -100, 100, 0, 1);
  //println("wet=",effectStrength);
  println("handpossiiii",hand_position.y);
  if(hand_position.y<80 && hand_position.y>0){
    if(gesture == "grab"){
      mySoundFiles[0].amp(1);
      //reverb.wet(effectStrength);
    } else if(gesture == "nograb"){
      mySoundFiles[1].amp(1);
    }else if(gesture == "pinch"){
      mySoundFiles[2].amp(1);
    }
  }
  else if(hand_position.y<160 && hand_position.y>80){
    if(gesture == "grab"){
      mySoundFiles[0].amp(0.8);
      //reverb.wet(effectStrength);
    } else if(gesture == "nograb"){
      mySoundFiles[1].amp(0.8);
    }else if(gesture == "pinch"){
      mySoundFiles[2].amp(0.8);
    }
    
    
  }else if(hand_position.y<240 && hand_position.y>160){
     if(gesture == "grab"){
      mySoundFiles[0].amp(0.6);
      //reverb.wet(effectStrength);
    } else if(gesture == "nograb"){
      mySoundFiles[1].amp(0.6);
    }else if(gesture == "pinch"){
      mySoundFiles[2].amp(0.6);
    }
    
  }else if(hand_position.y<240 && hand_position.y>320){
    if(gesture == "grab"){
      mySoundFiles[0].amp(0.4);
      //reverb.wet(effectStrength);
    } else if(gesture == "nograb"){
      mySoundFiles[1].amp(0.4);
    }else if(gesture == "pinch"){
      mySoundFiles[2].amp(0.4);
    }
    
  }else{
    if(gesture == "grab"){
      mySoundFiles[0].amp(0.2);
      //reverb.wet(effectStrength);
    } else if(gesture == "nograb"){
      mySoundFiles[1].amp(0.2);
    }else if(gesture == "pinch"){
      mySoundFiles[2].amp(0.2);
    }
   
      
  }
}

}
//makes ready to send to madmapper
surface1.render(offscreen);
server.sendScreen();


}

void checkGesture(float grabs,float pinch_gesture,Finger Findex,int num){

if(grabs>0.8){
gesture = "grab";
    }else if(grabs==0){
      gesture = "no";
    }else{
      gesture = "other";
    }
if(pinch_gesture == 1){
      gesture = "pinch";
    }
if(Findex.isExtended()&& num == 1){
  gesture = "nograb";
}

}

void pause( String gesture){
if(gesture == "no"){
  
  for(int i=0; i<3; i++){
    if(mySoundFiles[i].isPlaying()){
    mySoundFiles[i].stop();
    }
  }
}
}
  
void makeButterflies(PVector bLocation) {
  if(gesture=="nograb"){ 
  //Triangle t = new Triangle(bLocation.x,bLocation.y);
   triangles.add(new Triangle(bLocation.x,bLocation.y)); 
 
 }
  for (int j = triangles.size()-1; j >= 0; j--)  { 
  Triangle t = triangles.get(j);
  t.update();
  t.show(); 
  
  if(t.fadeout()) {
    triangles.remove(j);
            
          }
  
  } 
 println("TrianglesSize",triangles.size()); 
     if(triangles.size()>0){
     if(!mySoundFiles[1].isPlaying()){
          mySoundFiles[1].loop();
          stop=false;
         
          } 
    }else if(triangles.size()==0){
      if(mySoundFiles[1].isPlaying()){
       mySoundFiles[1].pause();
       stop=true;
      }
  }
  
 
}

void makeRings(PVector rLocation){
   println("RingSizeisss",rings.size());
  if(gesture=="pinch"){
     Rings r = new Rings(rLocation.x,rLocation.y);
     rings.add(r);
   }
   for (int j = rings.size()-1; j >= 0; j--)  { 
  Rings r = rings.get(j);
  r.update();
  r.show(); 
  if(r.fadeout()) {
   rings.remove(j);
            
          }
  
  }
  
  if(rings.size()>0){
    
     if(!mySoundFiles[2].isPlaying()){
          mySoundFiles[2].loop();
          //stop=true
         
          } 
    }else if(rings.size()==0){
      if(mySoundFiles[2].isPlaying()){
       mySoundFiles[2].pause();
      }
   
}

}
void leaveballs(PVector hand_positions)
{
  
  if(gesture=="grab"){
  
  balls.add(new Ball(hand_positions));
  }
  for (int j = balls.size()-1; j >= 0; j--)  { 
          Ball ball = balls.get(j);
          //ball.life = tempoVar;
   
   
   
          
          ball.update();
          ball.move();
          ball.display();
          ball.follow(path);
          if(ball.fadeout()) {
            //Items can be deleted with remove()
            balls.remove(j);
            println("size",balls.size());
          }
          
          //εδω ελέγχω τι γινεται με τον ηχο; ayto prpei na ginei συναρτηση για ολες τις κλασεις
          if(balls.size()==0){
            println("ballssize",balls.size());
           if(mySoundFiles[0].isPlaying()){
           mySoundFiles[0].pause();
         }
         }else if(balls.size()>0 ){
           //if(gesture== "no"){
           //  if(mySoundFiles[0].isPlaying()){
           //mySoundFiles[0].stop();
             
           //  }
           //}
           if(!mySoundFiles[0].isPlaying()){
         mySoundFiles[0].loop();
          
         }
            
         }
         
   //εδω ελέγχω τι σκατα γινεται με το ποτε ακουγεται η μουσικη
          if(ball.isInThePath(path,ball.location)){
   //onThePath = true;
   println("ball.location",ball.location);
   ballsInThePath = ballsInThePath+1;
   println("balls in the path is",ballsInThePath);
   
   
   }
   
               }
  

}

  
  void handDragged(){
  for (Hand hand : leap.getHands ()) {
PVector hand_position = hand.getPosition();
int x = int(hand_position.x);
int y = int(hand_position.y);

  fluid.addDensity(int(x)/SCALE,int(hand_position.y)/SCALE,100);
  float amtX =x-y;
  float amtY =y-x;
  fluid.addVelocity(x/SCALE,y/SCALE,amtX,amtY);
  }
}

void newPath() {
  // A path is a series of connected points
  // A more sophisticated path might be a curve
  path = new Path();
  path.addPoint(-30, height/3);
  path.addPoint(width/3,height-100);
  //path.addPoint(width/3,height-100);
  path.addPoint(430, 400);
  //path.addPoint(430, 400);
  path.addPoint(width, height);
  path.addPoint(width, height);
}

void leapOnScreenTapGesture(ScreenTapGesture g){
  int     id               = g.getId();
  Finger  finger           = g.getFinger();
  PVector position         = g.getPosition();
  PVector direction        = g.getDirection();
  long    duration         = g.getDuration();
  float   durationSeconds  = g.getDurationInSeconds();

  println("ScreenTapGesture: " + id);
}

class Button{
//Αρχικοποίηση Μεταβλητών
int rectX;

int rectZ;
int rectY;
int colorbarR,colorbarG,colorbarB;
int rectWidth;
int rectHeight;
PVector handLocation;

boolean rectOver = false;

//Constructor 
 Button(int c_colorR, int c_colorG, int c_colorB, int c_rectX,int c_rectY){
   colorbarR = c_colorR;
   colorbarG= c_colorG;
   colorbarB = c_colorB;
   rectX = c_rectX;
   rectY= c_rectY;
   rectWidth=60;
   rectHeight= 20;
   
 }
  

void display(){
  noStroke();
  fill(colorbarR,colorbarG,colorbarB);
  rect(rectX,rectY,rectWidth,rectHeight);
  noFill();
  
  
}
void show(){
  println("rectx",rectX);
  println("rectY",rectY);
   
}

boolean overRect(PVector handLocation,int x, int y)  {
   int width =60;
   int height =20;
  if (handLocation.x >= x && handLocation.x <= width && 
      handLocation.y >= y &&  handLocation.y<= y+height) {
    return true;
  } else {
    return false;
  }
}



}

  
  

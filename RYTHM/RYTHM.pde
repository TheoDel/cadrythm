import ddf.minim.*;
import processing.serial.*;

Cadran cadA, cadB, cadC;
Serial myPort;
String valSerial;
int newPos;
Minim minim;
AudioPlayer playerA, playerB, playerC, playerD;

void setup() {
  //size(900, 450);
  fullScreen();
  cadA = new Cadran();
  cadB = new Cadran();
  cadC = new Cadran();

  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  
  minim = new Minim(this);
  playerA = minim.loadFile("Hajimemashite/Alto.mp3");
  playerA.loop();
  
  playerB = minim.loadFile("Hajimemashite/Chant.mp3");
  playerB.loop();
  playerB.setGain(-30);
  playerC = minim.loadFile("Hajimemashite/Basse.mp3");
  playerC.loop();
  playerC.setGain(-30);
  playerD = minim.loadFile("Hajimemashite/Soprano.mp3");
  playerD.loop();
  playerD.setGain(-30);
  
}

void draw() {
  //Lecture Arduino
  if ( myPort.available() > 0) 
  {
    valSerial = myPort.readStringUntil('\n');
    if (valSerial != null) {
      valSerial = valSerial.trim();
      if(valSerial.matches(".\\d+")){
        newPos = Integer.parseInt(valSerial.substring(1));
      }
      
      if(valSerial.charAt(0)=='A'){
        cadA.newInput(newPos);
      }
      else if(valSerial.charAt(0)=='B'){
        cadB.newInput(newPos);
      }
      else if(valSerial.charAt(0)=='C'){
        cadC.newInput(newPos);
      }
    }
  } 
  
  float rythmA = min(2, cadA.vitesseMoyenne());
  print(rythmA+" - ");
  rythmA = (int) map(rythmA, 0, 2, -30, 0);
  println(rythmA);
  playerA.setGain(rythmA);
  
  float distAB = 0-abs(cadA.ecartAvec(cadB)*5);
  playerB.setGain(min(rythmA,distAB));
  
  float distAC = 0-abs(cadA.ecartAvec(cadC)*5);
  playerC.setGain(min(rythmA,distAC));
  
  //float distBC = 0-abs(cadB.ecartAvec(cadC)*5);
  //playerD.setGain(distBC);


  clear();/*
  textSize(50);
  background(50);
  
    
  fill(210,210,210);
  rect(75, 280, 600, 20,10);
  
  fill(90,181,204);
  rect(75, 40, 600, 20,10);
  ellipse(100+50*cadA.getLastPos(), 50, 50, 50);
  ellipse(100+50*cadA.getLastPos(), 270, 50, 50);
  text("A", 25,70); 
  text(cadA.vitesseMoyenne(), 700, 70);
  
  fill(255,138,179);
  rect(75, 120, 600, 20,10);
  ellipse(100+50*cadB.getLastPos(), 130, 50, 50);
  ellipse(100+50*cadB.getLastPos(), 290, 50, 50);
  text("B", 25,150); 
  
  fill(255,247,164);
  rect(75, 200, 600, 20,10);
  ellipse(100+50*cadC.getLastPos(), 210, 50, 50);
  ellipse(100+50*cadC.getLastPos(), 310, 50, 50);
  text("C", 25,230); */
  
  
  textSize(100);
  background(50);
  
    
  fill(210,210,210);
  rect(150, 560, 1200, 40,20);
  
  fill(180,362,408);
  rect(150, 80, 1200, 40,20);
  ellipse(200+100*cadA.getLastPos(), 100, 100, 100);
  ellipse(200+100*cadA.getLastPos(), 540, 100, 100);
  text("A", 50,140); 
  text(cadA.vitesseMoyenne(), 1400, 140);
  
  fill(255,138,179);
  rect(75, 120, 600, 20,10);
  ellipse(100+50*cadB.getLastPos(), 130, 50, 50);
  ellipse(100+50*cadB.getLastPos(), 290, 50, 50);
  text("B", 25,150); 
  
  fill(255,247,164);
  rect(75, 200, 600, 20,10);
  ellipse(100+50*cadC.getLastPos(), 210, 50, 50);
  ellipse(100+50*cadC.getLastPos(), 310, 50, 50);
  text("C", 25,230); 

  
}
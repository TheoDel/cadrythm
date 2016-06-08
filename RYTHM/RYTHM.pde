import processing.serial.*;
import java.util.LinkedList;
import java.time.*;

// Dernières positions et heure du changement
int lastPos1, lastPos2, lastPos3;
Instant lastTime1, lastTime2, lastTime3;

// Listes des dernières positions et temps d'intervale enregistrées
LinkedList<Integer> prevPos1, prevPos2, prevPos3;
LinkedList<Duration> prevInterval1, prevInterval2, prevInterval3;
int maxLength = 10;

// Variable de maj
int newPos1, newPos2, newPos3;
Instant newTime;

Serial myPort;  // Create object from Serial class
String valSerial;     // Data received from the serial port

void setup() {
  size(600, 400);

  lastPos1 = lastPos2 = lastPos3 = 1;
  lastTime1 = lastTime2 = lastTime3 = Instant.now();
  prevPos1 = new LinkedList<Integer>();
  prevPos2 = new LinkedList<Integer>();
  prevPos3 = new LinkedList<Integer>();
  prevInterval1 = new LinkedList<Duration>();
  prevInterval2 = new LinkedList<Duration>();
  prevInterval3 = new LinkedList<Duration>();

  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  newPos1 = newPos2 = newPos3 = -1;
  newTime = Instant.now();

  //Lecture Arduino
  if ( myPort.available() > 0) 
  {
    valSerial = myPort.readStringUntil('\n');
    if (valSerial != null) {
      valSerial = valSerial.trim();
      newPos1 = Integer.parseInt(valSerial);
    }
  } 

  //MAJ Listes
  if (newPos1 != -1 && newPos1 != lastPos1) {
    Duration newDur = Duration.between(lastTime1, newTime);

    if (prevPos1.size() >= maxLength && prevInterval1.size() >= maxLength) {
      prevPos1.removeFirst();
      prevInterval1.removeFirst();
    }
    prevPos1.add(newPos1);
    prevInterval1.add(newDur);

    lastPos1 = newPos1;
    lastTime1 = Instant.now();

    long DurTotal=1;
    for (Duration d : prevInterval1) {
      DurTotal += d.toMillis();
    }
    if (prevInterval1.size()!=0) {
      println(DurTotal/prevInterval1.size());
    }
  }



  clear();
  background(255, 204, 0);
  rect(50, 50, 500, 50);
  ellipse(25+50*lastPos1, 75, 50, 50);
}
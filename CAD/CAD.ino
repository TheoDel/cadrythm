/*********************************************************
  This code uses the MPR121 Adafruit library.
  It also works for Sparkfun MPR121. (the ones I used)

  Adapted by Theodel
**********************************************************/

#include <Wire.h>
#include <Servo.h>
#include "Adafruit_MPR121.h"

// Default address is 0x5A, if tied to 3.3V its 0x5B
// If tied to SDA its 0x5C and if SCL then 0x5D
Adafruit_MPR121 capA = Adafruit_MPR121();
Adafruit_MPR121 capB = Adafruit_MPR121();
Adafruit_MPR121 capC = Adafruit_MPR121();
int capAaddr = 0x5A;
int capBaddr = 0x5B;
int capCaddr = 0x5C;

int irqpin = 2;

// Keeps track of the last pins touched
// so we know when buttons are 'released'
uint16_t lasttouchedA = 0;
uint16_t currtouchedA = 0;
uint16_t lasttouchedB = 0;
uint16_t currtouchedB = 0;
uint16_t lasttouchedC = 0;
uint16_t currtouchedC = 0;

//Servomoteurs
Servo servoA;
Servo servoB;
Servo servoC;
int servoApin = 9;
int servoBpin = 10;
int servoCpin = 11;


void setup() {
  Serial.begin(9600);

  Serial.println("---Initialisation MPR121 Capacitive Touch sensor");
  boolean ok = false;
  if(!capA.begin(capAaddr)){
    Serial.println("capA not found !");
  } else {
    Serial.println("capA ok !");
  }
  
  if(!capB.begin(capBaddr)){
    Serial.println("capB not found !");
  } else {
    Serial.println("capB ok !");
  }

  if(!capC.begin(capCaddr)){
    Serial.println("capC not found !");
  } else {
    Serial.println("capC ok !");
  }

  servoA.attach(9);
  servoB.attach(10);
  servoC.attach(11);

  pinMode(irqpin, INPUT);
  digitalWrite(irqpin, HIGH); //enable pullup resistor
  Serial.println("---Setup end");
}

void loop() {
  if (!checkInterrupt()) {
    // Get the currently touched pads
    currtouchedA = capA.touched();

    for (uint8_t i = 0; i < 12; i++) {
      // it if *is* touched and *wasnt* touched before, alert!
      if ((currtouchedA & _BV(i)) && !(lasttouchedA & _BV(i)) ) {
        Serial.print("A");
        Serial.println(11-i);
        servoA.write(map(11-i, 0, 11, 0, 180));
      }
      // if it *was* touched and now *isnt*, alert!
      if (!(currtouchedA & _BV(i)) && (lasttouchedA & _BV(i)) ) {
        //Serial.print(i); Serial.println(" released");
      }
    }

    // reset our state
    lasttouchedA = currtouchedA;


    currtouchedB = capB.touched();
    for (uint8_t i = 0; i < 12; i++) {
      if ((currtouchedB & _BV(i)) && !(lasttouchedB & _BV(i)) ) {
        Serial.print("B");
        Serial.println(i);
        servoB.write(map(i, 0, 11, 0, 180));
      }
      if (!(currtouchedB & _BV(i)) && (lasttouchedB & _BV(i)) ) {
      }
    }
    lasttouchedB = currtouchedB;

    currtouchedC = capC.touched();
    for (uint8_t i = 0; i < 12; i++) {
      if ((currtouchedC & _BV(i)) && !(lasttouchedC & _BV(i)) ) {
        Serial.print("C");
        Serial.println(11-i);
        servoC.write(map(11-i, 0, 11, 0, 180));
      }
      if (!(currtouchedC & _BV(i)) && (lasttouchedC & _BV(i)) ) {
      }
    }
    lasttouchedC = currtouchedC;
    
  }
  delay(50);
}

boolean checkInterrupt(void){
  return digitalRead(irqpin);
}

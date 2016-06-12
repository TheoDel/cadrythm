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
uint16_t lasttouched = 0;
uint16_t currtouched = 0;

//Servomoteurs
Servo servoA;
Servo servoB;
Servo servoC;
int servoApin = 9;
int servoBpin = 10;
int servoCpin = 11;


void setup() {
  Serial.begin(9600);

  Serial.println("Initialisation MPR121 Capacitive Touch sensor");
  capA.begin(capAaddr);

  servoA.attach(9);

  pinMode(irqpin, INPUT);
  digitalWrite(irqpin, HIGH); //enable pullup resistor
  Serial.println("Fin du setup");
}

void loop() {
  if (!checkInterrupt()) {
    // Get the currently touched pads
    currtouched = capA.touched();

    for (uint8_t i = 0; i < 12; i++) {
      // it if *is* touched and *wasnt* touched before, alert!
      if ((currtouched & _BV(i)) && !(lasttouched & _BV(i)) ) {
        Serial.print(i); Serial.println(" touched");
        servoA.write(map(i, 0, 11, 0, 180));
      }
      // if it *was* touched and now *isnt*, alert!
      if (!(currtouched & _BV(i)) && (lasttouched & _BV(i)) ) {
        Serial.print(i); Serial.println(" released");
      }
    }

    // reset our state
    lasttouched = currtouched;
  }
  delay(50);
}

boolean checkInterrupt(void){
  return digitalRead(irqpin);
}

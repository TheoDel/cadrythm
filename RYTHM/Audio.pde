/*import processing.sound.*;
import processing.serial.*;
Serial arduino;
String valSerial;

AudioIn microJack;
Reverb reverb;
SoundFile soundfile;

void setup() {
  microJack = new AudioIn(this, 0); // create the input stream
  reverb = new Reverb(this); // créer l'effet réverbe
  microJack.play(); // start the input stream
  reverb.process(microJack);

  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  arduino = new Serial(this, portName, 4800); 

  soundfile = new SoundFile(this, "Fever_Ray_mono.aiff");
  soundfile.play();

  microJack.pan(-1.0); // lit le son du micro jack du coté gauche
  soundfile.pan(1.0);
}      

void draw() {
  if ( arduino.available() > 0) 
  {
    valSerial = arduino.readStringUntil('\n');
    if (valSerial != null) {
      valSerial = valSerial.replaceAll("[^0-9|,]", "");
      String[] l = valSerial.split(",");
      try {
        float valeur1 = Integer.parseInt(l[0]);
        float valeur2 = Integer.parseInt(l[1]);

        if ((valeur1<2048) && (valeur2<2048)) {
          float room=(1024-valeur1)/1024;
          float damp=0.3;
          float wet=(1024-valeur1)/1024;

          reverb.set(room, damp, wet); // applique une reverbe au son venant du micro jack
          
          float volume = 1-(1024-valeur2)/1024;
          soundfile.amp(volume); // volume entre 0.0 et 1.0
          println(valeur1, valeur2, room, wet, volume); // affiche les valeurs des 2 capteurs et les variables associées pour la réverbe
        }
      } 
      catch (ArrayIndexOutOfBoundsException e) {
        println("Array OOB");
      }
      catch (NumberFormatException e) {
        println("Number Exceptuon");
      }
    }
  }
}
void stop()
{
  super.stop();
}*/
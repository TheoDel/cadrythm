import java.time.*;
import java.util.LinkedList;
import java.math.*;

public class Cadran {
  private int maxLength=10;
  private int calculMoyenne=5;
  
  private int lastPos;
  
  /**
   * Time between the previous and new position
   */
  private Instant lastTime;
  
  /**
   * 10 last positions
   */
  private LinkedList<Integer> prevPos;
  
  /**
   * 10 last instants of positions
   */
  private LinkedList<Duration> prevInterval;
  
  public Cadran(){
    lastPos = (int)(Math.random()*11);
    lastTime = Instant.now();
    prevPos = new LinkedList<Integer>();
    prevInterval = new LinkedList<Duration>();
  }
  
  public void newInput(int newPos){
    Instant newTime = Instant.now();
    Duration newDur = Duration.between(lastTime, newTime);

      if (prevPos.size() >= maxLength && prevInterval.size() >= maxLength) {
        prevPos.removeLast();
        prevInterval.removeLast();
      }
      prevPos.add(0, newPos);
      prevInterval.add(0, newDur);

      lastPos = newPos;
      lastTime = Instant.now();
      /*
      print("[");
      for (Duration d : prevInterval) {
        print(d.toMillis());
        print(", ");
      }
      println("]");*/
  }
  
  public float vitesseMoyenne(){
    Instant newTime = Instant.now();
    Duration newDur = Duration.between(lastTime, newTime);
    float DurTotal=newDur.toMillis();
    
    if(prevInterval.size()>0){
      int nbelem = min(calculMoyenne, prevInterval.size());
      
      for(int i=0; i<nbelem; i++){
        DurTotal += prevInterval.get(i).toMillis();
      }
      /*
      for (Duration d : prevInterval) {
        DurTotal += d.toMillis();
      }*/
      float moy = 1000.0/(DurTotal/(float)(nbelem+1));
      return moy;
    } else {
      return 0;
    }
  }
  
  public int ecartAvec(Cadran cadranB){
    return lastPos-cadranB.getLastPos();
  }
  
  public int getLastPos() {
    return lastPos;
  }
}
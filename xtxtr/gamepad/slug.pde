class Gesture {
  float angle_in;
  float slug;
  float step;
  int steps;
  int angle;
  int pangle;
  int nudge;
  int rotary;
  int delay;
  float dsq;
  boolean home; // joy @ center
  boolean phome;
  int [] foo = {1, 2, 3, 5, 8, 7, 6, 4}; 
  long numtype;
  Gesture( float STEP) {
    slug=0; 
    step=STEP;
  }

  void thing(float x, float y) {
    dsq=x*x+y*y;
    home = dsq<0.15 ? true : dsq>0.45 ? false : home;
    if (!home) {
      angle_in=(405+22.5-degrees(atan2(x, y)+PI))%360;
      if (step<abs(slug-angle_in)) {
        slug=angle_in;
        angle = int(slug/step/3);
      }
      if (phome) {
        nudge = pangle = angle;
        rotary=0;
        numtype*=10;
        numtype+=foo[nudge];
        println(numtype);
      } else {
        int temp = angle - pangle;
        if (abs(temp)>=6) {
          temp+=angle>pangle?-8:8;
        }
        rotary += temp;
        if(temp==0){
          delay++;
        }
        if(delay==10){
          // here render words from dictionary
        }
      }
    }
    if (home && !phome) {
      delay=0;
      if (rotary>0) { 
        // here output selected word
        numtype=0;
      }
    }
    pangle=angle;
    phome=home;
  }
}
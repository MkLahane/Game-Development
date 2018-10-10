import java.util.*;

float scl = 0;
float biggest = 0;
NavigableMap<Integer, Float> recamanSeqHash;
int i = 0;
int step = 1;
ArrayList<Arc> arcs;

class Arc {
  float start;
  float end;
  float dir;
  Arc(float _start, float _end, float _dir) {
    start = _start;
    end = _end;
    dir = _dir;
  } 

  void show() {
    float diameter = abs(end - start);
    float x = (end + start) / 2;
    stroke(0);
    noFill();
    strokeWeight(0.5);
    if (dir == 0) {
      arc(x, 0, diameter, diameter, -PI, 0);
    } else {
      arc(x, 0, diameter, diameter, 0, PI);
    }
  }
} 


void setup() {
  size(1000, 700);
  //fullScreen();
  arcs = new ArrayList<Arc>();
  recamanSeqHash = new TreeMap<Integer, Float>();
  background(255);
  recamanSeqHash.put(0, 0.0);
  
}



void addNumber() {
  if (i < 10000000) {
    i++;
  } 
  Map.Entry<Integer, Float> current = recamanSeqHash.lastEntry();

  float next = current.getValue() - step;
  int isLandingKey = current.getKey() - step;
  if (next < 0 || recamanSeqHash.containsValue(next)) {
    next = current.getValue() + step;
  }

  arcs.add(new Arc(current.getValue(), next, step % 2));
  if (biggest < next) {
    biggest = next;
  } 
  recamanSeqHash.put(i, next);
  step++;
} 


void draw() {
  background(255);
  addNumber();
  translate(0, height / 2);
  scl = lerp(scl, width / biggest, 0.1);
  scale(scl);
  for (Arc a : arcs) {
    a.show();
  }
  println(frameRate);
} 
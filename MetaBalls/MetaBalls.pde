MetaBall metaBalls[]=new MetaBall[2];

void setup() {
  size(1300, 700);
  for (int i=0; i<metaBalls.length; i++) {
    metaBalls[i]=new MetaBall(random(width), random(height));
  }
} 


void draw() {
  background(0); 
  loadPixels();
  for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
      float sum=0;
      int index=i+j*width;
      for (MetaBall m : metaBalls) {
        float d=dist(i, j, m.loc.x, m.loc.y);
        sum+=150*m.r/d;
      }
      pixels[index]=color(sum);
    }
  } 
  updatePixels();
  for (MetaBall m : metaBalls) {
    //m.show();
    m.update();
  }
} 

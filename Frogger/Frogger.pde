
Frog frog;
Car cars[];
Log logs[];
float grid=50;

void setup() {
  size(500,500);
  cars=new Car[8];
  logs=new Log[7];
  
  int index=0;
  //ROW 1
  reset();
  for(int i=0;i<2;i++) {
    float x=i*300;
    cars[index] =new Car(x,height-grid*2,grid*2,grid,2);
    index++;
  }
  //ROW2
  for(int i=0;i<2;i++) {
    float x=i*200+100;
    cars[index] =new Car(x,height-grid*3,grid,grid,3.5);
    index++;
  }
  //ROW3
  for(int i=0;i<4;i++) {
    float x=i*150+150;
    cars[index] =new Car(x,height-grid*4,grid,grid,1);
    index++;
  }
  
  //ROW5
  index=0;
  for(int i=0;i<2;i++) {
    float x=i*250+100;
    logs[index] =new Log(x,height-grid*6,grid*3,grid,2.7);
    index++;
  }
  //ROW6

  for(int i=0;i<3;i++) {
    float x=i*200+30;
    logs[index] =new Log(x,height-grid*7,grid*3,grid,1);
    index++;
  }
  //ROW6

  for(int i=0;i<2;i++) {
    float x=i*400+10;
    logs[index] =new Log(x,height-grid*8,grid*3,grid,1);
    index++;
  }
  
  
} 


void reset() {
  frog=new Frog(width/2-grid/2,height-grid,grid);
  frog.attach(null);
  
} 
void draw() {
  background(0);
  fill(215,100);
  rect(0,height-grid,width,grid);
  rect(0,height-grid*5,width,grid);
  rect(0,0,width,grid*2);
  
  for(Car car:cars) {
    car.show();
    car.updateCar();
    if(car.intersects(frog)) {
      reset();
    } 
  }
 
  for(Log log:logs) {
    log.updateCar();
    log.show();

  } 
  if(frog.y<height-grid*5 && frog.y>grid*2) {
    boolean ok=false;
    for(Log log:logs) {
      if(frog.intersects(log)) {
        ok=true;
        frog.attach(log);
        //frog.x+=log.speed;
      } 
      
    } 
    frog.updateByLog();
    if(!ok) {
        reset();
    } 
  } else {
    frog.attach(null);
  } 
  
 
  frog.show();
  
  
} 

void keyPressed() {
  if(keyCode==UP) {
    frog.move(0,-1);
  } else if(keyCode==DOWN) {
    frog.move(0,1);
    
  } else if(keyCode==RIGHT) {
    frog.move(1,0);
  }else if(keyCode==LEFT) {
    frog.move(-1,0);
  } 
  
} 
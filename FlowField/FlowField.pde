boolean debug = false;

// Flowfield object
Flow flowfield;
// An ArrayList of vehicles
ArrayList<Vehicle> vehicles;

void setup() {
  size(1200, 700);
  smooth();
  // Make a new flow field with "resolution" of 16
  flowfield = new Flow(10);
  vehicles = new ArrayList<Vehicle>();
  // Make a whole bunch of vehicles with random maxspeed and maxforce values
  for (int i = 0; i < 1; i++) {
    vehicles.add(new Vehicle(new PVector(random(width), random(height)), random(1,5), random(0.1, 0.5)));
  }
  background(255);
}

void draw() {
  
  vehicles.add(new Vehicle(new PVector(random(width), random(height)), random(1,5), random(0.1, 0.5)));
  
  
  // Display the flowfield in "debug" mode
  if (debug) flowfield.display();
  // Tell all the vehicles to follow the flow field
  for (Vehicle v : vehicles) {
    v.follow(flowfield);
    v.run();
  }

  // Instructions
  fill(0);
  text("Hit space bar to toggle debugging lines.\nClick the mouse to generate a new flow field.",10,height-20);
}


void keyPressed() {
  if (key == ' ') {
    debug = !debug;
  }
}

// Make a new flowfield
void mousePressed() {
  flowfield.init();
}

void mouseDragged() {
  vehicles.add(new Vehicle(new PVector(mouseX,mouseY),random(5,10),random(0.1,0.5)));
} 
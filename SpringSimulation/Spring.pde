class Spring {
  ArrayList<Particle> nodes;
  PVector anchor;
  float k = 0.01;
  int restLength;
  float springLength;
  Spring(PVector _anchor, int numOfNodes, int lengthOfSpring) {
    nodes = new ArrayList<Particle>();
    restLength = floor(lengthOfSpring / numOfNodes);
    anchor = _anchor.get();
    springLength = lengthOfSpring;
    for (int i = 0; i < numOfNodes; i++) {
      float x = random(anchor.x - restLength, anchor.x + restLength);
      float y = i * restLength + restLength;
      nodes.add(new Particle(new PVector(x, y)));
    } 
  } 
  void show() {
    stroke(0, 200);
    strokeWeight(6);
    line(anchor.x, anchor.y, nodes.get(0).pos.x, nodes.get(0).pos.y);
    for (int i = 0; i < nodes.size() - 1; i++) {
      line(nodes.get(i).pos.x, nodes.get(i).pos.y, nodes.get(i + 1).pos.x, nodes.get(i + 1).pos.y);
    } 
    rectMode(CENTER);
    //rect(anchor.x, anchor.y, 20, 20);
    noStroke();
    for (Particle node : nodes) {
      //node.show();
    }
  } 
  PVector generalSpringForce(PVector fixed, PVector movable) {
    PVector springForce = PVector.sub(movable, fixed);
    float currentLength = springForce.mag();
    springForce.normalize();
    float changeInLength = currentLength - restLength;
    float changeInX = movable.x - fixed.x;
    float changeInY = movable.y - fixed.y;
    springForce.x = -k * changeInX;
    springForce.y = -k * changeInY;
    //springForce.mult(changeInLength * -k);
    return springForce;
  } 
  void update() {
    for (Particle node : nodes) {
      node.update();
      //gravity
      node.applyForce(new PVector(0, 0.5));
    }
  }
  void springSim() {
    PVector startingNodeForce = generalSpringForce(anchor, nodes.get(0).pos);
    nodes.get(0).applyForce(startingNodeForce);
    for (int i = 1; i < nodes.size(); i++) {
      PVector springForce = generalSpringForce(nodes.get(i - 1).pos, nodes.get(i).pos);
      nodes.get(i).applyForce(springForce);
    }
  }
} 

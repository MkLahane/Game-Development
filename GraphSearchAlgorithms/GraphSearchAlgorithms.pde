Graph graph;
int counter = 0;
int edgingNodeIndex = -1;
boolean addingEdge = false;
int startNodeIndex = -1;
int endNodeIndex = -1;
int[] previousEdge = {-1, -1};
Button DFS;
Button BFS;
Button CLEAR;
Button HILLCLIMB;
Button DIJKSTRA;
Button BEAM;
Button ASTAR;
int totalCost = 0;
ArrayList<Node> path;
void setup() {
  size(1400, 750);
  graph = new Graph();
  path = new ArrayList<Node>();
  DFS = new Button("Dfs", new PVector(width - 150, 50), 100, 50);

  BFS = new Button("Bfs", new PVector(width - 150, 150), 100, 50);

  HILLCLIMB = new Button("HillClimb", new PVector(width - 200, 250), 150, 50);

  DIJKSTRA = new Button("Dijkstra", new PVector(width - 200, 350), 150, 50);

  BEAM = new Button("Beam", new PVector(width - 150, 450), 100, 50);

  ASTAR = new Button("Astar", new PVector(width - 150, 550), 100, 50);

  CLEAR = new Button("CLEAR", new PVector(width - 150, 650), 100, 50);


  //for (int i = 0; i < 100; i++) {
  //  graph.addNode(new PVector(random(30, width - 330), random(30, height - 40)));
  //} 
  //for (int i = 0; i < 300; i++) {
  //  int r1 = floor(random(0, graph.nodes.size() - 1));
  //  int r2 = floor(random(0, graph.nodes.size() - 1));
  //  graph.addEdge(graph.nodes.get(r1), graph.nodes.get(r2));
  //}
} 

void drawPath() {
  if (path == null) {
    return;
  } 
  stroke(0, 255, 0);
  strokeWeight(2);
  noFill();
  beginShape();
  for (Node node : path) {
    vertex(node.pos.x, node.pos.y);
  } 
  endShape();
} 


void draw() {
  background(255);
  stroke(0);
  strokeWeight(2);
  fill(255);
  rect(20, 20, width - 300, height - 50);
  int sum = 0;
  if (path != null) {
    for (int i = 1; i < path.size(); i++) {
      sum += PVector.dist(path.get(i).pos, path.get(i - 1).pos);
    }
  }
  totalCost = sum;
  //if (path != null && !path.isEmpty()) {
  fill(0);
  textSize(20);
  text("Total Cost:"+totalCost, 120, 40);
  //} 
  graph.show();
  drawPath();
  DFS.show();
  BFS.show();
  HILLCLIMB.show();
  DIJKSTRA.show();
  BEAM.show();
  ASTAR.show();
  CLEAR.show();
} 

void initNodes() {
  for (Node node : graph.nodes) {
    node.parent = null;
    node.visited = false;
    node.dijDist = 100000000;
    node.gCost = 100000000;
    node.fCost = 100000000;
  }
}

void mousePressed() {
  if (DFS.pressed() && startNodeIndex != -1 && endNodeIndex != -1) {
    initNodes();
    path = dfs();
    return;
  } 
  if (CLEAR.pressed()) {
    path.clear();
    return;
  } 
  if (BFS.pressed() && startNodeIndex != -1. && endNodeIndex != -1) {
    initNodes();
    path = bfs();
    return;
  } 
  if (HILLCLIMB.pressed() && startNodeIndex != -1. && endNodeIndex != -1) {
    initNodes();
    path = hillClimb();
    return;
  } 
  if (DIJKSTRA.pressed() && startNodeIndex != -1. && endNodeIndex != -1) {
    initNodes();
    path = dijkstra();
    return;
  } 
  if (BEAM.pressed() && startNodeIndex != -1. && endNodeIndex != -1) {
    initNodes();
    path = beam();
    return;
  }
  if (ASTAR.pressed() && startNodeIndex != -1. && endNodeIndex != -1) {
    initNodes();
    path = astar();
    return;
  }
  for (int i = 0; i < graph.nodes.size(); i++) {
    Node node = graph.nodes.get(i);
    float d = dist(node.pos.x, node.pos.y, mouseX, mouseY);
    if (d <= 10) {
      addingEdge = true;
      edgingNodeIndex = i;
      return;
    }
  } 
  if (mouseX >= 30 && mouseX < width - 330 && mouseY >= 30 && mouseY < height - 40) {
    graph.addNode(new PVector(mouseX, mouseY));
    counter++;
  }
}

void keyPressed() {
  char keyChar = key;
  if (keyChar == 'z') {
    graph.nodes.remove(graph.nodes.get(graph.nodes.size() - 1));
    return;
  } 
  for (int i = 0; i < graph.nodes.size(); i++) {
    Node node = graph.nodes.get(i);
    float d = PVector.dist(node.pos, new PVector(mouseX, mouseY));
    if (d <= 10) {
      if (keyChar == 's') {
        if (startNodeIndex >= 0) {
          graph.nodes.get(startNodeIndex).col = color(0, 0, 0);
        }
        startNodeIndex = i;
        graph.nodes.get(startNodeIndex).col = color(255, 0, 0);
        return;
      } else if (keyChar == 'e') {
        if (endNodeIndex >= 0) {
          graph.nodes.get(endNodeIndex).col = color(0, 0, 0);
        }
        endNodeIndex = i;
        graph.nodes.get(endNodeIndex).col = color(0, 0, 255);
        return;
      }
    }
  }
} 

void mouseReleased() {
  if (addingEdge == true) {
    for (int i = 0; i < graph.nodes.size(); i++) {
      Node node = graph.nodes.get(i);
      float d = dist(node.pos.x, node.pos.y, mouseX, mouseY);
      if (d <= 10) {
        addingEdge = false;
        if (node.edges.contains(graph.nodes.get(edgingNodeIndex))) {
          return;
        } 
        previousEdge[0] = edgingNodeIndex;
        previousEdge[1] = i; 
        graph.addEdge(graph.nodes.get(edgingNodeIndex), graph.nodes.get(i));
        edgingNodeIndex = -1;
        return;
      }
    }
  }
} 
